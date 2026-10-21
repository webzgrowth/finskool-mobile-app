part of 'tickets_unread_bloc.dart';

@freezed
sealed class TicketsUnreadState with _$TicketsUnreadState {
  const factory TicketsUnreadState({required int count}) = _TicketsUnreadState;

  factory TicketsUnreadState.initial() => const TicketsUnreadState(count: 0);
}
