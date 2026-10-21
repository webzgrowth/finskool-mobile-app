import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's switch: a 40x24 `#108B8B` track with a 20px white knob, not a
/// Material `Switch`. The knob slides and the track fades between on and off
/// (the off colour isn't drawn in the design, so it borrows the pending grey).
class ProfileToggle extends StatelessWidget {
  const ProfileToggle({
    super.key,
    required this.value,
    required this.onChanged,
  });

  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      toggled: value,
      child: GestureDetector(
        onTap: () => onChanged(!value),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          height: 24,
          width: 40,
          padding: const EdgeInsets.all(2),
          decoration: BoxDecoration(
            color: value ? AppPalette.badgeTeal : AppPalette.ticketPending,
            borderRadius: BorderRadius.circular(12),
          ),
          child: AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: value ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              height: 20,
              width: 20,
              decoration: const BoxDecoration(
                color: AppPalette.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0x2E000000),
                    blurRadius: 3,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
