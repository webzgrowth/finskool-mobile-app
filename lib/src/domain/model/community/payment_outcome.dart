import 'dart:convert';

/// What the checkout page tells the app through `postMessage`
/// (`{"type":"payment","status":"paid"}`).
///
/// A **hint, never proof**: the app always confirms against `/auth/mobile/me`
/// before telling the member they are subscribed.
enum PaymentOutcome {
  /// Confirmed and access granted — close the page and confirm.
  paid,

  /// The member dismissed Razorpay's popup; the page stays on its Pay button.
  closed,

  /// The link was invalid/expired or the page couldn't confirm. Money may
  /// still have been taken, so confirm anyway.
  error;

  /// Null for anything that isn't a payment message, so an unknown or
  /// malformed one can never break the flow.
  static PaymentOutcome? parse(String raw) {
    try {
      final data = jsonDecode(raw);
      if (data is! Map || data['type'] != 'payment') return null;
      return switch (data['status']) {
        'paid' => paid,
        'closed' => closed,
        'error' => error,
        _ => null,
      };
    } catch (_) {
      return null;
    }
  }
}
