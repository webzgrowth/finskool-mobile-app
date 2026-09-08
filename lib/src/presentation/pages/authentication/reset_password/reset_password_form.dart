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
import '../widgets/privacy_footer_note.dart';

class ResetPasswordForm extends StatelessWidget {
  const ResetPasswordForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PasswordResetBloc>();
    return BlocBuilder<PasswordResetBloc, PasswordResetState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const ResetCardTitle(title: 'Reset password'),
            const SizedBox(height: AppSpacing.xl),
            AuthTextField(
              label: 'Email Address',
              hint: 'Enter your registered email',
              iconAsset: AuthFieldIcons.mail,
              errorText: state.emailError,
              keyboardType: TextInputType.emailAddress,
              onChanged: (v) => bloc.add(PasswordResetEvent.emailChanged(v)),
            ),
            const SizedBox(height: AppSpacing.sm),
            Text('The code is valid for 10 minutes.',
                style: Theme.of(context).textTheme.bodySmall),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Send Reset Code',
              loading: false,
              // Validate (so errors still show), but don't gate navigation
              // on it — no real backend yet, so every button should move
              // the flow forward for testing.
              onPressed: () {
                bloc.add(const PasswordResetEvent.sendResetCode());
                context.push(AppRoutes.VERIFY_RESET_CODE_ROUTE_PATH);
              },
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
          ],
        );
      },
    );
  }
}
