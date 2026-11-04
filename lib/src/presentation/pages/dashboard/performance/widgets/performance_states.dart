import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';

/// The board's silhouette for the first load: the two summary cards and a few
/// trade rows. Approximate rather than pixel-exact, like the other skeletons.
class PerformanceSkeleton extends StatelessWidget {
  const PerformanceSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SkeletonBox(height: 190, width: double.infinity, radius: 20),
        const SizedBox(height: 14),
        const SkeletonBox(height: 120, width: double.infinity, radius: 20),
        const SizedBox(height: 14),
        PerfCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              for (var i = 0; i < 4; i++)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 10),
                  child: SkeletonBox(
                    height: 44,
                    width: double.infinity,
                    radius: 12,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}

/// A centred message with an optional action: a failed load, a board that
/// doesn't exist, an empty list.
class PerformanceMessage extends StatelessWidget {
  const PerformanceMessage({
    super.key,
    required this.title,
    required this.body,
    this.actionLabel,
    this.onAction,
  });

  final String title;
  final String body;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(title, style: type.listTitle, textAlign: TextAlign.center),
          const SizedBox(height: 8),
          Text(body, style: type.note, textAlign: TextAlign.center),
          if (actionLabel != null) ...[
            const SizedBox(height: 12),
            TextButton(onPressed: onAction, child: Text(actionLabel!)),
          ],
        ],
      ),
    );
  }
}
