part of 'bottom_nav_bloc.dart';

@freezed
abstract class BottomNavEvent with _$BottomNavEvent {
  const factory BottomNavEvent.tabChanged(int index) = _TabChanged;
}
