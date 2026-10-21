import 'ticket_enums.dart';
import 'ticket_model.dart';

/// The smaller ticket the **socket** pushes, meant to be merged into a list
/// row (§6.2).
///
/// Two differences from `TicketModel` that are easy to miss: the admin
/// arrives as an object under `assignedAdmin` rather than a flat
/// `assignedAdminName`, and there is no description, attachments or rating
/// comment. [mergeInto] therefore patches only the fields it genuinely
/// carries — anything else would be erased with nulls. For a field it
/// lacks, refetch `GET /:ticketId`.
class TicketSummaryModel {
  const TicketSummaryModel({
    required this.id,
    required this.number,
    required this.label,
    required this.communityId,
    required this.subject,
    required this.status,
    required this.unreadCount,
    required this.lastMessageAt,
    this.category,
    this.type,
    this.assignedAdminName,
    this.rating,
    this.resolvedAt,
  });

  final String id;
  final int number;
  final String label;
  final String communityId;
  final TicketCategory? category;
  final TicketType? type;
  final String subject;
  final TicketStatus status;
  final String? assignedAdminName;

  /// Already **this member's** count — use it as-is.
  final int unreadCount;
  final DateTime lastMessageAt;
  final int? rating;
  final DateTime? resolvedAt;

  /// Patches an existing row. The caller then re-sorts by `lastMessageAt`
  /// and moves it to the top.
  TicketModel mergeInto(TicketModel ticket) => ticket.copyWith(
    status: status,
    assignedAdminName: assignedAdminName,
    unreadCount: unreadCount,
    lastMessageAt: lastMessageAt,
    rating: rating,
    resolvedAt: resolvedAt,
  );

  /// A `ticket.created` for an id the list has never seen becomes a new row,
  /// so the summary has to stand alone. The fields it doesn't carry are
  /// empty until `GET /:ticketId` fills them in.
  TicketModel toTicket() => TicketModel(
    id: id,
    number: number,
    label: label,
    communityId: communityId,
    communityName: '',
    category: category,
    type: type,
    subject: subject,
    description: '',
    status: status,
    assignedAdminName: assignedAdminName,
    unreadCount: unreadCount,
    lastMessageAt: lastMessageAt,
    createdAt: lastMessageAt,
    rating: rating,
    resolvedAt: resolvedAt,
  );

  factory TicketSummaryModel.fromJson(Map<String, dynamic> json) {
    final admin = json['assignedAdmin'];
    return TicketSummaryModel(
      id: json['id'] as String,
      number: (json['number'] as num?)?.toInt() ?? 0,
      label: json['label'] as String? ?? '',
      communityId: json['communityId'] as String? ?? '',
      category: TicketCategoryX.fromName(json['category'] as String?),
      type: TicketTypeX.fromName(json['type'] as String?),
      subject: json['subject'] as String? ?? '',
      status:
          TicketStatusX.fromName(json['status'] as String?) ??
          TicketStatus.open,
      assignedAdminName: admin is Map<String, dynamic>
          ? admin['name'] as String?
          : null,
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      lastMessageAt:
          DateTime.tryParse(json['lastMessageAt'] as String? ?? '')?.toUtc() ??
          DateTime.now().toUtc(),
      rating: (json['rating'] as num?)?.toInt(),
      resolvedAt: DateTime.tryParse(json['resolvedAt'] as String? ?? '')
          ?.toUtc(),
    );
  }
}
