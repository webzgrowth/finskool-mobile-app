import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// A thin owner of one [Razorpay] instance.
///
/// It reports **what Checkout said, nothing more**: success carries the three
/// values the server verifies, and the server — not this callback — decides
/// whether the payment counts. A closed sheet is [onDismissed], not an error.
class RazorpayCheckout {
  RazorpayCheckout({
    required this.onSuccess,
    required this.onError,
    required this.onDismissed,
  }) {
    _razorpay
      ..on(Razorpay.EVENT_PAYMENT_SUCCESS, _success)
      ..on(Razorpay.EVENT_PAYMENT_ERROR, _error)
      // Wallets hand over to their own app and report nothing we can verify.
      ..on(Razorpay.EVENT_EXTERNAL_WALLET, (_) {});
  }

  final void Function(PaymentProof proof) onSuccess;
  final void Function(String message) onError;
  final void Function() onDismissed;

  final _razorpay = Razorpay();

  void open(
    PaymentOrder order, {
    required String title,
    String? email,
    String? phone,
  }) {
    _razorpay.open({
      'key': order.keyId,
      'order_id': order.orderId,
      'amount': order.amountPaise,
      'currency': order.currency,
      'name': 'Finskool21',
      'description': title,
      'prefill': {
        if (phone != null && phone.isNotEmpty) 'contact': phone,
        if (email != null && email.isNotEmpty) 'email': email,
      },
    });
  }

  void _success(PaymentSuccessResponse r) => onSuccess(
    PaymentProof(
      orderId: r.orderId ?? '',
      paymentId: r.paymentId ?? '',
      signature: r.signature ?? '',
    ),
  );

  void _error(PaymentFailureResponse r) {
    if (r.code == Razorpay.PAYMENT_CANCELLED) {
      onDismissed();
    } else {
      onError(r.message ?? 'The payment did not go through.');
    }
  }

  void dispose() => _razorpay.clear();
}
