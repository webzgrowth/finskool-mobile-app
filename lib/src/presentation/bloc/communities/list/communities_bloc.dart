import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/usecases/community/get_communities.dart';
import 'package:finskool/src/domain/usecases/community/request_pricing.dart';
import 'package:finskool/src/domain/usecases/community/unlock_community.dart';

part 'communities_event.dart';
part 'communities_state.dart';
part 'communities_bloc.freezed.dart';

/// Owns the community catalog and its access state. Search text lives in
/// [CommunityFilterBloc] and the in-flight purchase in
/// [CommunityPurchaseBloc] — three responsibilities, three blocs, per
/// CLAUDE.md's "Bloc granularity" rule.
@singleton
class CommunitiesBloc extends Bloc<CommunitiesEvent, CommunitiesState> {
  CommunitiesBloc(this._getCommunities, this._unlockCommunity,
      this._requestPricing)
      : super(CommunitiesState.initial()) {
    on<CommunitiesEvent>((event, emit) async {
      await event.map(
        loadCommunities: (_) => _load(emit),
        unlockCommunity: (value) async {
          final result = await _unlockCommunity.execute(value.communityId);
          await result.fold(
            (failure) async => emit(state.copyWith(
                state: RequestState.error, message: failure.message)),
            // Reload rather than patch in place: the repository is the one
            // that knows how unlocks are persisted.
            (_) => _load(emit),
          );
        },
        requestPricing: (value) async {
          emit(state.copyWith(state: RequestState.loading, message: ''));
          final result = await _requestPricing.execute(value.communityId);
          emit(result.fold(
            (failure) => state.copyWith(
                state: RequestState.error, message: failure.message),
            (_) => state.copyWith(
              state: RequestState.loaded,
              message: 'We\'ve sent your request. Our team will be in touch.',
            ),
          ));
        },
      );
    });
  }

  final GetCommunities _getCommunities;
  final UnlockCommunity _unlockCommunity;
  final RequestPricing _requestPricing;

  Future<void> _load(Emitter<CommunitiesState> emit) async {
    emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await _getCommunities.execute();
    emit(result.fold(
      (failure) =>
          state.copyWith(state: RequestState.error, message: failure.message),
      (communities) => state.copyWith(
        state: RequestState.loaded,
        communities: communities,
        message: '',
      ),
    ));
  }
}
