import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

TicketModel fakeTicket({
  String id = 't1',
  TicketStatus status = TicketStatus.inProgress,
  int unread = 0,
  int? rating,
}) => TicketModel(
  id: id,
  number: 2041,
  label: 'FS-2041',
  communityId: 'c1',
  communityName: 'Intraday Community',
  category: TicketCategory.payments,
  type: TicketType.issue,
  subject: 'Payment failed',
  description: 'Money deducted',
  status: status,
  unreadCount: unread,
  rating: rating,
  createdAt: DateTime.utc(2026, 10, 5, 10),
  lastMessageAt: DateTime.utc(2026, 10, 5, 10),
  resolvedAt: status.isResolved ? DateTime.utc(2026, 10, 6, 11) : null,
);

TicketMessageModel serverMessage(
  String id, {
  String? client,
  String role = 'admin',
  int minute = 0,
}) => TicketMessageModel(
  id: id,
  ticketId: 't1',
  senderRole: role,
  senderName: role == 'user' ? 'You' : 'Support',
  body: 'body $id',
  clientMessageId: client,
  createdAt: DateTime.utc(2026, 10, 5, 10, minute),
);

/// An in-memory repository whose behaviour each test scripts.
class FakeTicketsRepository implements TicketsRepository {
  TicketModel ticket = fakeTicket();
  List<TicketMessageModel> history = const [];
  Failure? sendFailure;
  Failure? createFailure;
  List<TicketCommunityModel> communities = const [
    TicketCommunityModel(id: 'c1', name: 'Intraday Community'),
    TicketCommunityModel(id: 'c2', name: 'Investor Community'),
  ];
  final createdKeys = <String>[];
  List<TicketModel> pageItems = const [];
  Completer<void>? sendGate;
  final sentClientIds = <String>[];
  var readCalls = 0;
  var historyCalls = 0;

  @override
  Future<Either<Failure, TicketModel>> getTicket(String id) async =>
      Right(ticket);

  @override
  Future<Either<Failure, TicketHistoryPage>> getHistory({
    required String ticketId,
    String? before,
  }) async {
    historyCalls++;
    return Right(TicketHistoryPage(items: history));
  }

  @override
  Future<Either<Failure, TicketMessageModel>> sendMessage({
    required String ticketId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  }) async {
    sentClientIds.add(clientMessageId);
    await sendGate?.future;
    final failure = sendFailure;
    if (failure != null) return Left(failure);
    return Right(
      TicketMessageModel(
        id: 'srv-${sentClientIds.length}',
        ticketId: ticketId,
        senderRole: 'user',
        senderName: 'You',
        body: body,
        clientMessageId: clientMessageId,
        createdAt: DateTime.utc(2026, 10, 5, 11),
      ),
    );
  }

  @override
  Future<Either<Failure, int>> markRead(String ticketId) async {
    readCalls++;
    return const Right(0);
  }

  @override
  Future<Either<Failure, TicketModel>> rateTicket({
    required String ticketId,
    required int rating,
    String? comment,
  }) async {
    ticket = ticket.copyWith(rating: rating);
    return Right(ticket);
  }

  // Not exercised by these tests.
  @override
  Future<Either<Failure, List<TicketCommunityModel>>> getCommunities() async =>
      Right(communities);
  @override
  Future<Either<Failure, TicketPageModel>> getTickets({
    TicketStatus? status,
    String? cursor,
  }) async => Right(TicketPageModel(items: pageItems));
  @override
  Future<Either<Failure, int>> getUnreadCount() async => const Right(0);
  @override
  Future<Either<Failure, TicketModel>> createTicket({
    required String idempotencyKey,
    required String communityId,
    required TicketCategory category,
    required TicketType type,
    required String subject,
    required String description,
    List<TicketUploadModel> attachments = const [],
  }) async {
    createdKeys.add(idempotencyKey);
    final failure = createFailure;
    return failure != null ? Left(failure) : Right(ticket);
  }

  @override
  Future<Either<Failure, String>> refreshAttachmentUrl({
    required String ticketId,
    required String attachmentId,
  }) async => const Right('https://fresh');
  @override
  Future<Either<Failure, TicketUploadModel>> uploadAttachment(
    File file, {
    String? fileName,
  }) async => const Right(
    TicketUploadModel(objectKey: 'k', fileName: 'f.png', sizeBytes: 1),
  );
}

/// A socket that never touches the network: tests push events and flip the
/// connection status by hand.
class FakeSocket extends TicketsSocket {
  final _events = StreamController<SocketEvent>.broadcast();
  final _status = StreamController<SocketStatus>.broadcast();
  SocketStatus _now = SocketStatus.live;

  @override
  Stream<SocketEvent> get events => _events.stream;
  @override
  Stream<SocketStatus> get status => _status.stream;
  @override
  SocketStatus get currentStatus => _now;
  @override
  void connect() {}
  @override
  Future<bool> whenLive({
    Duration timeout = const Duration(seconds: 6),
  }) async => _now == SocketStatus.live;

  void push(SocketEvent e) => _events.add(e);
  void setStatus(SocketStatus s) {
    _now = s;
    _status.add(s);
  }
}

/// Loads Inter and Manrope from the app bundle.
///
/// **Without this a widget test measures the wrong font.** flutter_test falls
/// back to Ahem, whose glyphs are all square and as wide as they are tall —
/// roughly 1.5x wider than Inter — so layouts report overflows that real text
/// never has, and (worse) miss ones that it does. Call it in `setUpAll`.
Future<void> loadAppFonts() async {
  Future<void> load(String family, String asset) async {
    final loader = FontLoader(family)..addFont(rootBundle.load(asset));
    await loader.load();
  }

  await load('Inter', 'fonts/inter/Inter[opsz,wght].ttf');
  await load('Manrope', 'fonts/manrope/Manrope[wght].ttf');
}
