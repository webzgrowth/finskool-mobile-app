import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/validators.dart';
import 'password_reset_bloc.dart';

/// Which input a failed reset call should blame.
enum ResetField { email, code, newPassword }

/// Field-level validation for [PasswordResetState], kept out of the bloc
/// file to stay under the project's per-file line limit.
extension PasswordResetValidation on PasswordResetState {
  PasswordResetState validatedEmail() {
    final error = Validators.email(email);
    return copyWith(
      emailError: error,
      state: error == null ? RequestState.loaded : RequestState.error,
    );
  }

  PasswordResetState validatedCode() {
    final error = Validators.otp(code);
    return copyWith(
      codeError: error,
      state: error == null ? RequestState.loaded : RequestState.error,
    );
  }

  PasswordResetState validatedNewPassword() {
    final passwordErr = Validators.strongPassword(newPassword);
    final confirmErr =
        Validators.confirmPassword(newPassword, confirmPassword);
    final hasError = passwordErr != null || confirmErr != null;
    return copyWith(
      newPasswordError: passwordErr,
      confirmPasswordError: confirmErr,
      state: hasError ? RequestState.error : RequestState.loaded,
    );
  }

  /// Folds a failed reset call back onto whichever screen made it.
  ///
  /// A bad code belongs under the OTP boxes; a 422 names its own fields.
  /// Anything else surfaces as [message] via a snackbar. [step] is left
  /// untouched so a failure never advances the flow.
  PasswordResetState withFailure(Failure failure, {required ResetField field}) {
    String? inline;
    if (failure is ValidationFailure) {
      inline = failure.forField(switch (field) {
        ResetField.email => 'email',
        ResetField.code => 'otp',
        ResetField.newPassword => 'newPassword',
      });
    } else if (field == ResetField.code &&
        const {'OTP_INVALID', 'OTP_EXPIRED', 'OTP_LOCKED'}
            .contains(failure.code)) {
      inline = failure.message;
    }

    return copyWith(
      state: RequestState.error,
      // Shown inline already — don't repeat it in a snackbar.
      message: inline == null ? failure.message : '',
      errorCode: failure.code,
      emailError: field == ResetField.email ? inline : emailError,
      codeError: field == ResetField.code ? inline : codeError,
      newPasswordError:
          field == ResetField.newPassword ? inline : newPasswordError,
    );
  }
}
