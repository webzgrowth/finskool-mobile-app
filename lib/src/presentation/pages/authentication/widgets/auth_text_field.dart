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
    this.textCapitalization = TextCapitalization.none,
    this.controller,
    this.enabled = true,
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

  /// The auth forms start empty and are uncontrolled; Edit Profile seeds
  /// its fields from the cached user, so it passes a controller.
  final TextEditingController? controller;

  /// False renders the field read-only — Edit Profile's fields until its
  /// header pencil is tapped.
  final bool enabled;

  /// Used by the compliance screen's PAN field, which Figma specifies in
  /// capitals ("Enter your PAN exactly as printed on the card, in
  /// capitals.").
  final TextCapitalization textCapitalization;

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
          controller: controller,
          enabled: enabled,
          onChanged: onChanged,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
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
