import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/validators.dart';
import 'password_reset_bloc.dart';

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
}
