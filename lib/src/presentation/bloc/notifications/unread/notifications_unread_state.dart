part of 'notifications_unread_bloc.dart';

@freezed
sealed class NotificationsUnreadState with _$NotificationsUnreadState {
  const factory NotificationsUnreadState({
    @Default(0) int count,

    /// The notification that just arrived over the socket. The in-app banner
    /// drops from the top for it; the next one replaces it.
    AppNotification? incoming,
  }) = _NotificationsUnreadState;

  factory NotificationsUnreadState.initial() =>
      const NotificationsUnreadState();
}
