part of 'services_unread_bloc.dart';

@freezed
class ServicesUnreadEvent with _$ServicesUnreadEvent {
  /// Signed in: read the badge. Dispatched by `DashboardShellScreen`.
  const factory ServicesUnreadEvent.started() = _Started;
  const factory ServicesUnreadEvent.refresh() = _Refresh;

  /// Signed out: zero the badge.
  const factory ServicesUnreadEvent.stopped() = _Stopped;
}
