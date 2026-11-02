part of 'notifications_inbox_bloc.dart';

@freezed
sealed class NotificationsInboxState with _$NotificationsInboxState {
  const factory NotificationsInboxState({
    @Default(RequestState.empty) RequestState state,
    @Default(<AppNotification>[]) List<AppNotification> items,
    @Default(1) int page,
    @Default(false) bool hasMore,
    @Default(false) bool isLoadingMore,

    /// The last page request failed. Stops the scroll listener re-firing at
    /// the bottom on every tick; cleared by a pull-to-refresh / reload.
    @Default(false) bool loadMoreFailed,
    @Default('') String message,
  }) = _NotificationsInboxState;

  factory NotificationsInboxState.initial() => const NotificationsInboxState();

  const NotificationsInboxState._();

  int get unread => items.where((n) => !n.isRead).length;
}
