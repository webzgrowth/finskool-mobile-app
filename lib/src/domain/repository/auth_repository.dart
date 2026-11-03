import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/register_request_model.dart';
import 'package:finskool/src/domain/model/auth/register_result_model.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';

/// The contract the presentation layer depends on. Implemented by
/// `data/repository/auth_repository_impl.dart`.
abstract class AuthRepository {
  Future<Either<Failure, RegisterResultModel>> register(
    RegisterRequestModel request,
  );

  Future<Either<Failure, Unit>> verifyOtp({
    required String userId,
    required String otp,
  });

  Future<Either<Failure, Unit>> resendOtp(String userId);

  Future<Either<Failure, AuthSessionModel>> login({
    required String email,
    required String password,
  });

  Future<Either<Failure, Unit>> logout();

  Future<Either<Failure, Unit>> selectCommunity(String communityId);

  /// True when a `mobile_session_id` cookie is on disk. Synchronous and
  /// offline — it says we *have* a credential, not that the server still
  /// accepts it (another device's login may have invalidated it).
  /// Re-reads the signed-in user from `GET /auth/mobile/me` and refreshes
  /// the local cache, or fails if the session is no longer valid.
  ///
  /// [cachedUser] is a *copy*, written at login; this is the source of
  /// truth, and the only way to find out a session has died without waiting
  /// for some other request to fail.
  Future<Either<Failure, UserModel>> refreshSession();

  bool get hasSession;

  /// The last logged-in user, restored from cache. Null when signed out or
  /// when the cached blob can't be parsed.
  UserModel? get cachedUser;

  /// Sets the **post-alerts** preference (`PATCH /auth/me/notifications`) and,
  /// once the server accepts it, re-persists it on the cached user. Not the
  /// master push switch — that is `PushSettingsBloc`'s.
  Future<Either<Failure, UserModel>> setPostNotificationsEnabled(bool enabled);

  /// Writes the Edit Profile form back onto the cached [UserModel]. Also
  /// local-only: `docs/auth_api_doc.md` documents no profile-update
  /// endpoint, so this never leaves the device — same category as the
  /// notification preference above.
  Future<Either<Failure, UserModel>> updateProfile({
    required String name,
    required String email,
    required String phone,
  });

  /// Uploads [sourcePath] as the profile picture and saves it on the account
  /// (`upload-url` → `PUT` to storage → `PATCH /auth/me/avatar`). Rejects
  /// anything but JPG/PNG/WebP under 5 MB before any request. Returns the user
  /// carrying the new `avatarUrl`. There is **no call to remove** a picture —
  /// it can only be replaced.
  Future<Either<Failure, UserModel>> updateAvatar(String sourcePath);
}
