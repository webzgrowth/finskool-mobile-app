import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Log in with Apple", drawn to match [GoogleAuthButton] — same 42px height,
/// shape and label size — instead of the package's `SignInWithAppleButton`,
/// whose text is hard-wired to ~43% of the button height and so read as far
/// larger than every other control on these screens.
///
/// Apple's guidelines allow a custom button as long as it uses the Apple logo,
/// one of the approved titles ("Sign in with", "Sign up with", "Continue
/// with") and the black or white fill — here the theme's `onSurface` on
/// `surface`, which is black-on-white in light mode and white-on-black in dark.
class AppleAuthButton extends StatelessWidget {
  const AppleAuthButton({
    super.key,
    required this.label,
    required this.onPressed,
  });

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    // An `OutlinedButton` with a solid fill, not a `FilledButton`: it is the
    // base [GoogleAuthButton] uses, so padding, border width and shape — and
    // therefore the height — are identical by construction.
    return OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        backgroundColor: cs.onSurface,
        foregroundColor: cs.surface,
        side: BorderSide(color: cs.onSurface),
        minimumSize: const Size.fromHeight(42),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.apple, size: 18, color: cs.surface),
          const SizedBox(width: AppSpacing.sm),
          Text(label, style: tt.titleSmall?.copyWith(color: cs.surface)),
        ],
      ),
    );
  }
}
