import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/member_hint_card.dart';
import '../widgets/phone_field.dart';
import '../widgets/privacy_footer_note.dart';
import 'google_account_chip.dart';

/// The phone step for a new member who signed in with Google or Apple
/// (`phone_required`): the provider account, the WhatsApp number, and — only
/// when the provider gave no name — the full name.
class GoogleLastStepForm extends StatelessWidget {
  const GoogleLastStepForm({super.key});

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SocialAuthBloc>();
    final tt = Theme.of(context).textTheme;
    return BlocBuilder<SocialAuthBloc, SocialAuthState>(
      builder: (context, state) {
        final email = state.email ?? '';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: AppSpacing.lg),
            GoogleAccountChip(
              name: state.name ?? (email.isEmpty ? 'Your account' : email),
              email: state.name == null ? '' : email,
              provider: state.provider ?? SocialProvider.google,
            ),
            const SizedBox(height: AppSpacing.lg),
            if (state.needsName) ...[
              AuthTextField(
                label: 'Full Name',
                hint: 'Enter your full name',
                iconAsset: AuthFieldIcons.person,
                errorText: state.nameError,
                textCapitalization: TextCapitalization.words,
                onChanged: (v) => bloc.add(SocialAuthEvent.nameChanged(v)),
              ),
              const SizedBox(height: AppSpacing.lg),
            ],
            PhoneField(
              countryCode: state.countryCode,
              errorText: state.phoneError,
              onChanged: (v) => bloc.add(SocialAuthEvent.phoneChanged(v)),
              onCountryChanged: (v) =>
                  bloc.add(SocialAuthEvent.countryChanged(v)),
            ),
            const SizedBox(height: AppSpacing.lg),
            const MemberHintCard(),
            const SizedBox(height: AppSpacing.lg),
            Text.rich(
              TextSpan(
                style: tt.bodySmall,
                children: [
                  const TextSpan(text: "We'll send a "),
                  TextSpan(
                    text: '6-digit code',
                    style: inter(
                      size: 10,
                      weight: 700,
                      height: 1.6,
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const TextSpan(
                    text:
                        ' to this number on WhatsApp number to confirm '
                        "it's yours.",
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AuthSubmitButton(
              label: 'Send Verification Code',
              loading: state.state.isLoading,
              onPressed: () => bloc.add(const SocialAuthEvent.sendCode()),
            ),
            const SizedBox(height: AppSpacing.lg),
            const PrivacyFooterNote(),
            const SizedBox(height: AppSpacing.md),
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('Use a different account'),
            ),
          ],
        );
      },
    );
  }
}
