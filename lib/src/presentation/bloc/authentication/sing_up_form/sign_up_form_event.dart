part of 'sign_up_form_bloc.dart';

@freezed
class SignUpFormEvent with _$SignUpFormEvent {
  const factory SignUpFormEvent.initial() = _initials;
  const factory SignUpFormEvent.registerUser(bool isSocialLogin) = _Register;

  // TextField events
  const factory SignUpFormEvent.emailOnChanged(String email) = _EmailOnChanged;
  const factory SignUpFormEvent.firstNameChanged(String firstName) =
      _FirstNameChanged;
  const factory SignUpFormEvent.lastNameChanged(String lastName) =
      _LastNameChanged;
  const factory SignUpFormEvent.countryCodeChanged(String countryCode) =
      _CountryCodeChanged;
  const factory SignUpFormEvent.phonenumberChanged(String phonenumber) =
      _PhonenumberChanged;

  // isfrom social
  const factory SignUpFormEvent.isFromSocial(bool isFromSocial) = _IsFromSocial;
}
