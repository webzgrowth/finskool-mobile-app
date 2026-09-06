import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'verify_reset_code_form.dart';

/// Step 2 of the forgot-password flow: enter the 6-digit email code.
class VerifyResetCodeScreen extends StatelessWidget {
  const VerifyResetCodeScreen({super.key});

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
                  title: 'Enter Your Code',
                  subtitleSpans: [
                    authSpan('Check your '),
                    authSpan('registered email', bold: true),
                    authSpan(' and enter the '),
                    authSpan('verification code.', weight: 500),
                  ],
                ),
                const AuthCard(child: VerifyResetCodeForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
