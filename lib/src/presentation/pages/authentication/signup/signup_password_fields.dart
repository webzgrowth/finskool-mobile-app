import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_field_icons.dart';

/// Password + confirm-password fields for the Sign up form, split out to
/// keep `signup_form.dart` under the file-length guideline.
class SignUpPasswordFields extends StatelessWidget {
  const SignUpPasswordFields({
    super.key,
    required this.state,
    required this.bloc,
  });

  final SignUpFormState state;
  final SignUpFormBloc bloc;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AuthTextField(
          label: 'Password',
          hint: 'Create a password',
          iconAsset: AuthFieldIcons.lock,
          obscureText: state.obscurePassword,
          errorText: state.passwordError,
          suffixIcon: state.obscurePassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onSuffixTap: () =>
              bloc.add(const SignUpFormEvent.togglePasswordVisibility()),
          onChanged: (v) => bloc.add(SignUpFormEvent.passwordChanged(v)),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text('Use at least 8 characters with a number and a symbol.',
            style: Theme.of(context).textTheme.bodySmall),
        const SizedBox(height: AppSpacing.lg),
        AuthTextField(
          label: 'Confirm Password',
          hint: 'Confirm your password',
          iconAsset: AuthFieldIcons.lock,
          obscureText: state.obscureConfirmPassword,
          errorText: state.confirmPasswordError,
          suffixIcon: state.obscureConfirmPassword
              ? Icons.visibility_off_outlined
              : Icons.visibility_outlined,
          onSuffixTap: () => bloc
              .add(const SignUpFormEvent.toggleConfirmPasswordVisibility()),
          onChanged: (v) =>
              bloc.add(SignUpFormEvent.confirmPasswordChanged(v)),
        ),
      ],
    );
  }
}
