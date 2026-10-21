import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/get_ticket_history.dart';
import 'package:finskool/src/domain/usecases/tickets/mark_ticket_read.dart';
import 'package:finskool/src/domain/usecases/tickets/rate_ticket.dart';
import 'package:finskool/src/domain/usecases/tickets/refresh_attachment_url.dart';
import 'package:finskool/src/domain/usecases/tickets/send_ticket_message.dart';
import 'package:finskool/src/domain/usecases/tickets/upload_ticket_attachment.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';

import 'support/ticket_fakes.dart';

void main() {
  late FakeTicketsRepository repo;
  late FakeSocket socket;
  late TicketChatBloc bloc;

  /// Lets queued events and the awaited usecases run to completion.
  Future<void> settle() =>
      Future<void>.delayed(const Duration(milliseconds: 20));

  Future<void> open() async {
    bloc.add(const TicketChatEvent.started('t1'));
    await settle();
  }

  setUp(() {
    repo = FakeTicketsRepository();
    socket = FakeSocket();
    bloc = TicketChatBloc(
      GetTicket(repo),
      GetTicketHistory(repo),
      SendTicketMessage(repo),
      MarkTicketRead(repo),
      RateTicket(repo),
      UploadTicketAttachment(repo),
      RefreshAttachmentUrl(repo),
      socket,
    );
  });

  tearDown(() => bloc.close());

  group('opening a conversation', () {
    test(
      'loads the ticket and history, newest-first reversed for display',
      () async {
        repo.history = [
          serverMessage('m3', minute: 3),
          serverMessage('m2', minute: 2),
          serverMessage('m1', minute: 1),
        ];
        await open();
        expect(bloc.state.state.isLoaded, isTrue);
        expect(bloc.state.messages.map((m) => m.id), ['m1', 'm2', 'm3']);
      },
    );

    test('marks it read only when something is actually unread', () async {
      repo.ticket = fakeTicket(unread: 2);
      await open();
      expect(repo.readCalls, 1);
      expect(bloc.state.ticket!.unreadCount, 0);
    });

    test('does not mark read when there is nothing to read', () async {
      repo.ticket = fakeTicket(unread: 0);
      await open();
      expect(repo.readCalls, 0);
    });
  });

  group('sending', () {
    test('shows an optimistic bubble, then the confirmed message', () async {
      await open();
      repo.sendGate = null;
      bloc.add(const TicketChatEvent.sent('hello'));
      await settle();

      expect(bloc.state.messages, hasLength(1));
      expect(bloc.state.messages.single.isLocal, isFalse);
      expect(bloc.state.messages.single.body, 'hello');
    });

    test('the ack and the echoed event leave exactly one bubble', () async {
      await open();
      bloc.add(const TicketChatEvent.sent('hello'));
      await settle();
      final clientId = repo.sentClientIds.single;

      // The same message again, as the ticket.message event.
      socket.push(
        SocketEvent(
          event: 'ticket.message',
          ticketId: 't1',
          data: {
            'message': {
              'id': 'srv-1',
              'ticketId': 't1',
              'senderRole': 'user',
              'senderName': 'You',
              'body': 'hello',
              'clientMessageId': clientId,
              'attachments': [],
              'createdAt': '2026-10-05T11:00:00.000Z',
            },
          },
        ),
      );
      await settle();
      expect(bloc.state.messages, hasLength(1));
    });

    test(
      'a failed send is tappable and the retry reuses its clientMessageId',
      () async {
        await open();
        repo.sendFailure = const ServerFailure(
          'Request failed',
          code: 'TIMEOUT',
        );
        bloc.add(const TicketChatEvent.sent('hello'));
        await settle();

        expect(bloc.state.messages.single.delivery, MessageDelivery.failed);
        final firstId = repo.sentClientIds.single;

        repo.sendFailure = null;
        bloc.add(TicketChatEvent.retried(firstId));
        await settle();

        // The server stores each (ticket, clientMessageId) once — so reusing
        // it is what stops a resend from posting twice.
        expect(repo.sentClientIds, [firstId, firstId]);
        expect(bloc.state.messages, hasLength(1));
        expect(bloc.state.messages.single.delivery, MessageDelivery.sent);
      },
    );

    test('an empty message is not sent', () async {
      await open();
      bloc.add(const TicketChatEvent.sent('   '));
      await settle();
      expect(repo.sentClientIds, isEmpty);
    });

    test('offline: nothing is sent and the member is told why', () async {
      await open();
      socket.setStatus(SocketStatus.offline);
      await settle();
      bloc.add(const TicketChatEvent.sent('hello'));
      await settle();
      expect(repo.sentClientIds, isEmpty);
      expect(bloc.state.messages, isEmpty);
      expect(bloc.state.message, contains('offline'));
    });

    test(
      'a ticket resolved mid-typing drops the bubble and locks the composer',
      () async {
        await open();
        repo.sendFailure = const ServerFailure(
          'This ticket is resolved.',
          code: 'TICKET_RESOLVED',
        );
        repo.ticket = fakeTicket(status: TicketStatus.resolved);
        bloc.add(const TicketChatEvent.sent('too late'));
        await settle();

        expect(
          bloc.state.messages,
          isEmpty,
          reason: 'it can never be delivered, so it is not left as "failed"',
        );
        expect(bloc.state.isLocked, isTrue);
        expect(bloc.state.canSend, isFalse);
      },
    );
  });

  group('live events', () {
    test('an admin reply appends and is marked read at once', () async {
      repo.ticket = fakeTicket(unread: 0);
      await open();
      repo.ticket = fakeTicket(unread: 1);
      // The reply's summary says there is one unread.
      socket.push(
        SocketEvent(
          event: 'ticket.message',
          ticketId: 't1',
          data: {
            'message': {
              'id': 'adm-1',
              'ticketId': 't1',
              'senderRole': 'admin',
              'senderName': 'Support',
              'body': 'Looking into it',
              'attachments': [],
              'createdAt': '2026-10-05T12:00:00.000Z',
            },
            'ticket': {
              'id': 't1',
              'number': 2041,
              'label': 'FS-2041',
              'communityId': 'c1',
              'subject': 'Payment failed',
              'status': 'in_progress',
              'unreadCount': 1,
              'lastMessageAt': '2026-10-05T12:00:00.000Z',
            },
          },
        ),
      );
      await settle();

      expect(bloc.state.messages.single.body, 'Looking into it');
      expect(repo.readCalls, 1);
      expect(bloc.state.ticket!.unreadCount, 0);
    });

    test("another ticket's traffic is ignored", () async {
      await open();
      socket.push(
        SocketEvent(
          event: 'ticket.message',
          ticketId: 'someone-else',
          data: {
            'message': {
              'id': 'x',
              'ticketId': 'someone-else',
              'senderRole': 'admin',
              'senderName': 'S',
              'body': 'nope',
              'attachments': [],
              'createdAt': '2026-10-05T12:00:00.000Z',
            },
          },
        ),
      );
      await settle();
      expect(bloc.state.messages, isEmpty);
    });

    test('resolving live locks the composer without a refetch', () async {
      await open();
      socket.push(
        SocketEvent(
          event: 'ticket.updated',
          ticketId: 't1',
          data: {
            'ticket': {
              'id': 't1',
              'number': 2041,
              'label': 'FS-2041',
              'communityId': 'c1',
              'subject': 'Payment failed',
              'status': 'resolved',
              'unreadCount': 0,
              'lastMessageAt': '2026-10-06T11:00:00.000Z',
              'resolvedAt': '2026-10-06T11:00:00.000Z',
            },
          },
        ),
      );
      await settle();
      expect(bloc.state.isLocked, isTrue);
      expect(bloc.state.ticket!.canRate, isTrue);
    });

    test('a live move to In progress adds the status pill, once', () async {
      repo.ticket = fakeTicket(status: TicketStatus.open);
      await open();
      Map<String, dynamic> update() => {
        'ticket': {
          'id': 't1',
          'number': 2041,
          'label': 'FS-2041',
          'communityId': 'c1',
          'subject': 'Payment failed',
          'status': 'in_progress',
          'unreadCount': 0,
          'lastMessageAt': '2026-10-05T12:00:00.000Z',
        },
      };
      socket.push(
        SocketEvent(event: 'ticket.updated', ticketId: 't1', data: update()),
      );
      await settle();
      // A repeat of the same status is not a change.
      socket.push(
        SocketEvent(event: 'ticket.updated', ticketId: 't1', data: update()),
      );
      await settle();

      final pills = bloc.state.messages.where((m) => m.isSystem).toList();
      expect(pills, hasLength(1));
      expect(pills.single.body, 'Status changed to In progress');
    });
  });

  group('reconnect', () {
    test('refetches and merges what was missed while offline', () async {
      repo.history = [serverMessage('m1', minute: 1)];
      await open();
      expect(bloc.state.messages.map((m) => m.id), ['m1']);

      socket.setStatus(SocketStatus.offline);
      await settle();
      expect(bloc.state.isReconnecting, isTrue);

      // Support replied while the app was disconnected — nothing replays.
      repo.history = [
        serverMessage('m2', minute: 9),
        serverMessage('m1', minute: 1),
      ];
      socket.setStatus(SocketStatus.live);
      await settle();

      expect(bloc.state.messages.map((m) => m.id), ['m1', 'm2']);
      expect(bloc.state.isReconnecting, isFalse);
    });
  });

  group('rating', () {
    test('rates a resolved ticket exactly once', () async {
      repo.ticket = fakeTicket(status: TicketStatus.resolved);
      await open();
      bloc.add(const TicketChatEvent.rated(4, 'Quick'));
      await settle();
      expect(bloc.state.ticket!.rating, 4);
      expect(bloc.state.rating.isLoaded, isTrue);

      // A second attempt is refused client-side, without a request.
      repo.ticket = repo.ticket.copyWith(rating: 4);
      bloc.add(const TicketChatEvent.rated(1, null));
      await settle();
      expect(bloc.state.ticket!.rating, 4);
    });

    test('an unresolved ticket cannot be rated', () async {
      await open();
      bloc.add(const TicketChatEvent.rated(5, null));
      await settle();
      expect(bloc.state.ticket!.rating, isNull);
    });
  });
}
