part of 'feed_filter_bloc.dart';

@freezed
class FeedFilterEvent with _$FeedFilterEvent {
  const factory FeedFilterEvent.queryChanged(String query) = _QueryChanged;
  const factory FeedFilterEvent.cleared() = _Cleared;
}
