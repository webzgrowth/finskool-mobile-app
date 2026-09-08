import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Primary CTA button matching the Figma layout: label first, arrow after
/// (`ElevatedButton.icon` always puts its icon before the label, which is
/// the wrong order here, so this builds the row directly).
class AuthSubmitButton extends StatelessWidget {
  const AuthSubmitButton({
    super.key,
    required this.label,
    required this.loading,
    required this.onPressed,
  });

  final String label;
  final bool loading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          const SizedBox(width: AppSpacing.xs),
          if (loading)
            const SizedBox(
              height: 16,
              width: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
          else
            const Icon(Icons.arrow_forward, size: 16),
        ],
      ),
    );
  }
}
