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
      RegisterRequestModel request);

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
  bool get hasSession;

  /// The last logged-in user, restored from cache. Null when signed out or
  /// when the cached blob can't be parsed.
  UserModel? get cachedUser;
}
