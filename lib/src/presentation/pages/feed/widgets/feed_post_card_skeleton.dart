import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// [FeedPostCard]'s silhouette for the feed's first load — same outer
/// chrome, an approximate content shape inside (see `ServiceCardSkeleton`
/// for why that's fine for a loading placeholder).
class FeedPostCardSkeleton extends StatelessWidget {
  const FeedPostCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
      padding: const EdgeInsets.fromLTRB(17, 13, 15, 16),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPalette.feedBorder, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const SkeletonBox.circle(size: 35),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    SkeletonLine(widthFactor: 0.4, height: 12),
                    SizedBox(height: 6),
                    SkeletonLine(widthFactor: 0.25, height: 10),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const SkeletonLine(widthFactor: 0.55, height: 14),
          const SizedBox(height: 8),
          const SkeletonLine(widthFactor: 0.95),
          const SizedBox(height: 6),
          const SkeletonLine(widthFactor: 0.8),
          const SizedBox(height: 14),
          AspectRatio(
            aspectRatio: 332 / 171,
            child: SkeletonBox(width: double.infinity, radius: AppRadii.md),
          ),
          const SizedBox(height: 13),
          const Divider(height: 1, thickness: 1, color: AppPalette.feedRule),
          const SizedBox(height: 12),
          Row(
            children: [
              const SkeletonBox.circle(size: 24),
              const SizedBox(width: AppSpacing.sm),
              SkeletonBox(height: 12, width: 40, radius: 6),
              const Spacer(),
              SkeletonBox(height: 12, width: 70, radius: 6),
            ],
          ),
        ],
      ),
    );
  }
}
