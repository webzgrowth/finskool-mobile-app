/// A quote's lifecycle. `active` is the only payable one; the server keeps
/// it current, so an expired quote already reads `expired` before its clean-up
/// runs and the client never has to compare dates itself.
enum ServiceQuoteStatus { active, paid, superseded, expired, cancelled }

extension ServiceQuoteStatusX on ServiceQuoteStatus {
  static ServiceQuoteStatus? fromName(String? name) {
    for (final s in ServiceQuoteStatus.values) {
      if (s.name == name) return s;
    }
    return null;
  }

  /// The caption on a card that can no longer be paid.
  String get label => switch (this) {
    ServiceQuoteStatus.active => 'Valid',
    ServiceQuoteStatus.paid => 'Paid',
    ServiceQuoteStatus.superseded => 'Replaced by a newer quote',
    ServiceQuoteStatus.expired => 'Expired',
    ServiceQuoteStatus.cancelled => 'Withdrawn',
  };
}

/// The team's price for a request. Money is **rupees** here (`11800`,
/// `1382.71`); only the Razorpay order from `/pay` is in paise.
class ServiceQuoteModel {
  const ServiceQuoteModel({
    required this.id,
    required this.requestId,
    required this.version,
    required this.baseAmount,
    required this.gstRatePercent,
    required this.gstAmount,
    required this.totalAmount,
    required this.status,
    required this.expiresAt,
    this.note,
    this.currency = 'INR',
  });

  final String id;
  final String requestId;
  final int version;
  final double baseAmount;
  final double gstRatePercent;
  final double gstAmount;

  /// `baseAmount + gstAmount` — **what the member pays.**
  final double totalAmount;
  final ServiceQuoteStatus status;
  final DateTime expiresAt;
  final String? note;
  final String currency;

  bool get isPayable => status == ServiceQuoteStatus.active;

  ServiceQuoteModel withStatus(ServiceQuoteStatus next) => ServiceQuoteModel(
    id: id,
    requestId: requestId,
    version: version,
    baseAmount: baseAmount,
    gstRatePercent: gstRatePercent,
    gstAmount: gstAmount,
    totalAmount: totalAmount,
    status: next,
    expiresAt: expiresAt,
    note: note,
    currency: currency,
  );

  factory ServiceQuoteModel.fromJson(Map<String, dynamic> json) =>
      ServiceQuoteModel(
        id: json['id'] as String,
        requestId: json['requestId'] as String? ?? '',
        version: (json['version'] as num?)?.toInt() ?? 1,
        baseAmount: (json['baseAmount'] as num?)?.toDouble() ?? 0,
        gstRatePercent: (json['gstRatePercent'] as num?)?.toDouble() ?? 0,
        gstAmount: (json['gstAmount'] as num?)?.toDouble() ?? 0,
        totalAmount: (json['totalAmount'] as num?)?.toDouble() ?? 0,
        // An unknown status reads as the least useful one, so a card from a
        // newer backend is never offered for payment by mistake.
        status:
            ServiceQuoteStatusX.fromName(json['status'] as String?) ??
            ServiceQuoteStatus.cancelled,
        expiresAt:
            DateTime.tryParse(json['expiresAt'] as String? ?? '')?.toUtc() ??
            DateTime.now().toUtc(),
        note: json['note'] as String?,
        currency: json['currency'] as String? ?? 'INR',
      );
}
