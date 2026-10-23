import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/usecases/services/get_service_catalog.dart';

part 'services_catalog_event.dart';
part 'services_catalog_state.dart';
part 'services_catalog_bloc.freezed.dart';

/// The Services tab's catalog. A `@singleton` like `CommunitiesBloc`, so
/// switching tabs doesn't refetch; the screen asks for a `load`, which is a
/// no-op once the list is already on screen. Pull-to-refresh forces it.
///
/// Search text lives in `ServicesFilterBloc` — "what is being searched" and
/// "the catalog itself" are different responsibilities.
@singleton
class ServicesCatalogBloc
    extends Bloc<ServicesCatalogEvent, ServicesCatalogState> {
  ServicesCatalogBloc(this._getCatalog)
    : super(ServicesCatalogState.initial()) {
    on<ServicesCatalogEvent>((event, emit) async {
      await event.map(
        load: (_) => _load(emit, force: false),
        refresh: (_) => _load(emit, force: true),
      );
    });
  }

  final GetServiceCatalog _getCatalog;

  Future<void> _load(
    Emitter<ServicesCatalogState> emit, {
    required bool force,
  }) async {
    if (!force && (state.state.isLoaded || state.state.isLoading)) return;
    // A refresh keeps the list on screen rather than blanking it.
    if (!state.state.isLoaded) {
      emit(state.copyWith(state: RequestState.loading, message: ''));
    }
    final result = await _getCatalog.execute();
    result.fold(
      (failure) => emit(
        state.copyWith(
          // Keep a list the member is already reading; only a first load that
          // fails becomes an error screen.
          state: state.services.isEmpty
              ? RequestState.error
              : RequestState.loaded,
          message: failure.message,
        ),
      ),
      (services) => emit(
        state.copyWith(
          state: RequestState.loaded,
          services: services,
          message: '',
        ),
      ),
    );
  }
}
