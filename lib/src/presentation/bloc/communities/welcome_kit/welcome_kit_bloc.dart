import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/min_skeleton.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/domain/usecases/community/get_welcome_kit.dart';

part 'welcome_kit_event.dart';
part 'welcome_kit_state.dart';
part 'welcome_kit_bloc.freezed.dart';

/// The welcome kit under one subscription. `@injectable`, not `@singleton`:
/// it belongs to a single Subscription Detail screen and a single community,
/// so the screen scopes its own via `BlocProvider(create: …)` and a kit can
/// never leak from one subscription into the next one opened.
///
/// "Nothing to show" (`state == loaded`, `kit == null`) is deliberately not an
/// error — see `CommunitiesRemoteDatasource.getWelcomeKit`.
@injectable
class WelcomeKitBloc extends Bloc<WelcomeKitEvent, WelcomeKitState> {
  WelcomeKitBloc(this._getWelcomeKit) : super(WelcomeKitState.initial()) {
    on<WelcomeKitEvent>((event, emit) async {
      await event.map(
        load: (e) => _load(e.communityId, emit),
        retried: (_) => _load(state.communityId, emit),
      );
    });
  }

  final GetWelcomeKit _getWelcomeKit;

  Future<void> _load(String communityId, Emitter<WelcomeKitState> emit) async {
    emit(
      state.copyWith(
        state: RequestState.loading,
        message: '',
        communityId: communityId,
      ),
    );
    final result = await holdSkeletonOnFailure(
      () => _getWelcomeKit.execute(communityId),
    );
    result.fold(
      (failure) => emit(
        state.copyWith(state: RequestState.error, message: failure.message),
      ),
      (kit) => emit(state.copyWith(state: RequestState.loaded, kit: kit)),
    );
  }
}
