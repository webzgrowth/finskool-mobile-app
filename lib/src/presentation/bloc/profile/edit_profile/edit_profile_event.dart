part of 'edit_profile_bloc.dart';

@freezed
class EditProfileEvent with _$EditProfileEvent {
  /// Seeds the form from the cached [UserModel]. The screen fires this on
  /// mount — the bloc is a singleton like every other form bloc here, so
  /// it must not carry a previous visit's edits.
  const factory EditProfileEvent.prefill(UserModel? user) = _Prefill;

  /// The pencil in the "Personal Details" header. Fields render read-only
  /// until this is on.
  const factory EditProfileEvent.editToggled() = _EditToggled;

  const factory EditProfileEvent.nameChanged(String name) = _NameChanged;
  const factory EditProfileEvent.emailChanged(String email) = _EmailChanged;
  const factory EditProfileEvent.phoneChanged(String phone) = _PhoneChanged;
  const factory EditProfileEvent.countryChanged(Country country) =
      _CountryChanged;

  const factory EditProfileEvent.submit() = _Submit;
}
