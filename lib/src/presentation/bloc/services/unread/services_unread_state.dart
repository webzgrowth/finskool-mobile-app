part of 'services_unread_bloc.dart';

@freezed
sealed class ServicesUnreadState with _$ServicesUnreadState {
  const factory ServicesUnreadState({required int count}) =
      _ServicesUnreadState;

  factory ServicesUnreadState.initial() => const ServicesUnreadState(count: 0);
}
