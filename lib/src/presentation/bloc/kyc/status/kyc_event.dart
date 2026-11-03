part of 'kyc_bloc.dart';

@freezed
class KycEvent with _$KycEvent {
  /// Re-reads `GET /auth/mobile/me/kyc`.
  const factory KycEvent.load() = _Load;

  /// Sign-out: forget the previous member's details.
  const factory KycEvent.reset() = _Reset;
}
