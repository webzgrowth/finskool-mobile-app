part of 'notifications_unread_bloc.dart';

@freezed
class NotificationsUnreadEvent with _$NotificationsUnreadEvent {
  /// Signed in: open the socket and read the count.
  const factory NotificationsUnreadEvent.started() = _Started;

  /// Re-read the count (foreground, a push arrived, inbox changed).
  const factory NotificationsUnreadEvent.refresh() = _Refresh;

  /// Something the member just read in the inbox: take it off the badge
  /// without a round-trip.
  const factory NotificationsUnreadEvent.decremented(int by) = _Decremented;

  const factory NotificationsUnreadEvent.allRead() = _AllRead;

  /// A live `notification.created` frame.
  const factory NotificationsUnreadEvent.received(NotificationEvent event) =
      _Received;

  /// Signed out.
  const factory NotificationsUnreadEvent.stopped() = _Stopped;
}
