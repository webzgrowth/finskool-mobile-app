import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'field_label.dart';

/// Labeled text field matching the auth screens: an icon + label row above
/// a bordered input (no icon inside the input itself, per the design).
class AuthTextField extends StatelessWidget {
  const AuthTextField({
    super.key,
    required this.label,
    required this.hint,
    required this.iconAsset,
    required this.onChanged,
    this.obscureText = false,
    this.suffixIcon,
    this.onSuffixTap,
    this.errorText,
    this.keyboardType,
  });

  final String label;
  final String hint;
  final String iconAsset;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final IconData? suffixIcon;
  final VoidCallback? onSuffixTap;
  final String? errorText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        FieldLabel(iconAsset: iconAsset, label: label),
        const SizedBox(height: AppSpacing.sm),
        TextField(
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          style: tt.bodyLarge,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: tt.bodySmall,
            errorText: errorText,
            isDense: true,
            suffixIcon: suffixIcon == null
                ? null
                : IconButton(
                    icon: Icon(suffixIcon, size: 18, color: cs.primary),
                    onPressed: onSuffixTap,
                  ),
          ),
        ),
      ],
    );
  }
}
