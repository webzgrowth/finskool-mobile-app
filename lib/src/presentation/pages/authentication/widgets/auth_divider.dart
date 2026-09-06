import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The "Or" divider between password auth and social auth.
class AuthDivider extends StatelessWidget {
  const AuthDivider({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Expanded(child: Divider(color: cs.outlineVariant)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
          child: Text('Or', style: tt.bodyMedium),
        ),
        Expanded(child: Divider(color: cs.outlineVariant)),
      ],
    );
  }
}
