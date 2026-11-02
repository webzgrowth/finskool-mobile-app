part of 'notifications_inbox_bloc.dart';

@freezed
class NotificationsInboxEvent with _$NotificationsInboxEvent {
  /// First page — on open and on every return to the foreground.
  const factory NotificationsInboxEvent.load() = _Load;

  const factory NotificationsInboxEvent.loadMore() = _LoadMore;

  /// A tap on a row. Optimistic, rolled back if the server refuses.
  const factory NotificationsInboxEvent.markRead(String id) = _MarkRead;

  const factory NotificationsInboxEvent.markAllRead() = _MarkAllRead;

  /// A live row (new, or an existing one re-sent as unread).
  const factory NotificationsInboxEvent.received(AppNotification item) =
      _Received;
}
