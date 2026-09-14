import 'package:finskool/src/comman/enum.dart';
import 'compliance_bloc.dart';

/// PAN is five letters, four digits, then a letter — `ABCDE1234F`.
final _panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');

/// `DD/MM/YY` or `DD/MM/YYYY`, matching the field's placeholder.
final _dobPattern = RegExp(r'^\d{2}/\d{2}/(\d{2}|\d{4})$');

/// Field validation for [ComplianceState], kept out of the bloc file to
/// stay under the project's per-file line limit (same arrangement as
/// `sign_up_form_validation.dart`).
extension ComplianceValidation on ComplianceState {
  ComplianceState validated() {
    final dobError = _validateDob(dateOfBirth);
    final panError = _validatePan(pan);
    final hasError = dobError != null || panError != null;

    return copyWith(
      dateOfBirthError: dobError,
      panError: panError,
      state: hasError ? RequestState.error : RequestState.loading,
      // The tick is a legal confirmation, not a field — surface it as a
      // message rather than an inline error under an input.
      message: !hasError && !confirmed
          ? 'Please confirm these details match your official documents.'
          : '',
    ).copyWith(
      state: hasError || !confirmed ? RequestState.error : RequestState.loading,
    );
  }

  String? _validateDob(String value) {
    if (value.trim().isEmpty) return 'Date of birth is required.';
    if (!_dobPattern.hasMatch(value.trim())) return 'Use DD/MM/YY.';
    return null;
  }

  String? _validatePan(String value) {
    if (value.trim().isEmpty) return 'PAN is required.';
    if (!_panPattern.hasMatch(value.trim().toUpperCase())) {
      return 'Enter a valid PAN, e.g. ABCDE1234F.';
    }
    return null;
  }
}
