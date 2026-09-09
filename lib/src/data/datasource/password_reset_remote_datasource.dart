import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/auth/reset_cypher_model.dart';

/// The three-step forgot-password flow. None of it creates a session — the
/// user finishes with a normal login.
@lazySingleton
class PasswordResetRemoteDatasource {
  PasswordResetRemoteDatasource(this._client);

  final ApiClient _client;

  /// Always answers 200 whether or not the email matches an account — a
  /// deliberate anti-enumeration measure. Success here is *not* proof that a
  /// mail was sent, so don't word the UI as though it were.
  Future<void> sendResetCode(String email) =>
      _client.post(Api.forgotPassword, body: {'email': email.trim()});

  Future<ResetCypherModel> verifyResetOtp({
    required String email,
    required String otp,
  }) async {
    final data = await _client.post(
      Api.forgotPasswordOtp,
      body: {'email': email.trim(), 'otp': otp},
    );
    if (data == null) {
      throw ApiException('The server returned no reset token.');
    }
    return ResetCypherModel.fromJson(data);
  }

  /// The cypher is consumed by this call **even when it fails**, so a retry
  /// needs a fresh `verifyResetOtp` round.
  Future<void> resetPassword({
    required String cypher,
    required String newPassword,
    required String confirmNewPassword,
  }) =>
      _client.post(Api.forgotPasswordReset, body: {
        'cypher': cypher,
        'newPassword': newPassword,
        'confirmNewPassword': confirmNewPassword,
      });
}
