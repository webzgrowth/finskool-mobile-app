import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/enter_code_label.dart';
import '../widgets/otp_boxes.dart';
import '../widgets/privacy_footer_note.dart';
import '../widgets/readonly_value_field.dart';
import '../widgets/resend_code_row.dart';

class SocialVerifyForm extends StatelessWidget {
  const SocialVerifyForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SocialAuthBloc>();
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return BlocBuilder<SocialAuthBloc, SocialAuthState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: AppSpacing.lg),
            ReadonlyValueField(
              iconAsset: AuthFieldIcons.phone,
              value: state.sentTo,
              actionLabel: 'Change',
              onTap: () => context.pop(),
            ),
            const SizedBox(height: AppSpacing.lg),
            const EnterCodeLabel(),
            const SizedBox(height: AppSpacing.sm),
            OtpBoxes(onChanged: (v) => bloc.add(SocialAuthEvent.otpChanged(v))),
            if (state.otpError != null) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                state.otpError!,
                style: tt.bodySmall?.copyWith(color: cs.error),
              ),
            ],
            if (state.otpExpiresInSeconds > 0) ...[
              const SizedBox(height: AppSpacing.sm),
              Text(
                'The code is valid for '
                '${(state.otpExpiresInSeconds / 60).ceil()} minutes.',
                style: tt.bodySmall,
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: AppSpacing.md),
            ResendCodeRow(
              secondsRemaining: state.resendSeconds,
              onResend: () => bloc.add(const SocialAuthEvent.resend()),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Verify & Continue',
              loading: state.state.isLoading,
              onPressed: () => bloc.add(const SocialAuthEvent.verify()),
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
          ],
        );
      },
    );
  }
}
