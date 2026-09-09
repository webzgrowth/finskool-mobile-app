import 'dart:convert';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/datasource/auth_remote_datasource.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/login_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_result_model.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

@LazySingleton(as: AuthRepository)
class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl(this._remote);

  final AuthRemoteDatasource _remote;

  @override
  Future<Either<Failure, RegisterResultModel>> register(
          RegisterRequestModel request) =>
      handleErrors(() => _remote.register(request));

  @override
  Future<Either<Failure, Unit>> verifyOtp({
    required String userId,
    required String otp,
  }) =>
      handleErrors(() async {
        await _remote.verifyOtp(userId: userId, otp: otp);
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> resendOtp(String userId) =>
      handleErrors(() async {
        await _remote.resendOtp(userId);
        return unit;
      });

  @override
  Future<Either<Failure, AuthSessionModel>> login({
    required String email,
    required String password,
  }) =>
      handleErrors(() async {
        final session = await _remote.login(
          LoginRequestModel(
            email: email,
            password: password,
            deviceType: LoginRequestModel.currentDeviceType,
          ),
        );
        // The session cookie itself was already captured by
        // SessionInterceptor; cache the user so splash can restore offline.
        await _cacheUser(session.user);
        await _autoSelectCommunity(session);
        return session;
      });

  @override
  Future<Either<Failure, Unit>> logout() => handleErrors(() async {
        await _remote.logout();
        await _clearSession();
        return unit;
      });

  @override
  Future<Either<Failure, Unit>> selectCommunity(String communityId) =>
      handleErrors(() async {
        await _remote.selectCommunity(communityId);
        await SharedPreferenceHelper()
            .storedata(StorageKeys.selectedCommunityId, communityId);
        return unit;
      });

  @override
  bool get hasSession {
    final cookie = SharedPreferenceHelper().getdata(StorageKeys.sessionCookie);
    return cookie != null && cookie.isNotEmpty;
  }

  @override
  UserModel? get cachedUser {
    final raw = SharedPreferenceHelper().getdata(StorageKeys.cachedUser);
    if (raw == null || raw.isEmpty) return null;
    try {
      return UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>);
    } catch (e) {
      // A shape change between app versions shouldn't wedge the splash
      // screen — treat an unreadable cache as "no cached user".
      logger.warning('Discarding unreadable cached user: $e');
      return null;
    }
  }

  Future<void> _cacheUser(UserModel user) => SharedPreferenceHelper()
      .storedata(StorageKeys.cachedUser, jsonEncode(user.toJson()));

  /// One community means it's already selected, per the API doc. More than
  /// one needs a user choice, which has no UI yet — until then the backend
  /// falls back to "all my communities merged", which is a fine default.
  Future<void> _autoSelectCommunity(AuthSessionModel session) async {
    final community = session.autoSelectedCommunity;
    if (community == null) return;
    try {
      await _remote.selectCommunity(community.id);
      await SharedPreferenceHelper()
          .storedata(StorageKeys.selectedCommunityId, community.id);
    } catch (e) {
      // Best-effort: a failed auto-select must not fail the login.
      logger.warning('Could not auto-select community ${community.id}: $e');
    }
  }

  Future<void> _clearSession() async {
    final prefs = SharedPreferenceHelper();
    await prefs.remove(StorageKeys.sessionCookie);
    await prefs.remove(StorageKeys.cachedUser);
    await prefs.remove(StorageKeys.selectedCommunityId);
  }
}
