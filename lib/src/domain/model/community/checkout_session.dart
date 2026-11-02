/// What `POST /payments/checkout-sessions` hands back: the web page the member
/// pays on.
///
/// [checkoutUrl] carries a **one-time token** after its `#`. Open it exactly as
/// returned, within [expiresInSeconds], and never log, store or rebuild it — a
/// reload has no token and shows "This payment link is not valid".
class CheckoutSession {
  const CheckoutSession({
    required this.checkoutUrl,
    required this.expiresInSeconds,
  });

  final String checkoutUrl;
  final int expiresInSeconds;

  factory CheckoutSession.fromJson(Map<String, dynamic> json) =>
      CheckoutSession(
        checkoutUrl: json['checkoutUrl'] as String? ?? '',
        expiresInSeconds: (json['expiresInSeconds'] as num?)?.toInt() ?? 120,
      );
}
