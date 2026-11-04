part of 'performance_boards_bloc.dart';

@freezed
class PerformanceBoardsEvent with _$PerformanceBoardsEvent {
  const factory PerformanceBoardsEvent.load() = _Load;
  const factory PerformanceBoardsEvent.reset() = _Reset;
}
