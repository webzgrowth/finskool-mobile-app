import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_summary_model.dart';

/// The pure list transforms behind `TicketsListBloc`, kept out of the bloc so
/// they can be tested without a socket — the same split `FeedReactionPatch`
/// makes for the feed.
extension TicketListPatch on List<TicketModel> {
  /// Newest activity first, which is how the API orders the list and how a
  /// row that just received a reply must end up: at the top.
  List<TicketModel> sortedByActivity() =>
      [...this]..sort((a, b) => b.lastMessageAt.compareTo(a.lastMessageAt));

  /// Merges a socket summary into the list.
  ///
  /// A known id has only the fields the summary carries patched in (the rest
  /// — description, community, attachments — must survive). An **unknown**
  /// id becomes a new row, which is how `ticket.created` from the member's
  /// other device appears without a refetch.
  List<TicketModel> applySummary(TicketSummaryModel summary) {
    final index = indexWhere((t) => t.id == summary.id);
    final next = [...this];
    if (index == -1) {
      next.add(summary.toTicket());
    } else {
      next[index] = summary.mergeInto(next[index]);
    }
    return next.sortedByActivity();
  }

  /// `ticket.read` — the member read it on another device.
  List<TicketModel> withRead(String ticketId) =>
      map((t) => t.id == ticketId ? t.copyWith(unreadCount: 0) : t).toList();

  /// Appends a page, dropping any row already held. Pages are cursor-based
  /// and a socket event may have inserted a row the next page also returns.
  List<TicketModel> appendPage(List<TicketModel> page) {
    final known = map((t) => t.id).toSet();
    return [
      ...this,
      ...page.where((t) => !known.contains(t.id)),
    ].sortedByActivity();
  }

  /// Chip counts. Only trustworthy once every page is loaded — the API has
  /// no counts endpoint — so callers check `hasMore` before showing them.
  int countWhere(bool Function(TicketModel) test) => where(test).length;
}
