import 'ticket_attachment_model.dart';
import 'ticket_enums.dart';

/// A ticket, as `GET /` and `GET /:ticketId` return it.
///
/// The socket pushes a **smaller** shape for list upkeep — see
/// `TicketSummaryModel`, which differs in two ways that have bitten before:
/// it sends `assignedAdmin` as an *object* where this sends
/// `assignedAdminName`, and it carries no description or attachments.
class TicketModel {
  const TicketModel({
    required this.id,
    required this.number,
    required this.label,
    required this.communityId,
    required this.communityName,
    required this.subject,
    required this.description,
    required this.status,
    required this.createdAt,
    required this.lastMessageAt,
    this.category,
    this.type,
    this.attachments = const [],
    this.assignedAdminName,
    this.unreadCount = 0,
    this.rating,
    this.ratingComment,
    this.ratedAt,
    this.resolvedAt,
  });

  final String id;
  final int number;

  /// `FS-2041`. **Show this**, never [number] or [id] (§2).
  final String label;
  final String communityId;
  final String communityName;

  /// Nullable because `fromName` drops a value this build doesn't know —
  /// a new server-side category must not blank the screen.
  final TicketCategory? category;
  final TicketType? type;
  final String subject;

  /// Rendered as the **first bubble** of the conversation; it is not part
  /// of the message history (§4). Its files are [attachments].
  final String description;
  final List<TicketAttachmentModel> attachments;
  final TicketStatus status;
  final String? assignedAdminName;

  /// Admin replies this member hasn't read. Drives the row's dot.
  final int unreadCount;

  /// The list is sorted by this, newest first. Starts equal to [createdAt].
  final DateTime lastMessageAt;
  final DateTime createdAt;
  final int? rating;
  final String? ratingComment;
  final DateTime? ratedAt;
  final DateTime? resolvedAt;

  bool get isResolved => status.isResolved;

  /// The rating sheet is offered once, and only on a resolved ticket.
  bool get canRate => isResolved && rating == null;

  TicketModel copyWith({
    TicketStatus? status,
    String? assignedAdminName,
    int? unreadCount,
    DateTime? lastMessageAt,
    int? rating,
    String? ratingComment,
    DateTime? ratedAt,
    DateTime? resolvedAt,
    List<TicketAttachmentModel>? attachments,
  }) => TicketModel(
    id: id,
    number: number,
    label: label,
    communityId: communityId,
    communityName: communityName,
    category: category,
    type: type,
    subject: subject,
    description: description,
    attachments: attachments ?? this.attachments,
    status: status ?? this.status,
    assignedAdminName: assignedAdminName ?? this.assignedAdminName,
    unreadCount: unreadCount ?? this.unreadCount,
    lastMessageAt: lastMessageAt ?? this.lastMessageAt,
    createdAt: createdAt,
    rating: rating ?? this.rating,
    ratingComment: ratingComment ?? this.ratingComment,
    ratedAt: ratedAt ?? this.ratedAt,
    resolvedAt: resolvedAt ?? this.resolvedAt,
  );

  factory TicketModel.fromJson(Map<String, dynamic> json) => TicketModel(
    id: json['id'] as String,
    number: (json['number'] as num?)?.toInt() ?? 0,
    label: json['label'] as String? ?? '',
    communityId: json['communityId'] as String? ?? '',
    communityName: json['communityName'] as String? ?? '',
    category: TicketCategoryX.fromName(json['category'] as String?),
    type: TicketTypeX.fromName(json['type'] as String?),
    subject: json['subject'] as String? ?? '',
    description: json['description'] as String? ?? '',
    attachments: TicketAttachmentModel.listFrom(json['attachments']),
    status:
        TicketStatusX.fromName(json['status'] as String?) ?? TicketStatus.open,
    assignedAdminName: json['assignedAdminName'] as String?,
    unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
    lastMessageAt: _utc(json['lastMessageAt']) ?? DateTime.now().toUtc(),
    createdAt: _utc(json['createdAt']) ?? DateTime.now().toUtc(),
    rating: (json['rating'] as num?)?.toInt(),
    ratingComment: json['ratingComment'] as String?,
    ratedAt: _utc(json['ratedAt']),
    resolvedAt: _utc(json['resolvedAt']),
  );
}

/// Timestamps are ISO 8601 **in UTC** (§2) — keep them that way and convert
/// only for display, via `comman/ist_time.dart`.
DateTime? _utc(Object? raw) =>
    raw is String && raw.isNotEmpty ? DateTime.tryParse(raw)?.toUtc() : null;
