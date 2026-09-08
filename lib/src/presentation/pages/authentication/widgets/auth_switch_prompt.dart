import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Don't have an account? Sign up" style footer prompt.
class AuthSwitchPrompt extends StatelessWidget {
  const AuthSwitchPrompt({
    super.key,
    required this.message,
    required this.actionLabel,
    required this.onTap,
  });

  final String message;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // Figma's exact muted tone (#7a8a80) for this line — close to but
        // distinct from `onSurfaceVariant`, so set it explicitly rather
        // than relying on a body style meant for regular copy.
        Text(message, style: tt.bodyMedium?.copyWith(color: cs.outline)),
        const SizedBox(width: AppSpacing.sm),
        OutlinedButton(
          onPressed: onTap,
          style: OutlinedButton.styleFrom(
            minimumSize: const Size(0, 31),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            side: BorderSide(color: cs.primary),
            // Figma uses a 6px radius here, not the theme's default
            // AppRadii.medium (14px) — on a 31px-tall pill that reads as
            // an almost fully-rounded stadium shape instead of a subtly
            // rounded rectangle.
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Text(actionLabel,
              style: tt.titleSmall?.copyWith(color: cs.primary)),
        ),
      ],
    );
  }
}
