import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';

import 'compliance_bloc.dart';

/// The server's own rule (`kyc.md`): 5 letters, 4 digits, 1 letter. Deliberately
/// no stricter — a tighter client check (e.g. the CBDT holder-type letter)
/// would refuse PANs the server accepts, including the contract's samples.
final _panPattern = RegExp(r'^[A-Z]{5}[0-9]{4}[A-Z]$');

/// Field validation for [ComplianceState], kept out of the bloc file to
/// stay under the project's per-file line limit (same arrangement as
/// `sign_up_form_validation.dart`).
/// The date-of-birth rule, shared by submit and by the field itself (which
/// checks as soon as the 10th character is typed).
String? validateDateOfBirth(String value) {
  if (value.trim().isEmpty) return 'Date of birth is required.';
  // `DD/MM/YYYY`, a real calendar date — the API takes `YYYY-MM-DD` and a
  // two-digit year is ambiguous, so it is not accepted.
  final iso = KycDetails(dateOfBirth: value, panNumber: '').isoDateOfBirth;
  if (iso == null) {
    // Right shape, impossible date (31/02) → say so; otherwise it's the format.
    return RegExp(r'^\d{2}/\d{2}/\d{4}$').hasMatch(value.trim())
        ? 'Enter a valid date.'
        : 'Use DD/MM/YYYY.';
  }
  // "1900-01-01 up to today" (the API's rule) — today itself is accepted.
  final now = DateTime.now();
  final today = KycDetails(
    dateOfBirth: '${now.day}/${now.month}/${now.year}',
    panNumber: '',
  ).isoDateOfBirth!;
  if (iso.compareTo('1900-01-01') < 0 || iso.compareTo(today) > 0) {
    return 'Enter your real date of birth.';
  }
  return null;
}

extension ComplianceValidation on ComplianceState {
  ComplianceState validated() {
    final dobError = validateDateOfBirth(dateOfBirth);
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

  String? _validatePan(String value) {
    if (value.trim().isEmpty) return 'PAN is required.';
    if (!_panPattern.hasMatch(value.trim().toUpperCase())) {
      return 'Enter a valid PAN, e.g. ABCDE1234F.';
    }
    return null;
  }
}
