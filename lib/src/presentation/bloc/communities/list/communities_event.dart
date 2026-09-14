part of 'communities_bloc.dart';

@freezed
class CommunitiesEvent with _$CommunitiesEvent {
  const factory CommunitiesEvent.loadCommunities() = _LoadCommunities;

  /// Called after a successful (mocked) purchase + compliance.
  const factory CommunitiesEvent.unlockCommunity(String communityId) =
      _UnlockCommunity;

  /// For communities whose price isn't public.
  const factory CommunitiesEvent.requestPricing(String communityId) =
      _RequestPricing;
}
