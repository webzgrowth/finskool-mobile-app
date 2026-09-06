import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'verify_phone_form.dart';

/// Step 1 of signup verification: confirm the WhatsApp number collected on
/// the sign-up form before a code is sent to it.
class VerifyPhoneScreen extends StatelessWidget {
  const VerifyPhoneScreen({super.key});

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
                    authSpan('Enter the 6-digit code we sent on '),
                    authSpan('WhatsApp number.', bold: true),
                  ],
                ),
                const AuthCard(child: VerifyPhoneForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
