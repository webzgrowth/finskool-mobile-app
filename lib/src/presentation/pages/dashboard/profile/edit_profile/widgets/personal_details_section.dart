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
/// The header's pencil toggles [EditProfileState.isEditing]; it becomes a
/// check that submits. Figma only draws the read-only state, so the
/// editing affordance is inferred — the pencil is the only control it
/// shows, and a form with no way to commit would be a dead end.
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
        editing: editing,
        loading: state.state.isLoading,
        onTap: () => bloc.add(editing
            ? const EditProfileEvent.submit()
            : const EditProfileEvent.editToggled()),
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
  const _HeaderAction({
    required this.editing,
    required this.loading,
    required this.onTap,
  });

  final bool editing;
  final bool loading;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      onTap: loading ? null : onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 26,
        width: 26,
        alignment: Alignment.center,
        decoration: BoxDecoration(color: cs.surface, shape: BoxShape.circle),
        child: loading
            ? SizedBox(
                height: 13,
                width: 13,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: AppPalette.primary,
                ),
              )
            : Icon(
                editing ? Icons.check : Icons.edit_outlined,
                size: 14,
                color: AppPalette.primary,
              ),
      ),
    );
  }
}
