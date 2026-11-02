import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/avatar_upload_link.dart';
import 'package:finskool/src/domain/model/auth/login_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_result_model.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';

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
    debugPrint(
      '=======login request: ${request.toJson()}',
    ); // TODO: remove this debug print
    final data = await _client.post(Api.login, body: request.toJson());

    debugPrint('=======login response: $data'); // TODO: remove this debug print
    return AuthSessionModel.fromJson(_require(data, Api.login));
  }

  /// Safe to call with no session, an expired one, or one already ended
  /// elsewhere — the API always answers 200.
  Future<void> logout() => _client.post(Api.logout);

  /// The authenticated user, from the server rather than the prefs cache.
  ///
  /// This is the only call that can tell us the session is still good — a
  /// dead cookie comes back 401, which `SessionInterceptor` turns into a
  /// cleared credential and a `SessionExpiry` notification.
  Future<UserModel> getMe() async {
    final data = await _client.get(Api.me);
    final payload = _require(data, Api.me);
    final user = payload['user'];
    if (user is! Map<String, dynamic>) {
      throw ApiException('The server returned no profile for ${Api.me}.');
    }
    return UserModel.fromJson(user);
  }

  /// Step 1 of a profile-picture change: a signed link to PUT the image to
  /// (valid ~5 minutes) and the public URL it will have afterwards.
  Future<AvatarUploadLink> avatarUploadLink(String filename) async {
    final data = await _client.get(
      Api.avatarUploadUrl,
      query: {'filename': filename},
    );
    final payload = _require(data, Api.avatarUploadUrl);
    final link = AvatarUploadLink.fromJson(payload);
    if (link.uploadUrl.isEmpty || link.publicUrl.isEmpty) {
      throw ApiException('The server returned no upload link.');
    }
    return link;
  }

  /// Step 3: save [publicUrl] on the account; the server returns the user with
  /// the new `avatarUrl` (and deletes the old picture). Only call this after
  /// the upload succeeded — saving a URL for a file that never uploaded leaves
  /// a broken image on the profile.
  Future<UserModel> saveAvatar(String publicUrl) async {
    final data = await _client.patch(
      Api.avatar,
      body: {'avatarUrl': publicUrl},
    );
    final payload = _require(data, Api.avatar);
    final user = payload['user'];
    if (user is! Map<String, dynamic>) {
      throw ApiException('The server returned no profile for ${Api.avatar}.');
    }
    return UserModel.fromJson(user);
  }

  /// Community **post** alerts only (new posts and recommendations). When off
  /// the server skips the member entirely for those — no inbox row either —
  /// so they won't appear later if it is switched back on.
  Future<void> setPostNotificationsEnabled(bool enabled) => _client.patch(
    Api.postNotificationsSetting,
    body: {'postNotificationsEnabled': enabled},
  );

  Future<void> selectCommunity(String communityId) =>
      _client.post(Api.selectCommunity, body: {'communityId': communityId});

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
