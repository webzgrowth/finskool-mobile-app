/// The invoice for a member's **latest purchase** of a community — the
/// `invoice` object on each row of `GET /auth/mobile/me`'s `communities`.
///
/// Null on the community when the member never paid through the app (an admin
/// added them), so there is nothing to download.
///
/// The PDF is **not** reached through [downloadUrl]: that signed link lives
/// about five minutes from when `/me` was read, and can be null if the server
/// couldn't prepare it. The tap asks for a fresh one by [id]
/// (`GET /payments/receipts/{id}/download`). The field is parsed so it isn't
/// lost, but never stored — see [toJson].
class SubscriptionInvoice {
  const SubscriptionInvoice({
    required this.id,
    required this.number,
    required this.amount,
    required this.currency,
    required this.fileName,
    this.issuedAt,
    this.downloadUrl,
  });

  final String id;

  /// "FS/2026-27/0184".
  final String number;
  final DateTime? issuedAt;

  /// The total paid, GST included.
  final double amount;
  final String currency;

  /// "FS-2026-27-0184.pdf".
  final String fileName;
  final String? downloadUrl;

  /// Null for a row with no id — nothing could be requested for it.
  static SubscriptionInvoice? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    final id = json['id'];
    if (id is! String || id.isEmpty) return null;
    final issued = json['issuedAt'];
    return SubscriptionInvoice(
      id: id,
      number: json['number'] as String? ?? '',
      issuedAt: issued is String ? DateTime.tryParse(issued) : null,
      amount: (json['amount'] as num?)?.toDouble() ?? 0,
      currency: json['currency'] as String? ?? 'INR',
      fileName: json['fileName'] as String? ?? 'invoice.pdf',
      downloadUrl: json['downloadUrl'] as String?,
    );
  }

  /// Without [downloadUrl]: it is a short-lived signed link, so it is never
  /// written anywhere that outlives the response it came in.
  Map<String, dynamic> toJson() => {
    'id': id,
    'number': number,
    'issuedAt': issuedAt?.toIso8601String(),
    'amount': amount,
    'currency': currency,
    'fileName': fileName,
  };
}
