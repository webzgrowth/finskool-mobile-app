/// `POST /auth/mobile/register`'s request body.
///
/// The sign-up form tracks first/last name and dial code separately, so the
/// [fromForm] factory does the joining in one documented place rather than
/// leaving `'$firstName $lastName'` string-building inside a bloc.
class RegisterRequestModel {
  const RegisterRequestModel({
    required this.fullName,
    required this.phone,
    required this.email,
    required this.password,
    required this.confirmPassword,
  });

  /// Builds the payload from the sign-up form's separate fields. [phone] is
  /// sent E.164-style (`+919876543210`); the backend parses with
  /// libphonenumber, so the dial code is kept rather than stripped.
  factory RegisterRequestModel.fromForm({
    required String firstName,
    required String lastName,
    required String countryCode,
    required String phonenumber,
    required String email,
    required String password,
    required String confirmPassword,
  }) =>
      RegisterRequestModel(
        fullName: '$firstName $lastName'.trim(),
        phone: '$countryCode$phonenumber'.replaceAll(' ', ''),
        email: email.trim(),
        password: password,
        confirmPassword: confirmPassword,
      );

  final String fullName;
  final String phone;
  final String email;
  final String password;
  final String confirmPassword;

  Map<String, dynamic> toJson() => {
        'fullName': fullName,
        'phone': phone,
        'email': email,
        'password': password,
        'confirmPassword': confirmPassword,
      };
}
