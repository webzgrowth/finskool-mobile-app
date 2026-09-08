import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'google_last_step_form.dart';

/// Shown after "Sign up with Google": confirm the picked Google account,
/// collect the WhatsApp number (same [PhoneField] + [MemberHintCard] as
/// the manual sign-up form), then send the WhatsApp code.
class GoogleLastStepScreen extends StatelessWidget {
  const GoogleLastStepScreen({super.key});

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
                  title: 'One last step',
                  subtitleSpans: [
                    authSpan('Confirm your '),
                    authSpan('WhatsApp number', bold: true),
                    authSpan(' to finish setting up.'),
                  ],
                ),
                const AuthCard(child: GoogleLastStepForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
