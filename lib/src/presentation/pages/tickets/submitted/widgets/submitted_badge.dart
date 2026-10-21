import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The shield: a 104px pale halo around a 72px `#B7DCDC` disc holding
/// Figma's 42.8x33 illustration.
class SubmittedBadge extends StatelessWidget {
  const SubmittedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 104,
      width: 104,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppPalette.ticketTagSurface,
        shape: BoxShape.circle,
      ),
      child: Container(
        height: 72,
        width: 72,
        alignment: Alignment.center,
        decoration: const BoxDecoration(
          color: AppPalette.ticketSuccessDisc,
          shape: BoxShape.circle,
        ),
        child: Image.asset(
          'assets/images/ticket_success.png',
          width: 42.8,
          height: 33,
        ),
      ),
    );
  }
}
