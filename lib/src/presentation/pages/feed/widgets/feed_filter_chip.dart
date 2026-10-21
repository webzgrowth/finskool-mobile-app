import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One filter option: the app's pill chip — a solid `#108B8B` pill with white
/// text when on, a `#F6F6F6` one with a `#7D7D91` hairline when off (the same
/// pair the ticket filters use). The fill, edge and text colour animate
/// together on toggle.
class FeedFilterChip extends StatelessWidget {
  const FeedFilterChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final base = context.ticketType.chip.copyWith(fontSize: 12);
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          height: 34,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected ? AppPalette.badgeTeal : AppPalette.ticketCard,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: selected
                  ? AppPalette.badgeTeal
                  : AppPalette.ticketChipBorder,
            ),
          ),
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 180),
            style: base.copyWith(
              color: selected ? AppPalette.white : AppPalette.ticketInkSoft,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
