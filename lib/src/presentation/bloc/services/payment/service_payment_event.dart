part of 'service_payment_bloc.dart';

@freezed
class ServicePaymentEvent with _$ServicePaymentEvent {
  /// Loads the state picker (once).
  const factory ServicePaymentEvent.statesRequested() = _StatesRequested;

  /// Pay was tapped with billing details confirmed.
  const factory ServicePaymentEvent.payTapped({
    required String requestId,
    required ServiceQuoteModel quote,
    required BillingDetails billing,
  }) = _PayTapped;

  /// Checkout returned success; confirm it with the server.
  const factory ServicePaymentEvent.checkoutSucceeded(PaymentProof proof) =
      _CheckoutSucceeded;

  /// Checkout reported an error (not a cancel).
  const factory ServicePaymentEvent.checkoutFailed(String message) =
      _CheckoutFailed;

  /// The member closed Checkout without paying.
  const factory ServicePaymentEvent.checkoutDismissed() = _CheckoutDismissed;

  const factory ServicePaymentEvent.reset() = _Reset;
}
