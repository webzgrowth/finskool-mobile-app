part of 'notifications_unread_bloc.dart';

@freezed
sealed class NotificationsUnreadState with _$NotificationsUnreadState {
  const factory NotificationsUnreadState({@Default(0) int count}) =
      _NotificationsUnreadState;

  factory NotificationsUnreadState.initial() =>
      const NotificationsUnreadState();
}
