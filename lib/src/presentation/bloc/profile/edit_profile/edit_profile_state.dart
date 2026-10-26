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

    /// A photo change is in flight (copying the file) — the badge shows a
    /// spinner and ignores taps so two picks can't race.
    required bool avatarBusy,

    /// The prefill source, kept so "Discard Changes" can re-seed from it
    /// and [isDirty] has something to compare against.
    UserModel? user,
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
    avatarBusy: false,
  );

  /// The form as it should read for [user] — a **pure** function, public so
  /// the screen can fill its text controllers from it *synchronously*. That's
  /// the other half of the "sometimes empty" bug: the controllers were only
  /// ever filled by a listener that fires when the bloc's name/email/phone
  /// *change*, and this bloc is a singleton — reopen the screen with the same
  /// user and nothing changes, so the brand-new controllers stayed blank.
  factory EditProfileState.fromUser(UserModel? user) {
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

  const EditProfileState._();

  /// True when every field passes — computed rather than stored so it can't
  /// go stale against the text.
  bool get isValid =>
      Validators.required(name, 'Full name') == null &&
      Validators.email(email) == null &&
      Validators.phone(phone, expectedDigits: country.digits) == null;
}
