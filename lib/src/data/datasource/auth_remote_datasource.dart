import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/login_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_result_model.dart';

/// Registration, login and session endpoints. One method per endpoint, each a
/// single call plus a `fromJson`.
///
/// These *throw* ([ApiException]); catching happens once, in the repository,
/// via `handleErrors`. There's no abstract datasource interface — the
/// swappable seam in this architecture is the repository contract in
/// `domain/repository/`.
@lazySingleton
class AuthRemoteDatasource {
  AuthRemoteDatasource(this._client);

  final ApiClient _client;

  Future<RegisterResultModel> register(RegisterRequestModel request) async {
    final data = await _client.post(Api.register, body: request.toJson());
    return RegisterResultModel.fromJson(_require(data, Api.register));
  }

  /// Verifies the signup OTP. Note this does **not** create a session — the
  /// caller has to log in separately afterwards.
  Future<void> verifyOtp({required String userId, required String otp}) =>
      _client.post(Api.verifyOtp, body: {'userId': userId, 'otp': otp});

  /// Rate-limited to one send per 60s; inside that window the API answers
  /// `429 OTP_COOLDOWN` with the remaining seconds in its message.
  Future<void> resendOtp(String userId) =>
      _client.post(Api.resendOtp, body: {'userId': userId});

  /// On success the `mobile_session_id` cookie arrives in the response
  /// headers and `SessionInterceptor` persists it — nothing to read here.
  Future<AuthSessionModel> login(LoginRequestModel request) async {
    final data = await _client.post(Api.login, body: request.toJson());
    return AuthSessionModel.fromJson(_require(data, Api.login));
  }

  /// Safe to call with no session, an expired one, or one already ended
  /// elsewhere — the API always answers 200.
  Future<void> logout() => _client.post(Api.logout);

  Future<void> selectCommunity(String communityId) =>
      _client.post(Api.selectCommunity, body: {'communityId': communityId});

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
