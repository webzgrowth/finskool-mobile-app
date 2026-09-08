import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One "All (N)" / "👍 12" filter chip in the Reactions sheet's tab row.
class ReactionFilterChip extends StatelessWidget {
  const ReactionFilterChip(
      {super.key, required this.label, required this.selected, required this.onTap});

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.sm),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => onTap(),
        selectedColor: cs.primary.withValues(alpha: 0.15),
      ),
    );
  }
}
