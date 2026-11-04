import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/login_request_model.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';

/// `/auth/mobile/social/*`. Throws; the repository catches. A login that
/// finishes sets the `mobile_session_id` cookie, which `SessionInterceptor`
/// persists — nothing to read here.
@lazySingleton
class SocialAuthRemoteDatasource {
  SocialAuthRemoteDatasource(this._client);

  final ApiClient _client;

  static String? get _deviceType => LoginRequestModel.currentDeviceType;

  Future<SocialLoginResult> login(SocialCredential credential) async {
    final data = await _client.post(
      Api.socialLogin,
      body: {
        'provider': credential.provider.name,
        'idToken': credential.idToken,
        'nonce': credential.nonce,
        if (credential.fullName != null) 'fullName': credential.fullName,
        if (_deviceType != null) 'deviceType': _deviceType,
      },
    );
    return SocialLoginResult.fromJson(_require(data, Api.socialLogin));
  }

  Future<AuthSessionModel> link({
    required String linkToken,
    required String password,
  }) async {
    final data = await _client.post(
      Api.socialLink,
      body: {
        'linkToken': linkToken,
        'password': password,
        if (_deviceType != null) 'deviceType': _deviceType,
      },
    );
    return AuthSessionModel.fromJson(_require(data, Api.socialLink));
  }

  Future<SocialOtpChallenge> requestPhone({
    required String signupToken,
    required String phone,
    String? fullName,
  }) async {
    final data = await _client.post(
      Api.socialPhone,
      body: {
        'signupToken': signupToken,
        'phone': phone,
        if (fullName != null && fullName.isNotEmpty) 'fullName': fullName,
      },
    );
    return SocialOtpChallenge.fromJson(_require(data, Api.socialPhone));
  }

  Future<AuthSessionModel> verifyOtp({
    required String otpToken,
    required String otp,
  }) async {
    final data = await _client.post(
      Api.socialVerifyOtp,
      body: {
        'otpToken': otpToken,
        'otp': otp,
        if (_deviceType != null) 'deviceType': _deviceType,
      },
    );
    return AuthSessionModel.fromJson(_require(data, Api.socialVerifyOtp));
  }

  /// `POST /me/social/link` → the providers now linked. `409
  /// SOCIAL_ALREADY_LINKED` (that account belongs to another member) and `409
  /// SOCIAL_PROVIDER_ALREADY_LINKED` (a different one is already linked) come
  /// back as the server's own words.
  Future<List<String>> connect(SocialCredential credential) async {
    final data = await _client.post(
      Api.socialConnect,
      body: {
        'provider': credential.provider.name,
        'idToken': credential.idToken,
        'nonce': credential.nonce,
      },
    );
    final linked = _require(data, Api.socialConnect)['linkedProviders'];
    return [
      for (final p in (linked as List?) ?? const [])
        if (p is String) p,
    ];
  }

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
