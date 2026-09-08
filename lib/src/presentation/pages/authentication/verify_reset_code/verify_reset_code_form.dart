import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart';
import '../widgets/otp_boxes.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/privacy_footer_note.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/resend_code_row.dart';
import '../widgets/change_link_row.dart';

class VerifyResetCodeForm extends StatelessWidget {
  const VerifyResetCodeForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PasswordResetBloc>();
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
      builder: (context, state) {
        final boldSpan = inter(size: 14, weight: 600, height: 1.3, color: cs.onSurface);
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            Text.rich(
              TextSpan(style: tt.bodyLarge?.copyWith(height: 1.3), children: [
                const TextSpan(text: 'A '),
                TextSpan(text: '6-digit code', style: boldSpan),
                const TextSpan(
                    text: ' has been sent to your registered email address '),
                TextSpan(text: state.email, style: boldSpan),
              ]),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            OtpBoxes(
              onChanged: (v) => bloc.add(PasswordResetEvent.codeChanged(v)),
            ),
            if (state.codeError != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(state.codeError!,
                  style: tt.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.error)),
            ],
            const SizedBox(height: AppSpacing.md),
            ResendCodeRow(
              secondsRemaining: state.resendSeconds,
              onResend: () =>
                  bloc.add(const PasswordResetEvent.resendCode()),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Verify & Continue',
              loading: false,
              // Validate (so errors still show if you navigate back), but
              // don't gate navigation on it — there's no real backend yet,
              // so every button should move the flow forward for testing.
              onPressed: () {
                bloc.add(const PasswordResetEvent.verifyCode());
                context.push(AppRoutes.NEW_PASSWORD_ROUTE_PATH);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
            const SizedBox(height: AppSpacing.md),
            ChangeLinkRow(
              question: 'Wrong E-mail?',
              actionLabel: 'Change it',
              onTap: () {
                bloc.add(const PasswordResetEvent.changeEmail());
                context.pop();
              },
            ),
          ],
        );
      },
    );
  }
}
