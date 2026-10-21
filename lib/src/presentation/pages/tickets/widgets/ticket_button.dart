import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The ticket screens' button: a solid `#108B8B` bar with the label and
/// Figma's arrow, or — [ghost] — an outlined `#888780` one ("Need help?").
///
/// 42px tall, r=10, label Inter SemiBold 14 with 0.27 tracking, the arrow one
/// pixel after the text. Every button spans the content width; Figma draws
/// them 333, 335 and 337 wide on different frames, which is the design's own
/// inconsistency rather than a distinction worth reproducing.
class TicketButton extends StatelessWidget {
  const TicketButton({
    super.key,
    required this.label,
    required this.onTap,
    this.ghost = false,
    this.arrow = true,
    this.loading = false,
    this.height = 42,
    this.radius = 10,
    this.textStyle,
    this.outlineColor,
    this.arrowGap = 2,
  });

  final String label;

  /// Null disables it: a disabled solid button keeps its colour and drops to
  /// 50% opacity rather than inventing a grey the design doesn't have.
  final VoidCallback? onTap;
  final bool ghost;
  final bool arrow;
  final bool loading;
  final double height;
  final double radius;
  final TextStyle? textStyle;
  final Color? outlineColor;

  /// Figma spaces the arrow 7px off "Submit ticket" but ~3px off "View ticket".
  final double arrowGap;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final style = textStyle ?? (ghost ? type.buttonGhost : type.button);
    final enabled = onTap != null && !loading;

    return Semantics(
      button: true,
      enabled: enabled,
      label: label,
      child: Opacity(
        opacity: onTap == null ? 0.5 : 1,
        child: GestureDetector(
          onTap: enabled ? onTap : null,
          behavior: HitTestBehavior.opaque,
          child: Container(
            height: height,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: ghost ? null : AppPalette.badgeTeal,
              borderRadius: BorderRadius.circular(radius),
              border: ghost
                  ? Border.all(color: outlineColor ?? AppPalette.ticketHint)
                  : null,
            ),
            child: loading
                ? const SizedBox(
                    height: 18,
                    width: 18,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: AppPalette.white,
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Flexible(child: Text(label, style: style)),
                      if (arrow) ...[
                        SizedBox(width: arrowGap),
                        SvgPicture.asset(
                          'assets/icons/ticket_arrow.svg',
                          height: 15.07,
                          width: 15.07,
                          colorFilter: ColorFilter.mode(
                            style.color ?? AppPalette.white,
                            BlendMode.srcIn,
                          ),
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
