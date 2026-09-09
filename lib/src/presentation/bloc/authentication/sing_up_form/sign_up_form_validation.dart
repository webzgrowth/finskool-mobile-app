import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'sign_up_form_bloc.dart';

/// Field-level validation for [SignUpFormState], kept out of the bloc file
/// to stay under the project's per-file line limit.
extension SignUpFormValidation on SignUpFormState {
  SignUpFormState validated() {
    final fullNameError = Validators.required(firstName, 'Full name');
    final emailErr = Validators.email(email);
    final expectedDigits = CountryCodes.byDialCode(countryCode).digits;
    final phoneErr =
        Validators.phone(phonenumber, expectedDigits: expectedDigits);
    final passwordErr = Validators.password(password);
    final confirmErr = Validators.confirmPassword(password, confirmPassword);
    final hasError = [
      fullNameError,
      emailErr,
      phoneErr,
      passwordErr,
      confirmErr,
    ].any((e) => e != null);

    return copyWith(
      fullNameError: fullNameError,
      emailError: emailErr,
      phoneError: phoneErr,
      passwordError: passwordErr,
      confirmPasswordError: confirmErr,
      state: hasError ? RequestState.error : RequestState.loading,
    );
  }

  /// Folds a failed `POST /register` back onto the form.
  ///
  /// A 422 names the offending fields, so those go under the matching inputs
  /// rather than collapsing into one snackbar — `fullName` and `phone` are
  /// the API's names for this form's Full Name and Phone fields. Everything
  /// else (`ALREADY_REGISTERED`, `EMAIL_TAKEN`, a network error) has no field
  /// to attach to and surfaces as [message].
  SignUpFormState withFailure(Failure failure) {
    if (failure is ValidationFailure) {
      return copyWith(
        state: RequestState.error,
        message: failure.message,
        errorCode: failure.code,
        fullNameError: failure.forField('fullName'),
        emailError: failure.forField('email'),
        phoneError: failure.forField('phone'),
        passwordError: failure.forField('password'),
        confirmPasswordError: failure.forField('confirmPassword'),
      );
    }
    return copyWith(
      state: RequestState.error,
      message: failure.message,
      errorCode: failure.code,
    );
  }
}
