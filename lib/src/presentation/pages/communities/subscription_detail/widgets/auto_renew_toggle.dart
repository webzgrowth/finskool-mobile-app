import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The auto-renew switch — Figma's 38x16.5 green "On" pill with a 12.5px
/// knob, not a Material `Switch`. The knob slides across and the pill changes
/// colour as one 220ms movement.
///
/// Local state: there's no backend field for auto-renew, so this toggles for
/// show until one exists (same category as the compliance flag).
class AutoRenewToggle extends StatefulWidget {
  const AutoRenewToggle({super.key, required this.initial});

  final bool initial;

  @override
  State<AutoRenewToggle> createState() => _AutoRenewToggleState();
}

class _AutoRenewToggleState extends State<AutoRenewToggle> {
  late bool _on = widget.initial;

  static const _duration = Duration(milliseconds: 220);

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Semantics(
      toggled: _on,
      label: 'Auto-renew',
      child: GestureDetector(
        onTap: () => setState(() => _on = !_on),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: _duration,
          curve: Curves.easeOutCubic,
          height: 16.5,
          width: 38,
          decoration: BoxDecoration(
            color: _on ? AppPalette.profileRenew : AppPalette.ticketPending,
            borderRadius: BorderRadius.circular(41),
          ),
          child: Stack(
            children: [
              Positioned(
                left: _on ? 17 : 8,
                top: 2.5,
                child: Text(
                  _on ? 'On' : 'Off',
                  style: type.value.copyWith(
                    color: _on ? AppPalette.white : AppPalette.ticketMuted,
                    fontSize: 8.26,
                    height: 1.2,
                  ),
                ),
              ),
              AnimatedPositioned(
                duration: _duration,
                curve: Curves.easeOutCubic,
                left: _on ? 2 : 23.5,
                top: 2,
                child: Container(
                  height: 12.5,
                  width: 12.5,
                  decoration: const BoxDecoration(
                    color: AppPalette.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 3.13,
                        offset: Offset(0, 1.57),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
