part of 'edit_profile_bloc.dart';

@freezed
sealed class EditProfileState with _$EditProfileState {
  const factory EditProfileState({
    required RequestState state,
    required String message,
    required String name,
    required String email,
    required String phone,

    /// Drives the dial-code chip and, via [Country.digits], what
    /// `Validators.phone` treats as a valid length.
    required Country country,

    /// Fields are read-only until the header's pencil turns this on.
    required bool isEditing,
    String? nameError,
    String? emailError,
    String? phoneError,
  }) = _EditProfileState;

  factory EditProfileState.initial() => EditProfileState(
        state: RequestState.empty,
        message: '',
        name: '',
        email: '',
        phone: '',
        country: CountryCodes.all.first,
        isEditing: false,
      );

  const EditProfileState._();

  /// True when every field passes — computed rather than stored so it can't
  /// go stale against the text.
  bool get isValid =>
      Validators.required(name, 'Full name') == null &&
      Validators.email(email) == null &&
      Validators.phone(phone, expectedDigits: country.digits) == null;
}
