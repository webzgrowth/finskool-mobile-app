import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';

/// The pure list logic behind `TicketChatBloc`, held **oldest → newest** —
/// the order the screen draws.
///
/// This is where the socket's two awkward guarantees get absorbed:
///
/// * **A member's own message arrives twice** — as the `ack` to the send and
///   again as a `ticket.message` event, in either order (§6.3.1).
/// * **Nothing is replayed after a disconnect** (§6.3.3), so a reconnect
///   refetches the latest page and merges it over what is on screen.
///
/// Every operation is idempotent: applying the same message twice, or in
/// either order, converges on the same list. That is what makes the dedupe
/// safe rather than merely likely.
extension TicketMessagePatch on List<TicketMessageModel> {
  List<TicketMessageModel> sortedByTime() =>
      [...this]..sort((a, b) => a.createdAt.compareTo(b.createdAt));

  /// The immediate "sending" bubble, keyed by our own `clientMessageId`.
  List<TicketMessageModel> withOptimistic(TicketMessageModel bubble) => [
    ...this,
    bubble,
  ];

  /// Lands a message the server confirmed — from the ack **or** the event.
  ///
  /// Matched first by `clientMessageId` (which is how an optimistic bubble
  /// finds its real counterpart, and why a retry must reuse the id), then by
  /// `id`. Only an unseen message is inserted. A message from the other side
  /// has no `clientMessageId` we know, so it simply inserts.
  List<TicketMessageModel> withDelivered(TicketMessageModel real) {
    final byClient = real.clientMessageId == null
        ? -1
        : indexWhere((m) => m.clientMessageId == real.clientMessageId);
    final index = byClient != -1
        ? byClient
        : indexWhere((m) => m.id == real.id);

    final next = [...this];
    if (index == -1) {
      next.add(real);
    } else {
      next[index] = real;
    }
    return next.sortedByTime();
  }

  List<TicketMessageModel> withDelivery(
    String clientMessageId,
    MessageDelivery delivery,
  ) => map(
    (m) => m.clientMessageId == clientMessageId && m.isLocal
        ? m.copyWith(delivery: delivery)
        : m,
  ).toList();

  List<TicketMessageModel> without(String clientMessageId) =>
      where((m) => m.clientMessageId != clientMessageId || !m.isLocal).toList();

  /// An **older** page, which arrives newest-first (§6.1) and so is reversed
  /// before it goes on the front. Rows already held are dropped.
  List<TicketMessageModel> withEarlier(List<TicketMessageModel> newestFirst) {
    final known = map((m) => m.id).toSet();
    final older = newestFirst.reversed.where((m) => !known.contains(m.id));
    return [...older, ...this];
  }

  /// A refetched latest page merged over the current list, by id.
  ///
  /// Unsent bubbles survive — an optimistic one the server has not confirmed
  /// is the member's work, not stale data — and anything the page also holds
  /// replaces its local copy.
  List<TicketMessageModel> mergedWithLatest(
    List<TicketMessageModel> newestFirst,
  ) {
    var merged = this;
    for (final m in newestFirst.reversed) {
      merged = merged.withDelivered(m);
    }
    return merged;
  }

  /// Unsent bubbles that should be retried or surfaced after a reconnect.
  List<TicketMessageModel> get unsent =>
      where((m) => m.isLocal && m.delivery != MessageDelivery.sent).toList();
}
