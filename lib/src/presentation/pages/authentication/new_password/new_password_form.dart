import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/reset_card_title.dart';
import '../widgets/password_strength_bar.dart';
import '../widgets/password_checklist.dart';
import '../widgets/auth_form_listener.dart';

class NewPasswordForm extends StatelessWidget {
  const NewPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PasswordResetBloc>();
    final tt = Theme.of(context).textTheme;
    return AuthFormListener<PasswordResetBloc, PasswordResetState>(
      status: (s) => s.state,
      message: (s) => s.message,
      isMine: (s) => s.step.isPasswordUpdated,
      onSuccess: (context, _) =>
          context.push(AppRoutes.PASSWORD_RESET_SUCCESS_ROUTE_PATH),
      child: BlocBuilder<PasswordResetBloc, PasswordResetState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ResetCardTitle(title: 'New password'),
            const SizedBox(height: AppSpacing.xl),
            AuthTextField(
              label: 'New Password',
              hint: 'Enter new password',
              iconAsset: AuthFieldIcons.lock,
              obscureText: state.obscureNewPassword,
              errorText: state.newPasswordError,
              suffixIcon: state.obscureNewPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () => bloc
                  .add(const PasswordResetEvent.toggleNewPasswordVisibility()),
              onChanged: (v) =>
                  bloc.add(PasswordResetEvent.newPasswordChanged(v)),
            ),
            const SizedBox(height: AppSpacing.sm),
            PasswordStrengthBar(password: state.newPassword),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              label: 'Confirm Password',
              hint: 'Re-enter new password',
              iconAsset: AuthFieldIcons.lock,
              obscureText: state.obscureConfirmPassword,
              errorText: state.confirmPasswordError,
              suffixIcon: state.obscureConfirmPassword
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () => bloc.add(
                  const PasswordResetEvent.toggleConfirmPasswordVisibility()),
              onChanged: (v) =>
                  bloc.add(PasswordResetEvent.confirmPasswordChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            PasswordChecklist(password: state.newPassword),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Update Password',
              loading: state.state.isLoading,
              onPressed: () =>
                  bloc.add(const PasswordResetEvent.updatePassword()),
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Changed your mind? ', style: tt.bodyMedium),
                GestureDetector(
                  onTap: () => context.go(AppRoutes.LOGIN_ROUTE_PATH),
                  child: Text(
                    'Back to login',
                    style: inter(
                      size: 12,
                      weight: 700,
                      height: 1.5,
                      color: AppPalette.headerGradientEnd,
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
      ),
    );
  }
}
