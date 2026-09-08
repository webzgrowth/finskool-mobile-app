import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Already a community member?" hint shown on the Sign up screen.
class MemberHintCard extends StatelessWidget {
  const MemberHintCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: cs.tertiaryContainer,
        borderRadius: AppRadii.medium,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text('i',
                style: tt.labelLarge?.copyWith(color: cs.onPrimary)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Already a community member?',
                  style: tt.labelLarge?.copyWith(color: cs.primary),
                ),
                const SizedBox(height: 3),
                Text.rich(
                  TextSpan(
                    style: tt.bodySmall,
                    children: [
                      const TextSpan(
                          text: 'Enter the same phone number you registered '
                              'with on our '),
                      TextSpan(
                        text: 'WhatsApp community,',
                        style: inter(
                          size: 10,
                          weight: 700,
                          height: 1.6,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const TextSpan(
                          text: ' and your access will be restored automatically.'),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
