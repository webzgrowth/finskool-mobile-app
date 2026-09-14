part of 'compliance_bloc.dart';

@freezed
class ComplianceEvent with _$ComplianceEvent {
  const factory ComplianceEvent.initial() = _Initial;
  const factory ComplianceEvent.dateOfBirthChanged(String value) =
      _DateOfBirthChanged;
  const factory ComplianceEvent.panChanged(String value) = _PanChanged;
  const factory ComplianceEvent.confirmationToggled() = _ConfirmationToggled;
  const factory ComplianceEvent.submit() = _Submit;
}
