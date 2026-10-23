part of 'service_requests_bloc.dart';

@freezed
class ServiceRequestsEvent with _$ServiceRequestsEvent {
  const factory ServiceRequestsEvent.load() = _Load;
  const factory ServiceRequestsEvent.loadMore() = _LoadMore;

  /// Internal: a `service.*` push.
  const factory ServiceRequestsEvent.pushed(SocketEvent event) = _Pushed;

  /// Internal: the socket came back — nothing is replayed, so refetch.
  const factory ServiceRequestsEvent.reconnected() = _Reconnected;
}
