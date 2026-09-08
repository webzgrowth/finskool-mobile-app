import 'package:flutter/material.dart';
import 'package:finskool/src/comman/validators.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Three-segment strength meter plus a "Weak/Medium/Strong" label, derived
/// from the same three checks shown in the checklist below it.
class PasswordStrengthBar extends StatelessWidget {
  const PasswordStrengthBar({super.key, required this.password});

  final String password;

  int get _score => [
        Validators.hasMinLength(password),
        Validators.hasNumberAndSymbol(password),
        Validators.hasUpperAndLower(password),
      ].where((met) => met).length;

  String get _label => switch (_score) {
        0 => 'Too weak',
        1 => 'Weak',
        2 => 'Medium',
        _ => 'Strong',
      };

  Color get _labelColor => switch (_score) {
        0 || 1 => AppPalette.error,
        2 => AppPalette.warning,
        _ => AppPalette.success,
      };

  Color _segmentColor(ColorScheme cs, int index) =>
      index < _score ? _labelColor : cs.surfaceContainerHighest;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: List.generate(3, (i) {
            return Expanded(
              child: Container(
                margin: EdgeInsets.only(right: i < 2 ? AppSpacing.xs : 0),
                height: 4,
                decoration: BoxDecoration(
                  color: _segmentColor(cs, i),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            );
          }),
        ),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: [
            Text('Password strength: ', style: tt.bodySmall),
            Text(_label,
                style: inter(size: 10, weight: 700, height: 1.6, color: _labelColor)),
          ],
        ),
      ],
    );
  }
}
