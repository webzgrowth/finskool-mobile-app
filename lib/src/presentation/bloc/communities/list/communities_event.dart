part of 'communities_bloc.dart';

@freezed
class CommunitiesEvent with _$CommunitiesEvent {
  const factory CommunitiesEvent.loadCommunities() = _LoadCommunities;

  /// Re-reads the catalog **without** the loading state, so a list already on
  /// screen doesn't flash its skeleton. Used after a purchase and when the app
  /// returns to the foreground — a payment confirmed late by the webhook shows
  /// up here.
  const factory CommunitiesEvent.refresh() = _Refresh;

  /// Sign-out: drop the previous account's catalog, subscriptions and badges.
  const factory CommunitiesEvent.reset() = _Reset;

  /// For communities whose price isn't public.
  const factory CommunitiesEvent.requestPricing(String communityId) =
      _RequestPricing;
}
