import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

/// Figma's 7x4 chevron, drawn pointing **down**. The list rows turn it a
/// quarter to point right (`#153D3A` at 60%); a dropdown field uses the solid
/// black variant.
class TicketChevron extends StatelessWidget {
  const TicketChevron({super.key, this.pointsRight = false, this.dark = false});

  final bool pointsRight;
  final bool dark;

  @override
  Widget build(BuildContext context) {
    final icon = SvgPicture.asset(
      dark
          ? 'assets/icons/ticket_chevron_dark.svg'
          : 'assets/icons/ticket_chevron.svg',
    );
    return pointsRight ? RotatedBox(quarterTurns: 3, child: icon) : icon;
  }
}
