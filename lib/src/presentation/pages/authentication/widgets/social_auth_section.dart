import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'auth_divider.dart';
import 'social_auth_buttons.dart';

/// The "Or" divider and the Google / Apple buttons under a login or sign-up
/// form — gone entirely once the server has said social login is switched off
/// (`404 SOCIAL_LOGIN_DISABLED`), so there's no orphaned "Or" above nothing.
class SocialAuthSection extends StatelessWidget {
  const SocialAuthSection({super.key, required this.verb});

  /// "Log in" or "Sign up".
  final String verb;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAuthBloc, SocialAuthState>(
      buildWhen: (p, c) => p.unavailable != c.unavailable,
      builder: (context, state) {
        if (state.unavailable) return const SizedBox.shrink();
        return Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            const AuthDivider(),
            const SizedBox(height: AppSpacing.lg),
            SocialAuthButtons(verb: verb),
          ],
        );
      },
    );
  }
}
