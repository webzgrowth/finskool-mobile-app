import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/usecases/services/get_gst_states.dart';
import 'package:finskool/src/domain/usecases/services/start_service_payment.dart';
import 'package:finskool/src/domain/usecases/services/verify_service_payment.dart';

part 'service_payment_event.dart';
part 'service_payment_state.dart';
part 'service_payment_bloc.freezed.dart';

/// Paying a quote: billing details → a Razorpay order → Checkout → verify.
///
/// The Checkout SDK is a plugin, so *it* is driven from the widget layer; this
/// bloc owns the steps either side of it and is told what Checkout did. Per
/// the spec: **trust the server, not Checkout** — a "success" callback only
/// means the member paid, and the request is `paid` once `verify` (or
/// Razorpay's webhook) has run. `/pay` and `/verify` are both safe to repeat,
/// so retrying them is not a risk.
@injectable
class ServicePaymentBloc
    extends Bloc<ServicePaymentEvent, ServicePaymentState> {
  ServicePaymentBloc(this._getStates, this._start, this._verify)
    : super(ServicePaymentState.initial()) {
    on<ServicePaymentEvent>((event, emit) async {
      await event.map(
        statesRequested: (_) => _loadStates(emit),
        payTapped: (e) => _begin(e.requestId, e.quote, e.billing, emit),
        checkoutSucceeded: (e) => _confirm(e.proof, emit),
        checkoutFailed: (e) async => emit(
          state.copyWith(
            step: PaymentStep.idle,
            message: e.message,
            order: null,
          ),
        ),
        checkoutDismissed: (_) async => emit(
          // Nothing to confirm; the card is still payable.
          state.copyWith(step: PaymentStep.idle, order: null),
        ),
        reset: (_) async =>
            emit(ServicePaymentState.initial().copyWith(states: state.states)),
      );
    });
  }

  final GetGstStates _getStates;
  final StartServicePayment _start;
  final VerifyServicePayment _verify;

  String _requestId = '';

  Future<void> _loadStates(Emitter<ServicePaymentState> emit) async {
    if (state.states.isNotEmpty) return;
    final result = await _getStates.execute();
    result.fold(
      (f) => emit(
        state.copyWith(statesLoad: RequestState.error, message: f.message),
      ),
      (list) =>
          emit(state.copyWith(statesLoad: RequestState.loaded, states: list)),
    );
  }

  Future<void> _begin(
    String requestId,
    ServiceQuoteModel quote,
    BillingDetails billing,
    Emitter<ServicePaymentState> emit,
  ) async {
    if (state.step.isBusy) return; // a double tap must not start two orders
    _requestId = requestId;
    emit(
      state.copyWith(
        step: PaymentStep.creatingOrder,
        message: '',
        billingErrors: const {},
        order: null,
      ),
    );
    final result = await _start.execute(
      requestId: requestId,
      quoteId: quote.id,
      billing: billing,
    );
    result.fold(
      (failure) => emit(
        state.copyWith(
          step: PaymentStep.idle,
          message: failure.message,
          billingErrors: _billingErrors(failure),
          // The quote went stale under the member: the chat is told to
          // refresh so the card shows why.
          staleQuote: _isStale(failure.code),
        ),
      ),
      (order) => emit(
        state.copyWith(step: PaymentStep.awaitingCheckout, order: order),
      ),
    );
  }

  Future<void> _confirm(
    PaymentProof proof,
    Emitter<ServicePaymentState> emit,
  ) async {
    emit(state.copyWith(step: PaymentStep.verifying, message: ''));
    final result = await _verify.execute(requestId: _requestId, proof: proof);
    result.fold(
      (failure) => emit(
        // **Retry is safe** (verify is idempotent); keep the proof so the
        // sheet can offer it. A bad signature is the one case not to retry.
        state.copyWith(
          step: PaymentStep.verifyFailed,
          message: failure.message,
          pendingProof: failure.code == 'PAYMENT_SIGNATURE_INVALID'
              ? null
              : proof,
        ),
      ),
      (request) => emit(
        state.copyWith(
          step: PaymentStep.done,
          paid: request,
          pendingProof: null,
        ),
      ),
    );
  }

  static bool _isStale(String? code) =>
      code == 'QUOTE_EXPIRED' ||
      code == 'QUOTE_NOT_PAYABLE' ||
      code == 'SERVICE_ALREADY_PAID' ||
      code == 'SERVICE_CLOSED';

  /// A 422's errors sit under `billing`; the sheet shows them by the field.
  static Map<String, String> _billingErrors(Failure failure) {
    if (failure is! ValidationFailure) return const {};
    final all = failure.errors.values.expand((e) => e).toList();
    return all.isEmpty ? const {} : {'billing': all.first};
  }
}
