part of 'service_requests_bloc.dart';

@freezed
sealed class ServiceRequestsState with _$ServiceRequestsState {
  const factory ServiceRequestsState({
    required RequestState state,
    required List<ServiceRequestModel> requests,
    required bool isLoadingMore,
    required String message,
    String? cursor,
  }) = _ServiceRequestsState;

  factory ServiceRequestsState.initial() => const ServiceRequestsState(
    state: RequestState.empty,
    requests: [],
    isLoadingMore: false,
    message: '',
  );
}
