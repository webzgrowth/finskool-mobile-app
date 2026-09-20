import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/usecases/community/submit_compliance.dart';
import 'compliance_validation.dart';

part 'compliance_event.dart';
part 'compliance_state.dart';
part 'compliance_bloc.freezed.dart';

/// The one-time SEBI form: date of birth + PAN + a confirmation tick.
///
/// Same shape as the auth form blocs — validate on submit, per-field
/// `String?` errors cleared by their own `*Changed` event.
@singleton
class ComplianceBloc extends Bloc<ComplianceEvent, ComplianceState> {
  ComplianceBloc(this._submitCompliance)
      : super(ComplianceState.initial()) {
    on<ComplianceEvent>((event, emit) async {
      await event.map(
        initial: (_) async => emit(ComplianceState.initial()),
        dateOfBirthChanged: (value) async => emit(state.copyWith(
            dateOfBirth: value.value, dateOfBirthError: null)),
        panChanged: (value) async => emit(state.copyWith(
            // The card prints PAN in capitals and the hint says so.
            pan: value.value.toUpperCase(),
            panError: null)),
        confirmationToggled: (_) async =>
            emit(state.copyWith(confirmed: !state.confirmed)),
        submit: (_) => _submit(emit),
      );
    });
  }

  final SubmitCompliance _submitCompliance;

  Future<void> _submit(Emitter<ComplianceState> emit) async {
    final validated = state.validated();
    emit(validated);
    if (!validated.state.isLoading) return;

    final result = await _submitCompliance.execute(
      ComplianceDetailsModel(
        dateOfBirth: state.dateOfBirth,
        panNumber: state.pan,
      ),
    );
    emit(result.fold(
      (failure) => state.copyWith(
          state: RequestState.error, message: failure.message),
      (_) => state.copyWith(state: RequestState.loaded, message: ''),
    ));
  }
}
