import 'dart:convert';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:path_provider/path_provider.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/exception.dart';
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
    return _withLocalAvatar(user);
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
      return _withLocalAvatar(
        UserModel.fromJson(jsonDecode(raw) as Map<String, dynamic>),
      );
    } catch (e) {
      // A shape change between app versions shouldn't wedge the splash
      // screen — treat an unreadable cache as "no cached user".
      logger.warning('Discarding unreadable cached user: $e');
      return null;
    }
  }

  /// Re-attaches the photo picked on this device. It lives under its own
  /// prefs key rather than in the cached-user JSON because `refreshSession`
  /// replaces that JSON with the server's user — which has no idea about it —
  /// on every refresh. A file the OS has since removed is dropped here, so
  /// callers never hold a path that can't be read.
  UserModel _withLocalAvatar(UserModel user) {
    final path = SharedPreferenceHelper().getdata(
      StorageKeys.avatarLocalPath(user.id),
    );
    if (path == null || path.isEmpty || !File(path).existsSync()) return user;
    return user.copyWith(avatarLocalPath: path);
  }

  @override
  Future<Either<Failure, UserModel>> updateAvatar(String? sourcePath) =>
      handleErrors(() async {
        final current = cachedUser;
        if (current == null) {
          throw CacheException('No signed-in user to update.');
        }
        final prefs = SharedPreferenceHelper();
        final key = StorageKeys.avatarLocalPath(current.id);
        final previous = prefs.getdata(key);

        String? stored;
        if (sourcePath != null) {
          // image_picker's file is a cache copy the OS may purge; keep our
          // own. A fresh name each time, so `FileImage` can't serve the old
          // picture from its cache under an unchanged path.
          final docs = await getApplicationDocumentsDirectory();
          final dir = await Directory('${docs.path}/avatars').create(
            recursive: true,
          );
          stored =
              '${dir.path}/${current.id}_${DateTime.now().millisecondsSinceEpoch}.jpg';
          await File(sourcePath).copy(stored);
          await prefs.storedata(key, stored);
        } else {
          await prefs.remove(key);
        }
        if (previous != null && previous != stored) {
          try {
            await File(previous).delete();
          } catch (_) {} // already gone is fine
        }
        return stored == null
            ? current.copyWith(clearAvatarLocalPath: true)
            : current.copyWith(avatarLocalPath: stored);
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
    // The photo is personal data on a possibly shared phone: drop it with the
    // session rather than showing it to whoever signs in next.
    final userId = cachedUser?.id;
    final photo = userId == null
        ? null
        : prefs.getdata(StorageKeys.avatarLocalPath(userId));
    if (userId != null) await prefs.remove(StorageKeys.avatarLocalPath(userId));
    if (photo != null) {
      try {
        await File(photo).delete();
      } catch (_) {}
    }
    await prefs.remove(StorageKeys.cachedUser);
    await prefs.remove(StorageKeys.selectedCommunityId);
  }
}
