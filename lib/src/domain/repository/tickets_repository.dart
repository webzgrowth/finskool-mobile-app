import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';

/// The ticket module's contract. Note the split the backend imposes: the
/// first group is REST, the second is **socket-only** — there are no REST
/// chat endpoints at all (§1).
abstract class TicketsRepository {
  // ── REST ────────────────────────────────────────────────────────────
  Future<Either<Failure, List<TicketCommunityModel>>> getCommunities();

  Future<Either<Failure, TicketPageModel>> getTickets({
    TicketStatus? status,
    String? cursor,
  });

  Future<Either<Failure, TicketModel>> getTicket(String ticketId);

  Future<Either<Failure, int>> getUnreadCount();

  /// [idempotencyKey] is generated once per submission and **reused on
  /// retry**, so a timeout can't raise a second ticket.
  Future<Either<Failure, TicketModel>> createTicket({
    required String idempotencyKey,
    required String communityId,
    required TicketCategory category,
    required TicketType type,
    required String subject,
    required String description,
    List<TicketUploadModel> attachments,
  });

  Future<Either<Failure, TicketModel>> rateTicket({
    required String ticketId,
    required int rating,
    String? comment,
  });

  Future<Either<Failure, String>> refreshAttachmentUrl({
    required String ticketId,
    required String attachmentId,
  });

  Future<Either<Failure, TicketUploadModel>> uploadAttachment(
    File file, {
    String? fileName,
  });

  // ── Socket ──────────────────────────────────────────────────────────

  /// [clientMessageId] must be **reused when retrying the same message**:
  /// the server stores each `(ticket, clientMessageId)` once and returns the
  /// original on a repeat, which is what makes a resend after a timeout or a
  /// reconnect safe.
  Future<Either<Failure, TicketMessageModel>> sendMessage({
    required String ticketId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments,
  });

  /// Newest first — reverse each page for display. Pass the previous
  /// `nextCursor` as [before] to load older messages.
  Future<Either<Failure, TicketHistoryPage>> getHistory({
    required String ticketId,
    String? before,
  });

  /// Zeroes this ticket's unread count, here and on the member's other
  /// devices.
  Future<Either<Failure, int>> markRead(String ticketId);
}

/// One page of chat history.
class TicketHistoryPage {
  const TicketHistoryPage({required this.items, this.nextCursor});

  final List<TicketMessageModel> items;
  final String? nextCursor;

  bool get hasMore => nextCursor != null;

  factory TicketHistoryPage.fromJson(Map<String, dynamic> json) =>
      TicketHistoryPage(
        items: ((json['items'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(TicketMessageModel.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}
