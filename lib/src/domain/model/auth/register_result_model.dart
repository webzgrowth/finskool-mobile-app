/// `POST /auth/mobile/register`'s `data` payload.
///
/// [userId] is the important field — it's the handle for `verify-otp` and
/// `resend-otp`, and it must be carried from the sign-up form through to the
/// OTP screen. No session cookie is set at this point; the account exists but
/// is unverified.
class RegisterResultModel {
  const RegisterResultModel({
    required this.userId,
    required this.phone,
    required this.email,
    required this.otpExpiresInSeconds,
  });

  final String userId;
  final String phone;
  final String email;
  final int otpExpiresInSeconds;

  factory RegisterResultModel.fromJson(Map<String, dynamic> json) =>
      RegisterResultModel(
        userId: json['userId'] as String,
        phone: json['phone'] as String? ?? '',
        email: json['email'] as String? ?? '',
        otpExpiresInSeconds: json['otpExpiresInSeconds'] as int? ?? 600,
      );

  Map<String, dynamic> toJson() => {
        'userId': userId,
        'phone': phone,
        'email': email,
        'otpExpiresInSeconds': otpExpiresInSeconds,
      };
}
