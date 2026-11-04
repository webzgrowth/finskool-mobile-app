import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';

import 'social_verify_form.dart';

/// The WhatsApp code for a new social member. Confirming it creates the
/// account and logs in, so unlike signup there is no success page after it.
class SocialVerifyScreen extends StatelessWidget {
  const SocialVerifyScreen({super.key});

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
                  title: 'Verify your number',
                  subtitleSpans: [
                    authSpan('Enter the code we sent on '),
                    authSpan('WhatsApp', bold: true),
                    authSpan('.'),
                  ],
                ),
                const AuthCard(child: SocialVerifyForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
