import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Sign-out control. Disabled while the request is in flight so a double tap
/// can't fire two logouts.
class LogoutButton extends StatelessWidget {
  const LogoutButton({
    super.key,
    required this.loading,
    required this.onPressed,
  });

  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return OutlinedButton.icon(
      onPressed: loading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: cs.error,
        side: BorderSide(color: cs.error.withValues(alpha: 0.5)),
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      ),
      icon: loading
          ? SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2, color: cs.error),
            )
          : const Icon(Icons.logout, size: 18),
      label: Text(loading ? 'Signing out…' : 'Log Out'),
    );
  }
}
