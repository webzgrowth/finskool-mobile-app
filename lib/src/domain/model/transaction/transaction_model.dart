import 'package:intl/intl.dart';

enum TransactionStatus { paid, failed }

/// What the payment bought: a community plan or a service quote.
enum TransactionKind { community, service }

/// The glyph on a row's teal tile — Figma draws a different one per product.
enum TransactionGlyph { pie, briefcase, education, investor, chart }

/// One payment the member made (or tried to make): a community plan or a
/// service quote.
///
/// Plain class, hand-written like every API model. **There is no API for it
/// yet** — see `TransactionsDemoDatasource` — so [fromJson] is the contract the
/// real endpoint should be mapped onto, not something a server has sent.
class TransactionModel {
  const TransactionModel({
    required this.id,
    required this.kind,
    required this.glyph,
    required this.title,
    required this.descriptor,
    required this.date,
    required this.amount,
    required this.status,
    this.invoiceNumber,
    this.invoiceId,
    this.failureReason,
    this.paymentMethod,
    this.paymentId,
  });

  final String id;
  final TransactionKind kind;
  final TransactionGlyph glyph;

  /// "Portfolio Analysis", "Finskool21 Academy Community".
  final String title;

  /// The plan ("Quarterly") or the quote ("Quote Q-1042") — the first half of
  /// the row's subtitle.
  final String descriptor;
  final DateTime date;

  /// Whole rupees.
  final int amount;
  final TransactionStatus status;

  /// "INV-2026-0511". Null for a failed payment, which never got one.
  final String? invoiceNumber;

  /// The id `GET /payments/receipts/{id}/download` takes. Null when the server
  /// has no downloadable invoice for this payment.
  final String? invoiceId;

  /// The bank's reason, shown on a failed row ("Declined by bank…").
  final String? failureReason;
  final String? paymentMethod;
  final String? paymentId;

  bool get isPaid => status == TransactionStatus.paid;
  bool get isFailed => status == TransactionStatus.failed;

  /// "₹4,999" — thousands grouping, as Figma draws every amount.
  String get amountLabel =>
      '₹${NumberFormat.decimalPattern('en_US').format(amount)}';

  /// "Quarterly  ·  14 Aug 2026" — two spaces each side of the dot, as drawn.
  String get subtitle =>
      '$descriptor  ·  ${DateFormat('dd MMM yyyy').format(date)}';

  factory TransactionModel.fromJson(Map<String, dynamic> json) =>
      TransactionModel(
        id: json['id'] as String,
        kind: json['kind'] == 'service'
            ? TransactionKind.service
            : TransactionKind.community,
        glyph: TransactionGlyph.values.firstWhere(
          (g) => g.name == json['glyph'],
          orElse: () => TransactionGlyph.pie,
        ),
        title: json['title'] as String? ?? '',
        descriptor: json['descriptor'] as String? ?? '',
        date: DateTime.parse(json['date'] as String),
        amount: (json['amount'] as num).round(),
        status: json['status'] == 'failed'
            ? TransactionStatus.failed
            : TransactionStatus.paid,
        invoiceNumber: json['invoiceNumber'] as String?,
        invoiceId: json['invoiceId'] as String?,
        failureReason: json['failureReason'] as String?,
        paymentMethod: json['paymentMethod'] as String?,
        paymentId: json['paymentId'] as String?,
      );
}
