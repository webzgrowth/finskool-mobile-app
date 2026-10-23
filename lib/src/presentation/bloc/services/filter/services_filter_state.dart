part of 'services_filter_bloc.dart';

@freezed
sealed class ServicesFilterState with _$ServicesFilterState {
  const factory ServicesFilterState({required String query}) =
      _ServicesFilterState;

  factory ServicesFilterState.initial() => const ServicesFilterState(query: '');
}
