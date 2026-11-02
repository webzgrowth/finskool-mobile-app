part of 'service_payment_bloc.dart';

enum PaymentStep {
  idle,
  creatingOrder,
  awaitingCheckout,
  verifying,

  /// `verify` could not be confirmed (network, after retries). The proof is
  /// kept; the server may already have it through Razorpay's webhook.
  verifyFailed,

  /// The money arrived but the server could not apply it (the quote was
  /// replaced or expired while the member paid). Never offer to pay again.
  underReview,
  done,
}

extension PaymentStepX on PaymentStep {
  /// A call is in flight, or Checkout is open: ignore a second Pay tap.
  bool get isBusy =>
      this == PaymentStep.creatingOrder ||
      this == PaymentStep.awaitingCheckout ||
      this == PaymentStep.verifying;
}

@freezed
sealed class ServicePaymentState with _$ServicePaymentState {
  const factory ServicePaymentState({
    required PaymentStep step,
    required RequestState statesLoad,
    required List<GstState> states,
    required String message,
    required Map<String, String> billingErrors,

    /// The quote was replaced, expired or already paid while the sheet was
    /// open — the chat should refetch so the card says so.
    required bool staleQuote,

    /// The billing details last used, to pre-fill the sheet.
    BillingDetails? lastBilling,
    PaymentOrder? order,
    PaymentProof? pendingProof,

    /// The request as the server now has it: `paid`, with its invoice.
    ServiceRequestModel? paid,
  }) = _ServicePaymentState;

  factory ServicePaymentState.initial() => const ServicePaymentState(
    step: PaymentStep.idle,
    statesLoad: RequestState.empty,
    states: [],
    message: '',
    billingErrors: {},
    staleQuote: false,
  );
}
