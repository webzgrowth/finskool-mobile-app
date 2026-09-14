part of 'compliance_bloc.dart';

@freezed
sealed class ComplianceState with _$ComplianceState {
  const factory ComplianceState({
    required RequestState state,
    required String message,
    required String dateOfBirth,
    required String pan,
    required bool confirmed,
    String? dateOfBirthError,
    String? panError,
  }) = _ComplianceState;

  factory ComplianceState.initial() => const ComplianceState(
        state: RequestState.empty,
        message: '',
        dateOfBirth: '',
        pan: '',
        confirmed: false,
      );
}
