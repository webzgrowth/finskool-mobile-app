import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/api/api_client.dart';
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
    RegisterRequestModel request,
  ) => handleErrors(() => _remote.register(request));

  @override
  Future<Either<Failure, Unit>> verifyOtp({
    required String userId,
    required String otp,
  }) => handleErrors(() async {
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
  }) => handleErrors(() async {
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
        await SharedPreferenceHelper().storedata(
          StorageKeys.selectedCommunityId,
          communityId,
        );
        return unit;
      });

  @override
  Future<Either<Failure, UserModel>> refreshSession() => handleErrors(() async {
    final user = await _remote.getMe();
    await _cacheUser(user);
    return user;
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

  /// Largest picture the app will upload (the guide's limit; the server does
  /// not check yet, so the app must).
  static const int _maxAvatarBytes = 5 * 1024 * 1024;

  static const _avatarTypes = {
    'jpg': 'image/jpeg',
    'jpeg': 'image/jpeg',
    'png': 'image/png',
    'webp': 'image/webp',
  };

  /// The three-call profile-picture change:
  /// 1. `GET /auth/me/avatar/upload-url` → a signed link and the public URL;
  /// 2. `PUT` the raw bytes to that link — on a **separate** client with no
  ///    cookie, so the app's credential never reaches the storage host;
  /// 3. `PATCH /auth/me/avatar` with the public URL.
  ///
  /// **Step 3 runs only if step 2 succeeded**: a saved URL for a file that
  /// never uploaded is a broken image on the profile. The link lives five
  /// minutes, so it is requested immediately before use; a failure anywhere
  /// is simply tried again from step 1.
  @override
  Future<Either<Failure, UserModel>> updateAvatar(String sourcePath) =>
      handleErrors(() async {
        final current = cachedUser;
        if (current == null) {
          throw CacheException('No signed-in user to update.');
        }
        final ext = sourcePath.contains('.')
            ? sourcePath.split('.').last.toLowerCase()
            : '';
        final contentType = _avatarTypes[ext];
        final file = File(sourcePath);
        if (contentType == null || await file.length() > _maxAvatarBytes) {
          throw ApiException('Choose a JPG, PNG or WebP picture under 5 MB.');
        }
        final bytes = await file.readAsBytes();

        // The extension is part of the stored name, so it must be the real one.
        final link = await _remote.avatarUploadLink('me.$ext');
        await ApiClient.putBytes(
          link.uploadUrl,
          bytes,
          contentType: contentType,
        );
        final saved = await _remote.saveAvatar(link.publicUrl);

        // Take only the picture from the response: it must not overwrite
        // anything else we hold (the local-only name/email/phone edits).
        final updated = current.copyWith(avatarUrl: saved.avatarUrl);
        await _cacheUser(updated);
        return updated;
      });

  Future<void> _cacheUser(UserModel user) => SharedPreferenceHelper().storedata(
    StorageKeys.cachedUser,
    jsonEncode(user.toJson()),
  );

  @override
  Future<Either<Failure, UserModel>> setPostNotificationsEnabled(
    bool enabled,
  ) => handleErrors(() async {
    final current = cachedUser;
    if (current == null) {
      throw CacheException('No signed-in user to update.');
    }
    // Server first: it is the source of truth, and caching a value the server
    // rejected would show a switch that doesn't match what actually happens.
    await _remote.setPostNotificationsEnabled(enabled);
    final updated = current.copyWith(postNotificationsEnabled: enabled);
    await _cacheUser(updated);
    return updated;
  });

  @override
  Future<Either<Failure, UserModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
  }) => handleErrors(() async {
    final current = cachedUser;
    if (current == null) {
      throw CacheException('No signed-in user to update.');
    }
    final updated = current.copyWith(name: name, email: email, phone: phone);
    await _cacheUser(updated);
    return updated;
  });

  /// One community means it's already selected, per the API doc. More than
  /// one needs a user choice, which has no UI yet — until then the backend
  /// falls back to "all my communities merged", which is a fine default.
  Future<void> _autoSelectCommunity(AuthSessionModel session) async {
    final community = session.autoSelectedCommunity;
    if (community == null) return;
    try {
      await _remote.selectCommunity(community.id);
      await SharedPreferenceHelper().storedata(
        StorageKeys.selectedCommunityId,
        community.id,
      );
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
    await prefs.remove(StorageKeys.lastBilling);
  }
}
