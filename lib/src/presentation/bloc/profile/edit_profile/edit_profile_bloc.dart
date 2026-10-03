import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/usecases/auth/update_profile.dart';

part 'edit_profile_event.dart';
part 'edit_profile_state.dart';
part 'edit_profile_bloc.freezed.dart';

/// Backs the Edit Profile screen (Figma `Frame 2121453561`).
///
/// Saving is **local-only** — `docs/auth_api_doc.md` documents no
/// profile-update endpoint, so [UpdateProfile] rewrites the cached
/// `UserModel` and nothing leaves the device. The screen refreshes the
/// Profile tab's header afterwards by dispatching `authCheckRequest()` on
/// `AuthenticatorWatcherBloc` in the widget layer — the two blocs never
/// talk to each other directly.
@singleton
class EditProfileBloc extends Bloc<EditProfileEvent, EditProfileState> {
  EditProfileBloc(this._updateProfile) : super(EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) async {
      await event.map(
        prefill: (value) async => emit(_seed(value.user)),
        editToggled: (_) async =>
            emit(state.copyWith(isEditing: !state.isEditing)),
        // Each *Changed clears only its own error, so a field the user is
        // currently fixing stops shouting while the others keep their
        // messages — the convention the auth forms use.
        nameChanged: (value) async =>
            emit(state.copyWith(name: value.name, nameError: null)),
        emailChanged: (value) async =>
            emit(state.copyWith(email: value.email, emailError: null)),
        phoneChanged: (value) async =>
            emit(state.copyWith(phone: value.phone, phoneError: null)),
        countryChanged: (value) async =>
            emit(state.copyWith(country: value.country, phoneError: null)),
        discardChanges: (_) async => emit(_seed(state.user)),
        submit: (_) async => _submit(emit),
      );
    });
  }

  final UpdateProfile _updateProfile;

  EditProfileState _seed(UserModel? user) {
    final initial = EditProfileState.initial();
    if (user == null) return initial;
    final country = CountryCodes.all.firstWhere(
      (c) => user.phone.startsWith(c.dialCode),
      orElse: () => initial.country,
    );
    return initial.copyWith(
      user: user,
      name: user.name,
      email: user.email,
      // The cached phone carries its dial code; the field shows only the
      // national part, since the chip beside it renders the code.
      phone: user.phone.startsWith(country.dialCode)
          ? user.phone.substring(country.dialCode.length).trim()
          : user.phone,
      country: country,
    );
  }

  Future<void> _submit(Emitter<EditProfileState> emit) async {
    // Validate on submit, not per keystroke.
    final nameError = Validators.required(state.name, 'Full name');
    final emailError = Validators.email(state.email);
    final phoneError =
        Validators.phone(state.phone, expectedDigits: state.country.digits);

    if (nameError != null || emailError != null || phoneError != null) {
      emit(state.copyWith(
        state: RequestState.error,
        message: '',
        nameError: nameError,
        emailError: emailError,
        phoneError: phoneError,
      ));
      return;
    }

    emit(state.copyWith(state: RequestState.loading, message: ''));

    final result = await _updateProfile.execute(
      name: state.name.trim(),
      email: state.email.trim(),
      phone: '${state.country.dialCode}${state.phone.trim()}',
    );

    result.fold(
      (failure) => emit(state.copyWith(
        state: RequestState.error,
        message: failure.message,
      )),
      // Re-anchor on the saved user, or `isDirty` would keep comparing
      // against the pre-save values and report unsaved changes forever.
      (updated) => emit(state.copyWith(
        state: RequestState.loaded,
        message: 'Profile updated.',
        isEditing: false,
        user: updated,
      )),
    );
  }
}
