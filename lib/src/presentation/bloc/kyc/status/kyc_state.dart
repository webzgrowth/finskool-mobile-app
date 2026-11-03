part of 'kyc_bloc.dart';

@freezed
sealed class KycState with _$KycState {
  const factory KycState({
    required RequestState state,
    required String message,

    /// Null until the server has answered.
    KycStatus? status,
  }) = _KycState;

  factory KycState.initial() =>
      const KycState(state: RequestState.empty, message: '');
}
