import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// [ServiceCard]'s silhouette, for the catalog's first load. Shares its outer
/// margin/radius/shadow so nothing jumps in size once real cards replace it;
/// the content inside is a loose approximation, not a Figma-exact trace —
/// a loading placeholder doesn't need pixel parity with the design it's
/// standing in for.
class ServiceCardSkeleton extends StatelessWidget {
  const ServiceCardSkeleton({super.key});

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
                  Align(
                    alignment: Alignment.centerRight,
                    child: SkeletonLine(widthFactor: 0.32, height: 18),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  const SkeletonLine(widthFactor: 0.6, height: 16),
                  const SizedBox(height: AppSpacing.sm),
                  const SkeletonLine(widthFactor: 0.95),
                  const SizedBox(height: 6),
                  const SkeletonLine(widthFactor: 0.7),
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
