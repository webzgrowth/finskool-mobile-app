import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/tickets_remote_datasource.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// Everything below here throws; everything above gets an `Either`.
///
/// The socket half needs one extra translation the REST half doesn't:
/// `handleErrors` knows nothing about [SocketError], so [_socket] maps it
/// onto a `ServerFailure` **preserving `code`** — the UI branches on
/// `TICKET_RESOLVED` and `RATE_LIMITED`.
@LazySingleton(as: TicketsRepository)
class TicketsRepositoryImpl implements TicketsRepository {
  TicketsRepositoryImpl(this._remote, this._sock);

  final TicketsRemoteDatasource _remote;
  final TicketsSocket _sock;

  @override
  Future<Either<Failure, List<TicketCommunityModel>>> getCommunities() =>
      handleErrors(_remote.getCommunities);

  @override
  Future<Either<Failure, TicketPageModel>> getTickets({
    TicketStatus? status,
    String? cursor,
  }) => handleErrors(() => _remote.getTickets(status: status, cursor: cursor));

  @override
  Future<Either<Failure, TicketModel>> getTicket(String ticketId) =>
      handleErrors(() => _remote.getTicket(ticketId));

  @override
  Future<Either<Failure, int>> getUnreadCount() =>
      handleErrors(_remote.getUnreadCount);

  @override
  Future<Either<Failure, TicketModel>> createTicket({
    required String idempotencyKey,
    required String communityId,
    required TicketCategory category,
    required TicketType type,
    required String subject,
    required String description,
    List<TicketUploadModel> attachments = const [],
  }) => handleErrors(
    () => _remote.createTicket(
      idempotencyKey: idempotencyKey,
      communityId: communityId,
      category: category,
      type: type,
      subject: subject,
      description: description,
      attachments: attachments,
    ),
  );

  @override
  Future<Either<Failure, TicketModel>> rateTicket({
    required String ticketId,
    required int rating,
    String? comment,
  }) => handleErrors(
    () => _remote.rateTicket(
      ticketId: ticketId,
      rating: rating,
      comment: comment,
    ),
  );

  @override
  Future<Either<Failure, String>> refreshAttachmentUrl({
    required String ticketId,
    required String attachmentId,
  }) => handleErrors(
    () => _remote.refreshAttachmentUrl(
      ticketId: ticketId,
      attachmentId: attachmentId,
    ),
  );

  @override
  Future<Either<Failure, TicketUploadModel>> uploadAttachment(
    File file, {
    String? fileName,
  }) => handleErrors(() => _remote.uploadAttachment(file, fileName: fileName));

  @override
  Future<Either<Failure, TicketMessageModel>> sendMessage({
    required String ticketId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  }) => _socket(() async {
    final data = await _sock.send('message.send', {
      'ticketId': ticketId,
      'clientMessageId': clientMessageId,
      if (body != null && body.isNotEmpty) 'body': body,
      if (attachments.isNotEmpty)
        'attachments': attachments.map((a) => a.toJson()).toList(),
    });
    return TicketMessageModel.fromJson(_require(data));
  });

  @override
  Future<Either<Failure, TicketHistoryPage>> getHistory({
    required String ticketId,
    String? before,
  }) => _socket(() async {
    final data = await _sock.send('history.get', {
      'ticketId': ticketId,
      'before': ?before,
    });
    return TicketHistoryPage.fromJson(_require(data));
  });

  @override
  Future<Either<Failure, int>> markRead(String ticketId) => _socket(() async {
    final data = await _sock.send('ticket.read', {'ticketId': ticketId});
    return (data?['unreadCount'] as num?)?.toInt() ?? 0;
  });

  /// `handleErrors` for the socket. A [SocketError] becomes a
  /// `ServerFailure` that keeps its `code`, so the chat can lock its
  /// composer on `TICKET_RESOLVED` and back off on `RATE_LIMITED` rather
  /// than showing one generic snackbar.
  Future<Either<Failure, T>> _socket<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on SocketError catch (e) {
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Map<String, dynamic> _require(Map<String, dynamic>? data) {
    if (data == null) {
      throw ApiException('Support sent back an empty response.');
    }
    return data;
  }
}
