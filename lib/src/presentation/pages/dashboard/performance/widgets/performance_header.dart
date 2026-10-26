import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/design_metrics.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma `Header` (`1554:6104`): the teal grid hero, 118 tall on a 44pt status
/// bar, with a 34px translucent back button and the title block at y 60. The
/// status-bar inset is read from `MediaQuery`, never hardcoded; the hero
/// image bleeds behind it.
class PerformanceHeader extends StatelessWidget {
  const PerformanceHeader({super.key, required this.communityName});

  final String communityName;

  static const double _below = 74; // 118 − 44
  static const double _radius = 16;

  /// The header's full height — the list sits under it.
  static double heightOf(BuildContext context) =>
      designTopInset(context) + _below;

  @override
  Widget build(BuildContext context) {
    final inset = designTopInset(context);
    final type = context.performanceType;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: SizedBox(
        height: inset + _below,
        child: Stack(
          children: [
            Positioned.fill(
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(_radius),
                ),
                child: Image.asset(
                  'assets/images/performance_header_bg.png',
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                ),
              ),
            ),
            Positioned(
              left: 16,
              top: inset + 18,
              child: Semantics(
                button: true,
                label: 'Back',
                child: GestureDetector(
                  onTap: () => context.pop(),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    height: 34,
                    width: 34,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: Color(0x2EFFFFFF),
                      shape: BoxShape.circle,
                    ),
                    child: SvgPicture.asset('assets/icons/perf_back.svg'),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 62,
              right: 16,
              top: inset + 16,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Performance', style: type.heroTitle),
                  Text(
                    communityName,
                    style: type.heroSubtitle,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
