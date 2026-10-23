/// What the billing sheet collects. These print on the GST invoice.
class BillingDetails {
  const BillingDetails({
    required this.name,
    required this.stateCode,
    this.gstin,
    this.address,
  });

  final String name;
  final String stateCode;
  final String? gstin;
  final String? address;

  Map<String, dynamic> toJson() => {
    'name': name,
    'stateCode': stateCode,
    if (gstin != null && gstin!.isNotEmpty) 'gstin': gstin,
    if (address != null && address!.isNotEmpty) 'address': address,
  };
}

/// An Indian state / UT and its GST code, for the billing sheet's picker.
class GstState {
  const GstState({required this.code, required this.name});

  final String code;
  final String name;

  factory GstState.fromJson(Map<String, dynamic> json) => GstState(
    code: json['code'] as String? ?? '',
    name: json['name'] as String? ?? '',
  );
}

/// Exactly what Razorpay Checkout needs. [amountPaise] is **in paise** and
/// already includes GST — the one place on this API money isn't rupees.
class PaymentOrder {
  const PaymentOrder({
    required this.orderId,
    required this.amountPaise,
    required this.currency,
    required this.keyId,
    required this.quoteId,
    required this.requestId,
  });

  final String orderId;
  final int amountPaise;
  final String currency;
  final String keyId;
  final String quoteId;
  final String requestId;

  factory PaymentOrder.fromJson(Map<String, dynamic> json) => PaymentOrder(
    orderId: json['orderId'] as String? ?? '',
    amountPaise: (json['amount'] as num?)?.toInt() ?? 0,
    currency: json['currency'] as String? ?? 'INR',
    keyId: json['keyId'] as String? ?? '',
    quoteId: json['quoteId'] as String? ?? '',
    requestId: json['requestId'] as String? ?? '',
  );
}

/// The three values Razorpay Checkout returns on success.
class PaymentProof {
  const PaymentProof({
    required this.orderId,
    required this.paymentId,
    required this.signature,
  });

  final String orderId;
  final String paymentId;
  final String signature;

  Map<String, dynamic> toJson() => {
    'razorpayOrderId': orderId,
    'razorpayPaymentId': paymentId,
    'razorpaySignature': signature,
  };
}

/// A short-lived signed link to the GST invoice PDF.
class InvoiceLink {
  const InvoiceLink({required this.url, required this.fileName});

  final String url;
  final String fileName;

  factory InvoiceLink.fromJson(Map<String, dynamic> json) => InvoiceLink(
    url: json['url'] as String? ?? '',
    fileName: json['fileName'] as String? ?? 'invoice.pdf',
  );
}
