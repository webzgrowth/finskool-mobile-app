import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';
import 'package:finskool/src/domain/usecases/kyc/get_kyc_status.dart';

part 'kyc_event.dart';
part 'kyc_state.dart';
part 'kyc_bloc.freezed.dart';

/// What the server knows about the member's DOB + PAN — the flag and the
/// masked values the Profile shows. **The only copy on the device, and held in
/// memory**: nothing is written to storage.
///
/// Loaded when the session is confirmed (a login or a launch) and again after
/// the details are submitted. App-lifetime, so it is reset at sign-out like
/// every bloc holding account data.
@singleton
class KycBloc extends Bloc<KycEvent, KycState> {
  KycBloc(this._getStatus) : super(KycState.initial()) {
    on<KycEvent>((event, emit) async {
      await event.map(load: (_) => _load(emit), reset: (_) => _reset(emit));
    });
  }

  final GetKycStatus _getStatus;

  /// Bumped by `reset`, so an answer for a signed-out session is dropped.
  int _epoch = 0;

  Future<void> _load(Emitter<KycState> emit) async {
    final epoch = _epoch;
    // Quiet when something is already shown: a background re-check mustn't
    // blank the Profile's values.
    if (state.status == null) {
      emit(state.copyWith(state: RequestState.loading, message: ''));
    }
    final result = await _getStatus.execute();
    if (epoch != _epoch) return;
    emit(
      result.fold(
        (failure) => state.copyWith(
          state: state.status == null
              ? RequestState.error
              : RequestState.loaded,
          message: failure.message,
        ),
        (status) => state.copyWith(
          state: RequestState.loaded,
          status: status,
          message: '',
        ),
      ),
    );
  }

  Future<void> _reset(Emitter<KycState> emit) async {
    _epoch++;
    emit(KycState.initial());
  }
}
