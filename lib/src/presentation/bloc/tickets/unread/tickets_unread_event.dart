part of 'tickets_unread_bloc.dart';

@freezed
class TicketsUnreadEvent with _$TicketsUnreadEvent {
  /// The member is signed in: open the socket and read the badge. Dispatched
  /// by `DashboardShellScreen` — logging in only updates `LoginFormBloc`, so
  /// nothing else knows a session now exists.
  const factory TicketsUnreadEvent.started() = _Started;

  /// Re-reads `GET /unread-count`. Fired on every relevant socket event
  /// rather than adjusting the number by hand: the spec calls refetching
  /// "the easiest and safest" way to keep the badge right.
  const factory TicketsUnreadEvent.refresh() = _Refresh;

  /// Logged out. Closes the socket and zeroes the badge.
  const factory TicketsUnreadEvent.stopped() = _Stopped;
}
