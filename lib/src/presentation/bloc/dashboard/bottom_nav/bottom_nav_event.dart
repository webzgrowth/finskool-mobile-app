part of 'bottom_nav_bloc.dart';

@freezed
abstract class BottomNavEvent with _$BottomNavEvent {
  const factory BottomNavEvent.tabChanged(int index) = _TabChanged;

  /// Back to Feed. This bloc is a `@singleton` built eagerly at startup, so
  /// the selected tab outlives a logout — without this, signing out from
  /// Profile left the index at 3 and the next login opened on Profile.
  const factory BottomNavEvent.reset() = _Reset;
}
