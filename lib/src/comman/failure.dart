import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  const Failure(this.message, {this.code});

  final String message;

  /// The API's machine-readable error code (`OTP_INVALID`, `EMAIL_TAKEN`,
  /// `NOT_REGISTERED`, …) when the backend supplied one. Branch on this,
  /// not on [message], which is prose meant for the user.
  final String? code;

  @override
  List<Object?> get props => [message, code];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message, {super.code});
}

class ConnectionFailure extends Failure {
  const ConnectionFailure(super.message, {super.code});
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

/// A `422` from the backend, carrying per-field messages
/// (`{"email": ["Invalid email address"]}`) so a bloc can drop them straight
/// onto its own `emailError` / `phoneError` / `passwordError` slots instead
/// of showing one generic snackbar.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {required this.errors, super.code});

  final Map<String, List<String>> errors;

  /// First message for [field], or null when the server didn't flag it.
  String? forField(String field) {
    final messages = errors[field];
    if (messages == null || messages.isEmpty) return null;
    return messages.first;
  }

  @override
  List<Object?> get props => [message, code, errors];
}
