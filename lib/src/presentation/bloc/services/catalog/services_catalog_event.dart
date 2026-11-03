part of 'services_catalog_bloc.dart';

@freezed
class ServicesCatalogEvent with _$ServicesCatalogEvent {
  /// Loads once; a no-op if the catalog is already there.
  const factory ServicesCatalogEvent.load() = _Load;

  /// Pull-to-refresh: refetches regardless.
  const factory ServicesCatalogEvent.refresh() = _Refresh;

  /// Sign-out: the catalog is cached "until forced", so without this the next
  /// login would skip the load (and its skeleton) and reuse the last session's.
  const factory ServicesCatalogEvent.reset() = _Reset;
}
