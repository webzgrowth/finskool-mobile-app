import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';

import 'service_quote_model.dart';

enum ServiceStatus { requested, quoteSent, paid, closed }

enum ServiceClosedReason { completed, declined, cancelledByMember }

extension ServiceStatusX on ServiceStatus {
  static ServiceStatus? fromWire(String? s) => switch (s) {
    'requested' => ServiceStatus.requested,
    'quote_sent' => ServiceStatus.quoteSent,
    'paid' => ServiceStatus.paid,
    'closed' => ServiceStatus.closed,
    _ => null,
  };
}

extension ServiceClosedReasonX on ServiceClosedReason {
  static ServiceClosedReason? fromWire(String? s) => switch (s) {
    'completed' => ServiceClosedReason.completed,
    'declined' => ServiceClosedReason.declined,
    'cancelled_by_member' => ServiceClosedReason.cancelledByMember,
    _ => null,
  };
}

/// The invoice stub on a paid request. The PDF itself is fetched on demand
/// (`GET /:id/invoice`).
class ServiceInvoiceRef {
  const ServiceInvoiceRef({
    required this.id,
    required this.number,
    required this.total,
  });

  final String id;
  final String number;
  final double total;

  factory ServiceInvoiceRef.fromJson(Map<String, dynamic> json) =>
      ServiceInvoiceRef(
        id: json['id'] as String? ?? '',
        number: json['number'] as String? ?? '',
        total: (json['total'] as num?)?.toDouble() ?? 0,
      );
}

/// A member's request for a service — "SR-12". Show [label], never `number`
/// or `id`.
class ServiceRequestModel {
  const ServiceRequestModel({
    required this.id,
    required this.label,
    required this.serviceId,
    required this.serviceTitle,
    required this.status,
    required this.createdAt,
    required this.lastMessageAt,
    this.closedReason,
    this.needs = '',
    this.attachments = const [],
    this.assignedAdminName,
    this.unreadCount = 0,
    this.quote,
    this.invoice,
    this.rating,
    this.paidAt,
    this.closedAt,
  });

  final String id;
  final String label;
  final String serviceId;
  final String serviceTitle;
  final ServiceStatus status;
  final ServiceClosedReason? closedReason;

  /// What the member asked for. Drawn as the conversation's first bubble by
  /// the screen — it is **not** in the message history.
  final String needs;
  final List<TicketAttachmentModel> attachments;
  final String? assignedAdminName;
  final int unreadCount;

  /// The payable quote, the paid one after payment, or null.
  final ServiceQuoteModel? quote;
  final ServiceInvoiceRef? invoice;
  final int? rating;
  final DateTime createdAt;
  final DateTime lastMessageAt;
  final DateTime? paidAt;
  final DateTime? closedAt;

  bool get isClosed => status == ServiceStatus.closed;
  bool get isPaid => status == ServiceStatus.paid || invoice != null;
  bool get isCompleted =>
      isClosed && closedReason == ServiceClosedReason.completed;

  /// Offered once, only after the team marks it delivered.
  bool get canRate => isCompleted && rating == null;

  /// "Cancel request" exists only **before** payment.
  bool get canCancel =>
      status == ServiceStatus.requested || status == ServiceStatus.quoteSent;

  ServiceRequestModel copyWith({
    int? unreadCount,
    ServiceQuoteModel? quote,
    int? rating,
  }) => ServiceRequestModel(
    id: id,
    label: label,
    serviceId: serviceId,
    serviceTitle: serviceTitle,
    status: status,
    closedReason: closedReason,
    needs: needs,
    attachments: attachments,
    assignedAdminName: assignedAdminName,
    unreadCount: unreadCount ?? this.unreadCount,
    quote: quote ?? this.quote,
    invoice: invoice,
    rating: rating ?? this.rating,
    createdAt: createdAt,
    lastMessageAt: lastMessageAt,
    paidAt: paidAt,
    closedAt: closedAt,
  );

  /// Folds a socket `Summary` (which has no `needs`/attachments and an
  /// `assignedAdmin` *object*) over this request.
  ServiceRequestModel mergedWithSummary(Map<String, dynamic> s) {
    final admin = s['assignedAdmin'];
    final quote = s['quote'];
    final invoiceNumber = s['invoiceNumber'] as String?;
    return ServiceRequestModel(
      id: id,
      label: label,
      serviceId: serviceId,
      serviceTitle: serviceTitle,
      status: ServiceStatusX.fromWire(s['status'] as String?) ?? status,
      closedReason: ServiceClosedReasonX.fromWire(s['closedReason'] as String?),
      needs: needs,
      attachments: attachments,
      assignedAdminName: admin is Map<String, dynamic>
          ? admin['name'] as String?
          : assignedAdminName,
      unreadCount: (s['unreadCount'] as num?)?.toInt() ?? unreadCount,
      quote: quote is Map<String, dynamic>
          ? ServiceQuoteModel.fromJson(quote)
          : (s.containsKey('quote') ? null : this.quote),
      // The summary only names the invoice; keep the richer REST one if we
      // have it, and refetch `GET /:id` for the rest.
      invoice:
          invoice ??
          (invoiceNumber == null
              ? null
              : ServiceInvoiceRef(id: '', number: invoiceNumber, total: 0)),
      rating: (s['rating'] as num?)?.toInt() ?? rating,
      createdAt: createdAt,
      lastMessageAt:
          DateTime.tryParse(s['lastMessageAt'] as String? ?? '')?.toUtc() ??
          lastMessageAt,
      paidAt:
          DateTime.tryParse(s['paidAt'] as String? ?? '')?.toUtc() ?? paidAt,
      closedAt:
          DateTime.tryParse(s['closedAt'] as String? ?? '')?.toUtc() ??
          closedAt,
    );
  }

  factory ServiceRequestModel.fromJson(Map<String, dynamic> json) {
    final service = json['service'];
    final quote = json['quote'];
    final invoice = json['invoice'];
    return ServiceRequestModel(
      id: json['id'] as String,
      label: json['label'] as String? ?? '',
      serviceId: service is Map<String, dynamic>
          ? service['id'] as String? ?? ''
          : '',
      serviceTitle: service is Map<String, dynamic>
          ? service['title'] as String? ?? ''
          : '',
      status:
          ServiceStatusX.fromWire(json['status'] as String?) ??
          ServiceStatus.requested,
      closedReason: ServiceClosedReasonX.fromWire(
        json['closedReason'] as String?,
      ),
      needs: json['needs'] as String? ?? '',
      attachments: TicketAttachmentModel.listFrom(json['attachments']),
      assignedAdminName: json['assignedAdminName'] as String?,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      quote: quote is Map<String, dynamic>
          ? ServiceQuoteModel.fromJson(quote)
          : null,
      invoice: invoice is Map<String, dynamic>
          ? ServiceInvoiceRef.fromJson(invoice)
          : null,
      rating: (json['rating'] as num?)?.toInt(),
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
      lastMessageAt:
          DateTime.tryParse(json['lastMessageAt'] as String? ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
      paidAt: DateTime.tryParse(json['paidAt'] as String? ?? '')?.toUtc(),
      closedAt: DateTime.tryParse(json['closedAt'] as String? ?? '')?.toUtc(),
    );
  }
}

/// One cursor-paged page of `GET /mobile/services`.
class ServiceRequestPage {
  const ServiceRequestPage({required this.items, this.nextCursor});

  final List<ServiceRequestModel> items;
  final String? nextCursor;

  factory ServiceRequestPage.fromJson(Map<String, dynamic> json) =>
      ServiceRequestPage(
        items: ((json['items'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(ServiceRequestModel.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
