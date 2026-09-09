import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';

/// Reads the locally stored session on launch. Offline and synchronous — it
/// reports that we hold a credential, not that the server still honours it.
@lazySingleton
class GetAuthStatus {
  GetAuthStatus(this._repository);

  final AuthRepository _repository;

  bool get hasSession => _repository.hasSession;

  UserModel? get cachedUser => _repository.cachedUser;
}
