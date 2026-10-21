import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_message_patch.dart';

TicketMessageModel _msg(
  String id, {
  String? client,
  String role = 'admin',
  int minute = 0,
  String? body,
  MessageDelivery delivery = MessageDelivery.sent,
}) => TicketMessageModel(
  id: id,
  ticketId: 't1',
  senderRole: role,
  senderName: role == 'user' ? 'You' : 'Support',
  body: body ?? id,
  clientMessageId: client,
  createdAt: DateTime.utc(2026, 10, 5, 10, minute),
  delivery: delivery,
);

TicketMessageModel _optimistic(String client, {int minute = 5}) => _msg(
  'local-$client',
  client: client,
  role: 'user',
  minute: minute,
  delivery: MessageDelivery.sending,
);

void main() {
  group('own message arrives twice (ack AND event)', () {
    final real = _msg('srv-1', client: 'c1', role: 'user', minute: 5);

    test('ack first, then the event: one bubble', () {
      var list = <TicketMessageModel>[_optimistic('c1')];
      list = list.withDelivered(real); // the ack
      list = list.withDelivered(real); // the ticket.message event
      expect(list, hasLength(1));
      expect(list.single.id, 'srv-1');
      expect(list.single.isLocal, isFalse);
    });

    test('event first, then the ack: still one bubble', () {
      var list = <TicketMessageModel>[_optimistic('c1')];
      list = list.withDelivered(real); // the event wins the race
      list = list.withDelivered(real); // the ack
      expect(list, hasLength(1));
    });

    test('the event can land with no optimistic bubble at all', () {
      // The member's OTHER device sent it.
      final list = <TicketMessageModel>[].withDelivered(real);
      expect(list.map((m) => m.id), ['srv-1']);
    });

    test('applying the same message repeatedly is idempotent', () {
      var list = <TicketMessageModel>[_optimistic('c1')];
      for (var i = 0; i < 5; i++) {
        list = list.withDelivered(real);
      }
      expect(list, hasLength(1));
    });
  });

  group('retry', () {
    test(
      'a failed bubble keeps its clientMessageId, so a retry replaces it',
      () {
        var list = <TicketMessageModel>[_optimistic('c1')]
            .withDelivery('c1', MessageDelivery.failed);
        expect(list.single.delivery, MessageDelivery.failed);

        list = list.withDelivery('c1', MessageDelivery.sending);
        list = list.withDelivered(
          _msg('srv-9', client: 'c1', role: 'user', minute: 6),
        );
        expect(list, hasLength(1), reason: 'the retry did not double-post');
      },
    );

    test(
      'withDelivery only touches the local bubble, never a confirmed one',
      () {
        final confirmed = _msg('srv-1', client: 'c1', role: 'user');
        final list = [confirmed].withDelivery('c1', MessageDelivery.failed);
        expect(list.single.delivery, MessageDelivery.sent);
      },
    );

    test('without() drops only the unconfirmed bubble', () {
      final list = [_optimistic('c1'), _msg('a', minute: 1)].without('c1');
      expect(list.map((m) => m.id), ['a']);
    });
  });

  group('history paging', () {
    test(
      'an older page arrives newest-first and is reversed onto the front',
      () {
        final list = [_msg('m4', minute: 4), _msg('m5', minute: 5)];
        final older = [
          _msg('m3', minute: 3),
          _msg('m2', minute: 2),
        ]; // newest 1st
        expect(list.withEarlier(older).map((m) => m.id), [
          'm2',
          'm3',
          'm4',
          'm5',
        ]);
      },
    );

    test('rows already held are not duplicated', () {
      final list = [_msg('m4', minute: 4)];
      final page = [_msg('m4', minute: 4), _msg('m3', minute: 3)];
      expect(list.withEarlier(page).map((m) => m.id), ['m3', 'm4']);
    });
  });

  group('reconnect resync', () {
    test('a refetched page merges by id without losing an unsent bubble', () {
      final onScreen = [_msg('m1', minute: 1), _optimistic('c9', minute: 8)];
      // While offline, support replied; the page is newest-first.
      final latest = [
        _msg('m3', minute: 7),
        _msg('m2', minute: 3),
        _msg('m1', minute: 1),
      ];

      final merged = onScreen.mergedWithLatest(latest);
      expect(merged.map((m) => m.id), ['m1', 'm2', 'm3', 'local-c9']);
      expect(merged.unsent.single.clientMessageId, 'c9');
    });

    test('a message the server now holds replaces its local copy', () {
      final onScreen = [_optimistic('c1', minute: 5)];
      final latest = [_msg('srv-1', client: 'c1', role: 'user', minute: 5)];
      final merged = onScreen.mergedWithLatest(latest);
      expect(merged, hasLength(1));
      expect(merged.single.id, 'srv-1');
      expect(merged.unsent, isEmpty);
    });
  });

  test('the list always stays in time order', () {
    final list = <TicketMessageModel>[]
        .withDelivered(_msg('b', minute: 9))
        .withDelivered(_msg('a', minute: 2))
        .withDelivered(_msg('c', minute: 5));
    expect(list.map((m) => m.id), ['a', 'c', 'b']);
  });
}
