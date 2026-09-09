import 'dart:io' show Platform;

/// `POST /auth/mobile/login`'s request body.
///
/// `deviceId`/`deviceType` are optional and best-effort — the backend keys
/// its one-session-per-account rule on the user, not the device, so these are
/// display/support metadata only and are omitted when unknown.
class LoginRequestModel {
  const LoginRequestModel({
    required this.email,
    required this.password,
    this.deviceId,
    this.deviceType,
  });

  final String email;
  final String password;
  final String? deviceId;
  final String? deviceType;

  static String? get currentDeviceType {
    if (Platform.isIOS) return 'ios';
    if (Platform.isAndroid) return 'android';
    return null;
  }

  Map<String, dynamic> toJson() => {
        'email': email.trim(),
        'password': password,
        if (deviceId != null) 'deviceId': deviceId,
        if (deviceType != null) 'deviceType': deviceType,
      };
}
