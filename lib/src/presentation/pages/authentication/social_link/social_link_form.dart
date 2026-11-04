import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../widgets/auth_field_icons.dart';
import '../widgets/auth_submit_button.dart';
import '../widgets/auth_text_field.dart';
import '../widgets/back_arrow_button.dart';
import '../widgets/readonly_value_field.dart';

class SocialLinkForm extends StatefulWidget {
  const SocialLinkForm({super.key});

  @override
  State<SocialLinkForm> createState() => _SocialLinkFormState();
}

class _SocialLinkFormState extends State<SocialLinkForm> {
  // Show/hide is transient UI, not app state — see CLAUDE.md "Not everything
  // is a bloc".
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<SocialAuthBloc>();
    final tt = Theme.of(context).textTheme;
    return BlocBuilder<SocialAuthBloc, SocialAuthState>(
      builder: (context, state) {
        final provider = state.provider == SocialProvider.apple
            ? 'Apple'
            : 'Google';
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: BackArrowButton(onTap: () => context.pop()),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text(
              'Enter that account\'s password to connect $provider. '
              'Next time, $provider alone will log you in.',
              style: tt.bodyLarge?.copyWith(height: 1.3),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: AppSpacing.xl),
            ReadonlyValueField(
              iconAsset: AuthFieldIcons.mail,
              value: state.email ?? '',
              actionLabel: 'Change',
              onTap: () => context.pop(),
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              label: 'Password',
              hint: 'Enter your password',
              iconAsset: AuthFieldIcons.lock,
              obscureText: _obscure,
              errorText: state.passwordError,
              suffixIcon: _obscure
                  ? Icons.visibility_off_outlined
                  : Icons.visibility_outlined,
              onSuffixTap: () => setState(() => _obscure = !_obscure),
              onChanged: (v) => bloc.add(SocialAuthEvent.passwordChanged(v)),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  context.read<PasswordResetBloc>().add(
                    const PasswordResetEvent.initial(),
                  );
                  context.push(AppRoutes.RESET_PASSWORD_ROUTE_PATH);
                },
                child: const Text('Forgot Password ?'),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthSubmitButton(
              label: 'Connect & Log In',
              loading: state.state.isLoading,
              onPressed: () => bloc.add(const SocialAuthEvent.link()),
            ),
          ],
        );
      },
    );
  }
}
