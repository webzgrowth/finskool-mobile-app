part of 'services_catalog_bloc.dart';

@freezed
sealed class ServicesCatalogState with _$ServicesCatalogState {
  const factory ServicesCatalogState({
    required RequestState state,
    required List<ServiceModel> services,
    required String message,
  }) = _ServicesCatalogState;

  factory ServicesCatalogState.initial() => const ServicesCatalogState(
    state: RequestState.empty,
    services: [],
    message: '',
  );
}
