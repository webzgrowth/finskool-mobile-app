import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';

import 'compliance_bloc.dart';

/// A real Indian PAN, not just "5 letters, 4 digits, a letter":
/// `AAA`+`[holder type]`+`[first letter of name]`+`NNNN`+`[check letter]`.
/// The 4th character is the CBDT-assigned holder-type code — `P` individual,
/// `C` company, `H` HUF, `A` AOP, `B` BOI, `G` government, `J` artificial
/// juridical person, `L` local authority, `F` firm, `T` trust — so e.g.
/// `AAAXX1234C` (4th char `X`) passed the old 5-letters-then-4-digits regex
/// but was never an issuable PAN. The 10th character is itself a checksum
/// digit, but its algorithm is an internal CBDT/NSDL one, never published,
/// so there's no public formula to check it against — this is as far as
/// client-side PAN validation can correctly go.
final _panPattern = RegExp(r'^[A-Z]{3}[PCHABGJLFT][A-Z][0-9]{4}[A-Z]$');

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
    // `DD/MM/YYYY`, a real calendar date — the API takes `YYYY-MM-DD` and a
    // two-digit year is ambiguous, so it is not accepted.
    final iso = KycDetails(dateOfBirth: value, panNumber: '').isoDateOfBirth;
    if (iso == null) return 'Use DD/MM/YYYY.';
    // "A real past date, 1900-01-01 or later" (the API's rule).
    if (iso.compareTo('1900-01-01') < 0 ||
        !DateTime.parse(iso).isBefore(DateTime.now())) {
      return 'Enter your real date of birth.';
    }
    return null;
  }

  String? _validatePan(String value) {
    if (value.trim().isEmpty) return 'PAN is required.';
    if (!_panPattern.hasMatch(value.trim().toUpperCase())) {
      return 'Enter a valid PAN, e.g. AAAPL1234C.';
    }
    return null;
  }
}
