import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/min_skeleton.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/usecases/community/get_communities.dart';
import 'package:finskool/src/domain/usecases/community/request_pricing.dart';

part 'communities_event.dart';
part 'communities_state.dart';
part 'communities_bloc.freezed.dart';

/// Owns the community catalog and its access state. Search text lives in
/// [CommunityFilterBloc] and the in-flight purchase in
/// [CommunityPurchaseBloc] — three responsibilities, three blocs, per
/// CLAUDE.md's "Bloc granularity" rule.
@singleton
class CommunitiesBloc extends Bloc<CommunitiesEvent, CommunitiesState> {
  CommunitiesBloc(this._getCommunities, this._requestPricing)
    : super(CommunitiesState.initial()) {
    on<CommunitiesEvent>((event, emit) async {
      await event.map(
        loadCommunities: (_) => _load(emit),
        reset: (_) async {
          _epoch++;
          emit(CommunitiesState.initial());
        },
        refresh: (_) async {
          final epoch = _epoch;
          final result = await _getCommunities.execute();
          if (epoch != _epoch) return;
          // A failed background refresh keeps what is already shown.
          result.fold(
            (_) {},
            (communities) => emit(
              state.copyWith(
                state: RequestState.loaded,
                communities: communities,
                message: '',
              ),
            ),
          );
        },
        requestPricing: (value) async {
          emit(state.copyWith(state: RequestState.loading, message: ''));
          final result = await _requestPricing.execute(value.communityId);
          emit(
            result.fold(
              (failure) => state.copyWith(
                state: RequestState.error,
                message: failure.message,
              ),
              (_) => state.copyWith(
                state: RequestState.loaded,
                message: 'We\'ve sent your request. Our team will be in touch.',
              ),
            ),
          );
        },
      );
    });
  }

  final GetCommunities _getCommunities;
  final RequestPricing _requestPricing;

  /// Bumped by `reset`, so a response for a signed-out session is dropped.
  int _epoch = 0;

  Future<void> _load(Emitter<CommunitiesState> emit) async {
    final epoch = _epoch;
    emit(state.copyWith(state: RequestState.loading, message: ''));
    final result = await holdSkeletonOnFailure(_getCommunities.execute);
    if (epoch != _epoch) return;
    emit(
      result.fold(
        (failure) =>
            state.copyWith(state: RequestState.error, message: failure.message),
        (communities) => state.copyWith(
          state: RequestState.loaded,
          communities: communities,
          message: '',
        ),
      ),
    );
  }
}
