import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// [CommunityCard]'s silhouette for the catalog's first load — see
/// `ServiceCardSkeleton` for why this is approximate rather than Figma-exact.
class CommunityCardSkeleton extends StatelessWidget {
  const CommunityCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.gradients.feedCard,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SkeletonBox(
              height: 156,
              width: double.infinity,
              radius: AppRadii.lg,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
                AppSpacing.md,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SkeletonLine(widthFactor: 0.3, height: 12),
                  const SizedBox(height: AppSpacing.xs),
                  const SkeletonLine(widthFactor: 0.55, height: 16),
                  const SizedBox(height: AppSpacing.sm),
                  const SkeletonLine(widthFactor: 0.9),
                  const SizedBox(height: 6),
                  const SkeletonLine(widthFactor: 0.65),
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      SkeletonBox(height: 24, width: 64, radius: AppRadii.pill),
                      const SizedBox(width: 7),
                      SkeletonBox(height: 24, width: 54, radius: AppRadii.pill),
                      const SizedBox(width: 7),
                      SkeletonBox(height: 24, width: 70, radius: AppRadii.pill),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const SkeletonBox(
                    height: 42,
                    width: double.infinity,
                    radius: 10,
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
