import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'apple_auth_button.dart';
import 'google_auth_button.dart';

/// "Continue with Google" — and, on an iPhone, Apple's own button beneath it.
/// Both start the same flow; the server decides whether this is a login or a
/// new member. Login and sign-up show the same pair (`verb` is just the copy).
///
/// Apple's button is [AppleAuthButton], drawn to the same size as Google's. It
/// is iPhone-only because the Android and web flow needs a Services ID this
/// app doesn't have.
class SocialAuthButtons extends StatelessWidget {
  const SocialAuthButtons({super.key, required this.verb});

  /// "Log in" or "Sign up" — the copy in front of "with Google / Apple".
  final String verb;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SocialAuthBloc, SocialAuthState>(
      buildWhen: (p, c) => p.state != c.state || p.provider != c.provider,
      builder: (context, state) {
        final busy = state.state.isLoading;
        void start(SocialProvider p) =>
            context.read<SocialAuthBloc>().add(SocialAuthEvent.signIn(p));
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            GoogleAuthButton(
              label: '$verb with Google',
              loading: busy && state.provider == SocialProvider.google,
              onPressed: busy ? null : () => start(SocialProvider.google),
            ),
            if (Platform.isIOS) ...[
              const SizedBox(height: AppSpacing.sm),
              AppleAuthButton(
                label: '$verb with Apple',
                onPressed: busy ? null : () => start(SocialProvider.apple),
              ),
            ],
          ],
        );
      },
    );
  }
}
