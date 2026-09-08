import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'verify_email_form.dart';

/// Step 3 of signup verification: enter the 6-digit email code. Figma only
/// designed the WhatsApp-number verification pair, not this screen — it's
/// built to match their exact chrome (same header/card/OTP components used
/// by the phone step and the password-reset email step) since a signup
/// flow that verifies a phone number but not the email it was created
/// with isn't industry-standard.
class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

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
                  title: 'Verify your email',
                  subtitleSpans: [
                    authSpan('Check your '),
                    authSpan('registered email', bold: true),
                    authSpan(' and enter the verification code.'),
                  ],
                ),
                const AuthCard(child: VerifyEmailForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
