import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One cell of the Plan/Transaction grid: a small teal disc sitting to the
/// **left** of a bold label, with the value beneath the label (indented
/// past the disc, not under it).
class SubscriptionDetailItem extends StatelessWidget {
  const SubscriptionDetailItem({
    super.key,
    required this.icon,
    required this.label,
    this.value,
    this.trailing,
  }) : assert(value != null || trailing != null);

  final IconData icon;
  final String label;
  final String? value;

  /// Replaces the value line — the auto-renew toggle is the only user.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 18,
          width: 18,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppPalette.primary,
            shape: BoxShape.circle,
          ),
          child: Icon(icon, size: 10, color: AppPalette.white),
        ),
        const SizedBox(width: 5),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: type.label),
              const SizedBox(height: 3),
              if (trailing != null)
                trailing!
              else
                Text(value!, style: type.value),
            ],
          ),
        ),
      ],
    );
  }
}
