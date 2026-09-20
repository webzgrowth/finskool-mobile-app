part of 'communities_bloc.dart';

@freezed
sealed class CommunitiesState with _$CommunitiesState {
  const factory CommunitiesState({
    required RequestState state,
    required String message,
    required List<CommunityModel> communities,
  }) = _CommunitiesState;

  factory CommunitiesState.initial() => const CommunitiesState(
        state: RequestState.empty,
        message: '',
        communities: [],
      );

  const CommunitiesState._();

  /// Subscribed communities pin to the top, per the designer's note on the
  /// canvas ("Subscribed community' card will be pinned", `911:20521`).
  /// Order is otherwise preserved, so the catalog's own ordering survives.
  List<CommunityModel> get pinnedFirst {
    final subscribed =
        communities.where((c) => c.access.isSubscribed).toList();
    final rest = communities.where((c) => !c.access.isSubscribed).toList();
    return [...subscribed, ...rest];
  }

  /// Drives the Communities tab's bottom-nav badge.
  int get totalNewAnnouncements =>
      communities.fold(0, (sum, c) => sum + c.newAnnouncements);
}
