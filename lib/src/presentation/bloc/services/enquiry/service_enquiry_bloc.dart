import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:uuid/uuid.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/usecases/services/create_service_request.dart';
import 'package:finskool/src/domain/usecases/services/get_service_requests.dart';

part 'service_enquiry_event.dart';
part 'service_enquiry_state.dart';
part 'service_enquiry_bloc.freezed.dart';

/// "Enquire now": opens a service request in one tap and says whether it
/// worked.
///
/// Figma goes straight from the button to the "Enquiry submitted" popup, with
/// no form, so the request's `needs` is a short standard line and the
/// conversation (with its quote) happens in the chat afterwards.
///
/// **The idempotency key is the point.** It is minted once per service and
/// *reused on a retry* — a double tap or a dropped connection must not open a
/// second request. A different service gets a different key.
@injectable
class ServiceEnquiryBloc
    extends Bloc<ServiceEnquiryEvent, ServiceEnquiryState> {
  ServiceEnquiryBloc(this._create, this._getRequests)
    : super(ServiceEnquiryState.initial()) {
    on<ServiceEnquiryEvent>((event, emit) async {
      await event.map(
        submitted: (e) => _submit(e.service, emit),
        dismissed: (_) async => emit(ServiceEnquiryState.initial()),
      );
    });
  }

  final CreateServiceRequest _create;
  final GetServiceRequests _getRequests;

  static const _uuid = Uuid();

  /// service id → the key for its in-flight or last-failed attempt.
  final Map<String, String> _keys = {};

  Future<void> _submit(
    ServiceModel service,
    Emitter<ServiceEnquiryState> emit,
  ) async {
    if (state.submit.isLoading) return; // a double tap is not a second request
    emit(
      state.copyWith(
        submit: RequestState.loading,
        message: '',
        request: null,
        existing: false,
      ),
    );

    final key = _keys.putIfAbsent(service.id, _uuid.v4);
    final result = await _create.execute(
      idempotencyKey: key,
      serviceId: service.id,
      needs: "Hi, I'd like to enquire about ${service.title} and its pricing.",
    );

    await result.fold(
      (failure) async {
        if (failure.code == 'SERVICE_REQUEST_ALREADY_OPEN') {
          _keys.remove(service.id);
          await _openExisting(service, failure.message, emit);
          return;
        }
        // The key is kept: a retry of *this* enquiry must reuse it.
        emit(
          state.copyWith(submit: RequestState.error, message: failure.message),
        );
      },
      (request) async {
        _keys.remove(service.id); // done — a later enquiry is a new one
        emit(state.copyWith(submit: RequestState.loaded, request: request));
      },
    );
  }

  /// The member already has an open request for this service; take them to it
  /// instead of leaving them at a dead end.
  Future<void> _openExisting(
    ServiceModel service,
    String serverMessage,
    Emitter<ServiceEnquiryState> emit,
  ) async {
    final page = await _getRequests.execute();
    final found = page.fold(
      (_) => null,
      (p) => p.items
          .where((r) => r.serviceId == service.id && !r.isClosed)
          .firstOrNull,
    );
    emit(
      found == null
          ? state.copyWith(submit: RequestState.error, message: serverMessage)
          : state.copyWith(
              submit: RequestState.loaded,
              request: found,
              existing: true,
            ),
    );
  }
}
