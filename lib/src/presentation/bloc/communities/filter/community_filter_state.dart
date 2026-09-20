part of 'community_filter_bloc.dart';

@freezed
sealed class CommunityFilterState with _$CommunityFilterState {
  const factory CommunityFilterState({required String query}) =
      _CommunityFilterState;

  factory CommunityFilterState.initial() =>
      const CommunityFilterState(query: '');
}
