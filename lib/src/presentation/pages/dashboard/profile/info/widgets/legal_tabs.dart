import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The two-segment switch under the Terms hero — a `#F6F6F6` track with a
/// white pill under the active label (Figma `Tabs`, 44 tall, 36 tall pills).
/// Which tab is open is local UI state, so it lives in the screen's `State`.
class LegalTabs extends StatelessWidget {
  const LegalTabs({
    super.key,
    required this.labels,
    required this.selected,
    required this.onChanged,
  });

  final List<String> labels;
  final int selected;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return Container(
      height: 44,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppPalette.ticketCard,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          for (var i = 0; i < labels.length; i++)
            Expanded(
              child: GestureDetector(
                onTap: () => onChanged(i),
                behavior: HitTestBehavior.opaque,
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  curve: Curves.easeOutCubic,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: i == selected
                        ? AppPalette.white
                        : Colors.transparent,
                    borderRadius: BorderRadius.circular(9),
                    boxShadow: i == selected
                        ? const [
                            BoxShadow(
                              color: AppPalette.ticketShadow,
                              blurRadius: 6,
                              offset: Offset(0, 1),
                            ),
                          ]
                        : null,
                  ),
                  child: Text(
                    labels[i],
                    style: i == selected ? type.tabOn : type.tabOff,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
