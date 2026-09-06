import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/validators.dart';
import 'signup_verification_bloc.dart';

/// Field-level validation for [SignupVerificationState], kept out of the
/// bloc file to stay under the project's per-file line limit.
extension SignupVerificationValidation on SignupVerificationState {
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
}
