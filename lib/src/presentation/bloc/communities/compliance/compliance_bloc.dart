import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/usecases/kyc/submit_kyc.dart';

import 'compliance_validation.dart';

part 'compliance_event.dart';
part 'compliance_state.dart';
part 'compliance_bloc.freezed.dart';

/// The one-time SEBI form: date of birth + PAN + a confirmation tick, shown
/// after the member's first paid community when the server says it doesn't
/// have them yet.
///
/// The typed values live only in this state and are **wiped as soon as they
/// are sent** — the PAN is never stored on the device.
///
/// Same shape as the auth form blocs — validate on submit, per-field
/// `String?` errors cleared by their own `*Changed` event.
@singleton
class ComplianceBloc extends Bloc<ComplianceEvent, ComplianceState> {
  ComplianceBloc(this._submitKyc) : super(ComplianceState.initial()) {
    on<ComplianceEvent>((event, emit) async {
      await event.map(
        initial: (_) async => emit(ComplianceState.initial()),
        // The one field checked as it is typed: a complete date (10 chars,
        // `DD/MM/YYYY`) is judged at once, so "31/02/2000" or a future date
        // is flagged without waiting for Submit. A partial date stays quiet.
        dateOfBirthChanged: (value) async => emit(
          state.copyWith(
            dateOfBirth: value.value,
            dateOfBirthError: value.value.length == 10
                ? validateDateOfBirth(value.value)
                : null,
          ),
        ),
        panChanged: (value) async => emit(
          state.copyWith(
            // The card prints PAN in capitals and the hint says so.
            pan: value.value.toUpperCase(),
            panError: null,
          ),
        ),
        confirmationToggled: (_) async =>
            emit(state.copyWith(confirmed: !state.confirmed)),
        submit: (_) => _submit(emit),
      );
    });
  }

  final SubmitKyc _submitKyc;

  Future<void> _submit(Emitter<ComplianceState> emit) async {
    final validated = state.validated();
    emit(validated);
    if (!validated.state.isLoading) return;

    final result = await _submitKyc.execute(
      KycDetails(dateOfBirth: state.dateOfBirth, panNumber: state.pan),
    );
    emit(result.fold((failure) => _failed(failure), (_) => _done()));
  }

  /// Saved — and the typed values go with it.
  ComplianceState _done() =>
      ComplianceState.initial().copyWith(state: RequestState.loaded);

  ComplianceState _failed(Failure failure) {
    // The server already has them (a retry after a lost response, or another
    // device): nothing to fix, so carry on as if this one had saved.
    if (failure.code == 'KYC_ALREADY_SUBMITTED') return _done();
    if (failure is ValidationFailure) {
      return state.copyWith(
        state: RequestState.error,
        message: failure.message,
        dateOfBirthError: failure.forField('dateOfBirth'),
        panError: failure.forField('panNumber'),
      );
    }
    return state.copyWith(state: RequestState.error, message: failure.message);
  }
}
