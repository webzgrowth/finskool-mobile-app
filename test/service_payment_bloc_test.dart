import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/usecases/services/get_gst_states.dart';
import 'package:finskool/src/domain/usecases/services/get_last_billing.dart';
import 'package:finskool/src/domain/usecases/services/remember_billing.dart';
import 'package:finskool/src/domain/usecases/services/start_service_payment.dart';
import 'package:finskool/src/domain/usecases/services/verify_service_payment.dart';
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/payment/service_payment_bloc.dart';

/// Only the payment calls do anything; the rest of the (large) contract is
/// never reached, so it is left to `noSuchMethod`.
class _Repo implements ServicesRepository {
  Either<Failure, PaymentOrder> order = const Right(
    PaymentOrder(
      orderId: 'order_1',
      amountPaise: 1416000,
      currency: 'INR',
      keyId: 'rzp_test_x',
      quoteId: 'q1',
      requestId: 'r1',
    ),
  );

  /// One result per `/verify` call; the last repeats.
  List<Either<Failure, ServiceRequestModel>> verifies = [];
  int verifyCalls = 0;
  int orderCalls = 0;
  BillingDetails? remembered;

  @override
  Future<Either<Failure, PaymentOrder>> startPayment({
    required String requestId,
    required String quoteId,
    required BillingDetails billing,
  }) async {
    orderCalls++;
    return order;
  }

  @override
  Future<Either<Failure, ServiceRequestModel>> verifyPayment({
    required String requestId,
    required PaymentProof proof,
  }) async {
    final i = verifyCalls < verifies.length ? verifyCalls : verifies.length - 1;
    verifyCalls++;
    return verifies[i];
  }

  @override
  Future<Either<Failure, List<GstState>>> getGstStates() async =>
      const Right([GstState(code: '27', name: 'Maharashtra')]);

  @override
  BillingDetails? get lastBilling => remembered;

