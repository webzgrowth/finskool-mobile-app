import 'package:intl/intl.dart';
import 'package:finskool/src/comman/ist_time.dart';

/// `paid` is done; `failed` means nothing was deducted; `flagged` means the
/// money arrived but could not be applied and the team is looking into it.
enum TransactionStatus { paid, failed, flagged }

/// What the payment bought: a community plan or a service quote.
enum TransactionKind { community, service }

/// One payment the member made (or tried to make) — a row of
/// `GET /mobile/transactions`.
///
/// Plain class, hand-written like every API model, and it carries **only what
/// that endpoint sends**; nothing on screen is invented from outside it.
class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.kind,
    required this.status,
    required this.occurredAt,
    required this.amount,
    required this.title,
    this.currency = 'INR',
    this.planMonths,
    this.planName,
    this.reference,
    this.paymentId,
    this.method,
    this.failureReason,
    this.invoiceNumber,
    this.invoicePath,
  });

  /// Stable and unique (`plan:…`, `svc:…`) — the list key.
  final String id;
  final TransactionKind kind;
  final TransactionStatus status;

  /// A UTC instant. Display it only through `formatIst`.
  final DateTime occurredAt;

  /// Rupees (not paise), GST included.
  final num amount;
  final String currency;

  /// "Intraday Community", "Intelligent Model Portfolio".
  final String title;

  /// Community plans only.
  final int? planMonths;
  final String? planName;

  /// Service quotes only: "SR-12 · Quote 1".
  final String? reference;
  final String? paymentId;

  /// "card", "upi"… — null when the gateway did not say.
  final String? method;

  /// The backend's words, shown verbatim on a failed row.
  final String? failureReason;

  /// "FS/2026-27/0184". Null for a failed or flagged payment.
  final String? invoiceNumber;

  /// The server's own `invoice.downloadPath`, called as sent (a fresh signed
  /// link comes back each time). Null when the server has no invoice.
  final String? invoicePath;

  bool get isPaid => status == TransactionStatus.paid;
  bool get isFailed => status == TransactionStatus.failed;
  bool get isFlagged => status == TransactionStatus.flagged;

  /// "₹4,999" — thousands grouping; paise appear only when there are some.
  String get amountLabel {
    final whole = amount == amount.roundToDouble();
    final digits = NumberFormat.decimalPatternDigits(
      locale: 'en_US',
      decimalDigits: whole ? 0 : 2,
    ).format(amount);
    return currency == 'INR' ? '₹$digits' : '$currency $digits';
  }

  /// The plan ("Yearly") or the quote ("SR-12 · Quote 1") — the first half of
  /// the row's subtitle. Null when the payload carried neither.
  String? get descriptor => switch (kind) {
    TransactionKind.community =>
      planName ?? (planMonths == null ? null : planDuration),
    TransactionKind.service => reference,
  };

  /// "12 months" / "1 month".
  String? get planDuration => planMonths == null
      ? null
      : '$planMonths ${planMonths == 1 ? 'month' : 'months'}';

  /// "Yearly  ·  13 Nov 2026" — two spaces before the dot and two after, as
  /// drawn. The dot, its gap and the date are joined with no-break spaces so a
  /// long descriptor ("SR-12 · Quote 1") wraps *before* the date, never inside
  /// it.
  String get subtitle {
    final date = formatIst(occurredAt, 'dd MMM yyyy').replaceAll(' ', '\u00A0');
    final d = descriptor;
    return d == null ? date : '$d  ·\u00A0\u00A0$date';
  }

  /// "card" → "Card", "upi" → "UPI", "netbanking" → "Net banking".
  String? get methodLabel {
    final m = method?.trim();
    if (m == null || m.isEmpty) return null;
    return switch (m.toLowerCase()) {
      'upi' => 'UPI',
      'netbanking' => 'Net banking',
      'emi' => 'EMI',
      final other => other[0].toUpperCase() + other.substring(1),
    };
  }

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    final invoice = json['invoice'];
    final invoiceMap = invoice is Map<String, dynamic> ? invoice : null;
    return TransactionModel(
      id: json['id'] as String,
      kind: json['kind'] == 'service'
          ? TransactionKind.service
          : TransactionKind.community,
      // An unknown status is treated as under review rather than as a success
      // or a failure the member might act on.
      status: switch (json['status']) {
        'paid' => TransactionStatus.paid,
        'failed' => TransactionStatus.failed,
        _ => TransactionStatus.flagged,
      },
      occurredAt: DateTime.parse(json['occurredAt'] as String),
      amount: json['amount'] as num? ?? 0,
      currency: json['currency'] as String? ?? 'INR',
      title: json['title'] as String? ?? '',
      planMonths: (json['planMonths'] as num?)?.toInt(),
      planName: json['planName'] as String?,
      reference: json['reference'] as String?,
      paymentId: json['paymentId'] as String?,
      method: json['method'] as String?,
      failureReason: json['failureReason'] as String?,
      invoiceNumber: invoiceMap?['number'] as String?,
      invoicePath: invoiceMap?['downloadPath'] as String?,
    );
  }
}
