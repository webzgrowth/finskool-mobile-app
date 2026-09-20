import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_header_subtitle.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_card.dart';
import 'compliance_form.dart';

/// The one-time SEBI step before a user's first paid community —
/// Figma `893:16303`.
///
/// Drawn on the **auth chrome** because that's what Figma does: the same
/// gradient hero + white card as the sign-up flow, with "One last step" as
/// the headline. Reusing `AuthHeader`/`AuthCard` keeps it matched for free.
class ComplianceScreen extends StatelessWidget {
  const ComplianceScreen({super.key});

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
                    authSpan('SEBI requires these details before we can open '),
                    authSpan('your community access.', bold: true),
                  ],
                ),
                const AuthCard(child: ComplianceForm()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
