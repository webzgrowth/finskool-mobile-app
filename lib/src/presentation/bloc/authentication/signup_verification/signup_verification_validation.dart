import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/validators.dart';
import 'signup_verification_bloc.dart';

/// Field-level validation for [SignupVerificationState], kept out of the
/// bloc file to stay under the project's per-file line limit.
extension SignupVerificationValidation on SignupVerificationState {
  /// Local shape check only. On the API-backed path the bloc treats a clean
  /// result as "safe to send", not as success — the server decides that.
  SignupVerificationState validatedPhoneCode() {
    final error = Validators.otp(phoneCode);
    return copyWith(
      phoneCodeError: error,
      state: error == null ? RequestState.loaded : RequestState.error,
    );
  }

  SignupVerificationState validatedEmailCode() {
    final error = Validators.otp(emailCode);
    return copyWith(
      emailCodeError: error,
      state: error == null ? RequestState.loaded : RequestState.error,
    );
  }

  /// Folds a failed verify/resend back onto the screen.
  ///
  /// A wrong or expired code belongs under the OTP boxes, where the user is
  /// looking; everything else (cooldowns, network errors) has no field and
  /// surfaces as [message] via a snackbar.
  SignupVerificationState withFailure(Failure failure, {required bool onPhone}) {
    const inlineCodes = {'OTP_INVALID', 'OTP_EXPIRED', 'OTP_LOCKED'};
    final inline = inlineCodes.contains(failure.code) ? failure.message : null;

    return copyWith(
      state: RequestState.error,
      // Shown inline already — don't also fire a snackbar saying the same
      // thing.
      message: inline == null ? failure.message : '',
      errorCode: failure.code,
      phoneCodeError: onPhone ? inline : phoneCodeError,
      emailCodeError: onPhone ? emailCodeError : inline,
    );
  }
}
