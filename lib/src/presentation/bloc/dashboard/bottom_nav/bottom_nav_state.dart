part of 'bottom_nav_bloc.dart';

@freezed
sealed class BottomNavState with _$BottomNavState {
  const factory BottomNavState({required int selectedIndex}) =
      _BottomNavState;

  factory BottomNavState.initial() => const BottomNavState(selectedIndex: 0);
}
