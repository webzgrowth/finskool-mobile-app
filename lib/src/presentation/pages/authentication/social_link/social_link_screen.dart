import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';

import 'social_link_form.dart';

/// `link_required`: this email already has an account, so the member proves
/// it is theirs with that account's password before the provider is linked.
class SocialLinkScreen extends StatelessWidget {
  const SocialLinkScreen({super.key});

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
                  title: 'Connect your account',
                  subtitleSpans: [
                    authSpan('You already have a '),
                    authSpan('Finskool account', bold: true),
                    authSpan(' with this email.'),
                  ],
                ),
                const AuthCard(child: SocialLinkForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
