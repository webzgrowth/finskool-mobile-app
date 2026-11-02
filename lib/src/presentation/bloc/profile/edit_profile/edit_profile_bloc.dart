import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/usecases/auth/update_avatar.dart';
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
  EditProfileBloc(this._updateProfile, this._updateAvatar)
    : super(EditProfileState.initial()) {
    on<EditProfileEvent>((event, emit) async {
      await event.map(
        prefill: (value) async => emit(EditProfileState.fromUser(value.user)),
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
        discardChanges: (_) async =>
            emit(EditProfileState.fromUser(state.user)),
        submit: (_) async => _submit(emit),
        avatarPicked: (value) async => _setAvatar(value.path, emit),
      );
    });
  }

  final UpdateProfile _updateProfile;
  final UpdateAvatar _updateAvatar;

  /// Photo changes are applied at once and leave the text fields alone —
  /// including any the member is mid-way through editing.
  Future<void> _setAvatar(String path, Emitter<EditProfileState> emit) async {
    if (state.avatarBusy) return;
    emit(state.copyWith(avatarBusy: true));
    final result = await _updateAvatar.execute(path);
    result.fold(
      (failure) => emit(
        state.copyWith(
          avatarBusy: false,
          state: RequestState.error,
          message: failure.message,
        ),
      ),
      (updated) => emit(
        state.copyWith(
          avatarBusy: false,
          user: updated,
          state: RequestState.loaded,
          message: 'Photo updated.',
        ),
      ),
    );
  }

  Future<void> _submit(Emitter<EditProfileState> emit) async {
    // Validate on submit, not per keystroke.
    final nameError = Validators.required(state.name, 'Full name');
    final emailError = Validators.email(state.email);
    final phoneError = Validators.phone(
      state.phone,
      expectedDigits: state.country.digits,
    );

    if (nameError != null || emailError != null || phoneError != null) {
      emit(
        state.copyWith(
          state: RequestState.error,
          message: '',
          nameError: nameError,
          emailError: emailError,
          phoneError: phoneError,
        ),
      );
      return;
    }

    emit(state.copyWith(state: RequestState.loading, message: ''));

    final result = await _updateProfile.execute(
      name: state.name.trim(),
      email: state.email.trim(),
      phone: '${state.country.dialCode}${state.phone.trim()}',
    );

    result.fold(
      (failure) => emit(
        state.copyWith(state: RequestState.error, message: failure.message),
      ),
      // Re-anchor on the saved user, or `isDirty` would keep comparing
      // against the pre-save values and report unsaved changes forever.
      (updated) => emit(
        state.copyWith(
          state: RequestState.loaded,
          message: 'Profile updated.',
          isEditing: false,
          user: updated,
        ),
      ),
    );
  }
}
