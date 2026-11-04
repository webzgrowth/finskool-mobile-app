import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Investor / Long Term / US Investment. Only an `investor` board has more than
/// one segment, so the screen draws this only then.
class SegmentTabs extends StatelessWidget {
  const SegmentTabs({
    super.key,
    required this.segments,
    required this.selected,
    required this.onSelected,
  });

  final List<PerformanceSegment> segments;
  final PerformanceSegment? selected;
  final ValueChanged<PerformanceSegment> onSelected;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Row(
      children: [
        for (final segment in segments)
          Expanded(
            child: Semantics(
              button: true,
              selected: segment == selected,
              child: GestureDetector(
                onTap: () => onSelected(segment),
                behavior: HitTestBehavior.opaque,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: segment == selected
                        ? AppPalette.badgeTeal
                        : AppPalette.white,
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppPalette.perfBorder),
                  ),
                  child: Text(
                    segment.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: type.chip.copyWith(
                      color: segment == selected
                          ? AppPalette.white
                          : AppPalette.perfLabel,
                    ),
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
