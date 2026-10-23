part of 'services_catalog_bloc.dart';

@freezed
class ServicesCatalogEvent with _$ServicesCatalogEvent {
  /// Loads once; a no-op if the catalog is already there.
  const factory ServicesCatalogEvent.load() = _Load;

  /// Pull-to-refresh: refetches regardless.
  const factory ServicesCatalogEvent.refresh() = _Refresh;
}
