import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'new_password_form.dart';

/// Step 3 of the forgot-password flow: choose a new password.
class NewPasswordScreen extends StatelessWidget {
  const NewPasswordScreen({super.key});

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
                  title: 'Set a new password',
                  subtitleSpans: [
                    authSpan('Choose a '),
                    authSpan('strong password', bold: true),
                    authSpan(" you haven't used before."),
                  ],
                ),
                const AuthCard(child: NewPasswordForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
