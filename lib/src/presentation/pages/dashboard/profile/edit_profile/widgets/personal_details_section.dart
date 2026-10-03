import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/country_codes.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_field_icons.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_text_field.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/phone_field.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Personal Details" — the editable trio, reusing the auth screens' own
/// labelled fields so the glyphs and input chrome match the rest of the app.
///
/// The header's pencil toggles [EditProfileState.isEditing]. It stays a
/// pencil in both states — committing is the job of the Save/Discard pair
/// that appears below the card while editing, not of this icon.
class PersonalDetailsSection extends StatelessWidget {
  const PersonalDetailsSection({
    super.key,
    required this.state,
    required this.nameController,
    required this.emailController,
    required this.phoneController,
  });

  final EditProfileState state;
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<EditProfileBloc>();
    final editing = state.isEditing;

    return TealSectionCard(
      title: 'Personal Details',
      trailing: _HeaderAction(
        onTap: () => bloc.add(const EditProfileEvent.editToggled()),
      ),
      child: Column(
        children: [
          AuthTextField(
            label: 'Full Name',
            hint: 'Your full name',
            iconAsset: AuthFieldIcons.person,
            controller: nameController,
            enabled: editing,
            errorText: state.nameError,
            textCapitalization: TextCapitalization.words,
            onChanged: (v) => bloc.add(EditProfileEvent.nameChanged(v)),
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthTextField(
            label: 'Email Address',
            hint: 'you@example.com',
            iconAsset: AuthFieldIcons.mail,
            controller: emailController,
            enabled: editing,
            errorText: state.emailError,
            keyboardType: TextInputType.emailAddress,
            onChanged: (v) => bloc.add(EditProfileEvent.emailChanged(v)),
          ),
          const SizedBox(height: AppSpacing.lg),
          PhoneField(
            countryCode: state.country.dialCode,
            controller: phoneController,
            enabled: editing,
            errorText: state.phoneError,
            onChanged: (v) => bloc.add(EditProfileEvent.phoneChanged(v)),
            // The chip reports a dial code; the bloc wants the country for
            // its digit-length rule. `byDialCode` resolves +1 to the US
            // rather than Canada, which is lossy in name only — both
            // expect 10 digits, so validation is unaffected.
            onCountryChanged: (code) => bloc.add(
              EditProfileEvent.countryChanged(CountryCodes.byDialCode(code)),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderAction extends StatelessWidget {
  const _HeaderAction({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 26,
        width: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: cs.surface, shape: BoxShape.circle),
        child: const Icon(Icons.edit_outlined,
            size: 14, color: AppPalette.primary),
      ),
    );
  }
}
