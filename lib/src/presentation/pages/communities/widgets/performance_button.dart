import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The outlined "Performance" button beside a community's CTA.
///
/// Performance left the bottom bar for the community card (Figma `750:1111`):
/// 124x42, radius 10, a `#108B8B` hairline, the trend arrow then the label.
class PerformanceButton extends StatelessWidget {
  const PerformanceButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  static const double width = 124;

  @override
  Widget build(BuildContext context) {
    final style = context.communityType.cta.copyWith(
      color: AppPalette.badgeTeal,
      letterSpacing: 0,
    );
    return SizedBox(
      height: 42,
      width: width,
      child: Material(
        color: AppPalette.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          side: const BorderSide(color: AppPalette.badgeTeal),
        ),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onPressed,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      'assets/icons/performance_trend.svg',
                      height: 15,
                      width: 15,
                    ),
                    const SizedBox(width: 5),
                    Text('Performance', style: style),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