  @override
  Future<void> rememberBilling(BillingDetails billing) async =>
      remembered = billing;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

ServiceRequestModel _request({
  ServiceStatus status = ServiceStatus.paid,
  bool invoice = true,
}) => ServiceRequestModel(
  id: 'r1',
  label: 'SR-12',
  serviceId: 's',
  serviceTitle: 'Portfolio Analysis',
  status: status,
  createdAt: DateTime(2026, 11, 2),
  lastMessageAt: DateTime(2026, 11, 2),
  invoice: invoice
      ? const ServiceInvoiceRef(
          id: 'i',
          number: 'FS/2026-27/0001',
          total: 14160,
        )
      : null,
);

void main() {
  const billing = BillingDetails(name: 'Priya', stateCode: '27');
  const proof = PaymentProof(orderId: 'o', paymentId: 'p', signature: 's');
  final quote = ServiceQuoteModel(
    id: 'q1',
    requestId: 'r1',
    version: 1,
    baseAmount: 12000,
    gstRatePercent: 18,
    gstAmount: 2160,
    totalAmount: 14160,
    status: ServiceQuoteStatus.active,
    expiresAt: DateTime(2026, 12, 1),
  );

  late _Repo repo;
  late ServicePaymentBloc bloc;

  setUp(() {
    ServicePaymentBloc.verifyRetryBase = Duration.zero;
    repo = _Repo();
    bloc = ServicePaymentBloc(
      GetGstStates(repo),
      StartServicePayment(repo),
      VerifyServicePayment(repo),
      GetLastBilling(repo),
      RememberBilling(repo),
    );
  });
  tearDown(() => bloc.close());

  Future<void> settle(PaymentStep step) => bloc.stream
      .firstWhere((s) => s.step == step)
      .timeout(const Duration(seconds: 2));

  Future<void> payAndCheckout() async {
    bloc.add(
      ServicePaymentEvent.payTapped(
        requestId: 'r1',
        quote: quote,
        billing: billing,
      ),
    );
    await settle(PaymentStep.awaitingCheckout);
  }

  test('pay creates the order and remembers the accepted billing', () async {
    await payAndCheckout();
    expect(bloc.state.order?.orderId, 'order_1');
    expect(bloc.state.order?.amountPaise, 1416000);
    expect(repo.remembered?.name, 'Priya');
  });

  test('a double tap on Pay creates one order', () async {
    bloc.add(
      ServicePaymentEvent.payTapped(
        requestId: 'r1',
        quote: quote,
        billing: billing,
      ),
    );
    bloc.add(
      ServicePaymentEvent.payTapped(
        requestId: 'r1',
        quote: quote,
        billing: billing,
      ),
    );
    await settle(PaymentStep.awaitingCheckout);
    expect(repo.orderCalls, 1);
  });

  test(
    'a 422 puts each message on its own field and remembers nothing',
    () async {
      repo.order = const Left(
        ValidationFailure(
          'Invalid',
          errors: {
            'billing.gstin': ['GSTIN does not match the state'],
            'billing.stateCode': ['Unknown state'],
          },
        ),
      );
      bloc.add(
        ServicePaymentEvent.payTapped(
          requestId: 'r1',
          quote: quote,
          billing: billing,
        ),
      );
      await settle(PaymentStep.idle);
      expect(bloc.state.billingErrors, {
        'gstin': 'GSTIN does not match the state',
        'state': 'Unknown state',
      });
      expect(repo.remembered, isNull);
    },
  );

  test('an expired quote tells the chat to refresh', () async {
    repo.order = const Left(
      ServerFailure('Quote expired', code: 'QUOTE_EXPIRED'),
    );
    bloc.add(
      ServicePaymentEvent.payTapped(
        requestId: 'r1',
        quote: quote,
        billing: billing,
      ),
    );
    await settle(PaymentStep.idle);
    expect(bloc.state.staleQuote, isTrue);
    expect(bloc.state.message, 'Quote expired');
  });

  test('paid WITH an invoice is done', () async {
    repo.verifies = [Right(_request())];
    await payAndCheckout();
    bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
    await settle(PaymentStep.done);
    expect(bloc.state.paid?.invoice?.number, 'FS/2026-27/0001');
  });

  test(
    'not paid (replaced/expired mid-payment) is UNDER REVIEW, never done',
    () async {
      repo.verifies = [
        Right(_request(status: ServiceStatus.quoteSent, invoice: false)),
      ];
      await payAndCheckout();
      bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
      await settle(PaymentStep.underReview);
      expect(bloc.state.paid, isNull);
      expect(bloc.state.pendingProof, isNull); // nothing to retry or pay again
      expect(bloc.state.staleQuote, isTrue);
    },
  );

  test('a paid status without an invoice is not trusted as done', () async {
    repo.verifies = [Right(_request(invoice: false))];
    await payAndCheckout();
    bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
    await settle(PaymentStep.underReview);
  });

  test('network errors are retried, then it succeeds', () async {
    repo.verifies = [
      const Left(ConnectionFailure('No internet connection.')),
      const Left(ConnectionFailure('No internet connection.')),
      Right(_request()),
    ];
    await payAndCheckout();
    bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
    await settle(PaymentStep.done);
    expect(repo.verifyCalls, 3);
  });

  test(
    'network errors forever: keeps the proof and refetches the request',
    () async {
      repo.verifies = [
        const Left(ConnectionFailure('No internet connection.')),
      ];
      await payAndCheckout();
      bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
      await settle(PaymentStep.verifyFailed);
      expect(repo.verifyCalls, 5);
      expect(bloc.state.pendingProof, proof);
      expect(bloc.state.staleQuote, isTrue);
    },
  );

  test('a bad signature is final: no retry, no proof kept', () async {
    repo.verifies = [
      const Left(ServerFailure('bad', code: 'PAYMENT_SIGNATURE_INVALID')),
    ];
    await payAndCheckout();
    bloc.add(const ServicePaymentEvent.checkoutSucceeded(proof));
    await settle(PaymentStep.verifyFailed);
    expect(repo.verifyCalls, 1);
    expect(bloc.state.pendingProof, isNull);
  });

  test(
    'cancelling Checkout leaves the quote payable and says nothing',
    () async {
      await payAndCheckout();
      bloc.add(const ServicePaymentEvent.checkoutDismissed());
      await settle(PaymentStep.idle);
      expect(bloc.state.message, isEmpty);
      expect(repo.verifyCalls, 0);
    },
  );

  test('opening the sheet pre-fills the last billing details', () async {
    repo.remembered = billing;
    bloc.add(const ServicePaymentEvent.statesRequested());
    await bloc.stream.firstWhere((s) => s.lastBilling != null);
    expect(bloc.state.lastBilling?.stateCode, '27');
  });

  test('Pay is offered only for an active quote on a quote_sent request', () {
    final s = ServiceChatState.initial();
    final base = _request(
      status: ServiceStatus.quoteSent,
      invoice: false,
    ).copyWith(quote: quote);
    expect(s.copyWith(request: base).payableQuote?.id, 'q1');
    final requested = ServiceRequestModel(
      id: 'r1',
      label: 'SR-12',
      serviceId: 's',
      serviceTitle: 'x',
      status: ServiceStatus.requested,
      createdAt: DateTime(2026),
      lastMessageAt: DateTime(2026),
      quote: quote,
    );
    expect(s.copyWith(request: requested).payableQuote, isNull);
  });
}
