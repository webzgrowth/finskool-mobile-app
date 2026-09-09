import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart';
import '../widgets/auth_field_icons.dart';
import '../widgets/auth_form_listener.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/enter_code_label.dart';
import '../widgets/privacy_footer_note.dart';
import '../widgets/readonly_value_field.dart';
import '../widgets/resend_code_row.dart';
import '../widgets/otp_boxes.dart';

/// Single "Verify your number" screen per Figma — the phone number
/// confirmation and the OTP entry live on one screen, not two.
class VerifyPhoneForm extends StatelessWidget {
  const VerifyPhoneForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SignupVerificationBloc>();
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return AuthFormListener<SignupVerificationBloc, SignupVerificationState>(
      status: (s) => s.state,
      message: (s) => s.message,
      onSuccess: _onVerified,
      child: BlocBuilder<SignupVerificationBloc, SignupVerificationState>(
      builder: (context, state) {
        final boldSpan =
            inter(size: 14, weight: 600, height: 1.3, color: cs.onSurface);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text.rich(
              TextSpan(style: tt.bodyLarge?.copyWith(height: 1.3), children: [
                const TextSpan(text: 'A '),
                TextSpan(text: '6-digit code', style: boldSpan),
                const TextSpan(text: ' has been sent to your '),
                TextSpan(text: 'WhatsApp number', style: boldSpan),
              ]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ReadonlyValueField(
              iconAsset: AuthFieldIcons.phone,
              value: state.phoneDisplay,
              actionLabel: 'Change',
              onTap: () => context.pop(),
            ),
            const SizedBox(height: AppSpacing.lg),
            const EnterCodeLabel(),
            const SizedBox(height: AppSpacing.sm),
            OtpBoxes(
              onChanged: (v) =>
                  bloc.add(SignupVerificationEvent.phoneCodeChanged(v)),
            ),
            if (state.phoneCodeError != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(state.phoneCodeError!,
                  style: tt.bodySmall?.copyWith(color: cs.error)),
            ],
            const SizedBox(height: AppSpacing.md),
            ResendCodeRow(
              secondsRemaining: state.phoneResendSeconds,
              onResend: () =>
                  bloc.add(const SignupVerificationEvent.resendPhoneCode()),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Verify & Continue',
              loading: state.state.isLoading,
              onPressed: () =>
                  bloc.add(const SignupVerificationEvent.verifyPhoneCode()),
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
          ],
        );
      },
      ),
    );
  }

  /// The number is verified. The API deliberately does **not** create a
  /// session here, so log in silently with the credentials the sign-up form
  /// still holds — otherwise `/dashboard` would load with no cookie.
  ///
  /// The Google path never registered (no social endpoint exists yet) and has
  /// no password to replay, so it just moves on, as it did before.
  void _onVerified(BuildContext context, SignupVerificationState state) {
    if (state.isBackedByApi) {
      final signUp = context.read<SignUpFormBloc>().state;
      context.read<LoginFormBloc>().add(
            LoginFormEvent.loginWith(
              email: signUp.email,
              password: signUp.password,
            ),
          );
    }
    context.push(AppRoutes.SIGNUP_SUCCESS_ROUTE_PATH);
  }
}
