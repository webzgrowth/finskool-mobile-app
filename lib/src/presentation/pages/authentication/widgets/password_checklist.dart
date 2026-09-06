import 'package:flutter/material.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The three live pass/fail criteria shown under the new-password fields.
class PasswordChecklist extends StatelessWidget {
  const PasswordChecklist({super.key, required this.password});

  final String password;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _Item(
          label: 'At least 8 characters',
          met: Validators.hasMinLength(password),
        ),
        const SizedBox(height: AppSpacing.xs),
        _Item(
          label: 'One number and one symbol',
          met: Validators.hasNumberAndSymbol(password),
        ),
        const SizedBox(height: AppSpacing.xs),
        _Item(
          label: 'One uppercase and lowercase letter',
          met: Validators.hasUpperAndLower(password),
        ),
      ],
    );
  }
}

class _Item extends StatelessWidget {
  const _Item({required this.label, required this.met});

  final String label;
  final bool met;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: met ? AppPalette.success : cs.surfaceContainerHighest,
          ),
          alignment: Alignment.center,
          child: met
              ? const Icon(Icons.check, size: 10, color: Colors.white)
              : null,
        ),
        const SizedBox(width: AppSpacing.sm),
        Text(label, style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
      ],
    );
  }
}
