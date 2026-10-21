import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A rounded, hairline-bordered surface. [fill] is `#F6F6F6` on the list and
/// chat bubbles and white on the floating popovers; [shadowBlur] is Figma's
/// (14 on list cards, 28 on the popover, which floats higher).
///
/// The border is drawn **inside** the box, so Figma's 14px padding plus its 1px
/// stroke is the 15px the children actually sit at.
class TicketCard extends StatelessWidget {
  const TicketCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(14),
    this.fill = AppPalette.ticketCard,
    this.shadowBlur = 14,
    this.radius = 16,
    this.borderColor = AppPalette.ticketCardBorder,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final Color fill;
  final double shadowBlur;
  final double radius;
  final Color borderColor;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: fill,
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: borderColor),
        boxShadow: [
          BoxShadow(
            color: AppPalette.ticketShadow,
            blurRadius: shadowBlur,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: child,
    );
    return onTap == null
        ? card
        : GestureDetector(
            onTap: onTap,
            behavior: HitTestBehavior.opaque,
            child: card,
          );
  }
}
