part of 'community_filter_bloc.dart';

@freezed
class CommunityFilterEvent with _$CommunityFilterEvent {
  const factory CommunityFilterEvent.queryChanged(String query) =
      _QueryChanged;
  const factory CommunityFilterEvent.cleared() = _Cleared;
}
