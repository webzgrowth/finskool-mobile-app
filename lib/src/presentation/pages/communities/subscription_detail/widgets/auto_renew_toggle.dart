import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The auto-renew switch — a green "On" pill with the knob on the left,
/// per Figma, not a Material `Switch`.
///
/// Local state: there's no backend field for auto-renew, so this toggles
/// for show until one exists (same category as the compliance flag).
class AutoRenewToggle extends StatefulWidget {
  const AutoRenewToggle({super.key, required this.initial});

  final bool initial;

  @override
  State<AutoRenewToggle> createState() => _AutoRenewToggleState();
}

class _AutoRenewToggleState extends State<AutoRenewToggle> {
  late bool _on = widget.initial;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    final label = Text(
      _on ? 'On' : 'Off',
      style: type.value.copyWith(
        color: AppPalette.white,
        fontWeight: FontWeight.w600,
      ),
    );
    const knob = _Knob();

    return GestureDetector(
      onTap: () => setState(() => _on = !_on),
      child: Container(
        height: 19,
        padding: const EdgeInsets.symmetric(horizontal: 3),
        decoration: BoxDecoration(
          color: _on ? AppPalette.announcementGreen : AppPalette.outline,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: _on
              ? [knob, const SizedBox(width: 5), label, const SizedBox(width: 4)]
              : [const SizedBox(width: 4), label, const SizedBox(width: 5), knob],
        ),
      ),
    );
  }
}

class _Knob extends StatelessWidget {
  const _Knob();

  @override
  Widget build(BuildContext context) => Container(
        height: 13,
        width: 13,
        decoration: const BoxDecoration(
          color: AppPalette.white,
          shape: BoxShape.circle,
        ),
      );
}
