part of 'services_filter_bloc.dart';

@freezed
class ServicesFilterEvent with _$ServicesFilterEvent {
  const factory ServicesFilterEvent.queryChanged(String query) = _QueryChanged;
  const factory ServicesFilterEvent.cleared() = _Cleared;
}
