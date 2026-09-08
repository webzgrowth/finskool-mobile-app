import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'reset_password_form.dart';

/// Step 1 of the forgot-password flow: collect the registered email.
class ResetPasswordScreen extends StatelessWidget {
  const ResetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                AuthHeader(
                  title: 'Reset your password',
                  subtitleSpans: [
                    authSpan('Enter your '),
                    authSpan('registered email', bold: true),
                    authSpan(" and we'll send you a code."),
                  ],
                ),
                const AuthCard(child: ResetPasswordForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
