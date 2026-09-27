import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One cell of a details grid: a small [AppPalette.primary] disc sitting to
/// the **left** of a bold label, with the value beneath the label (indented
/// past the disc, not under it).
///
/// Note this inverts the usual emphasis — the label is the bold near-black
/// one and the value beneath it is the quiet grey.
class DetailCell extends StatelessWidget {
  const DetailCell({
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
              trailing ?? Text(value!, style: type.value),
            ],
          ),
        ),
      ],
    );
  }
}

/// The 1px rule between two cells in a details grid. Full-height, so it
/// needs an `IntrinsicHeight` above the `Row` that holds it.
class GridVRule extends StatelessWidget {
  const GridVRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        color: AppPalette.subscriptionDivider,
      );
}

/// The 1px rule between two rows of a details grid.
class GridHRule extends StatelessWidget {
  const GridHRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppPalette.subscriptionDivider,
      );
}
