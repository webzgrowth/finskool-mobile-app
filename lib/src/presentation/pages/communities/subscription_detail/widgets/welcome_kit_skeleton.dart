import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Stand-in for the Welcome Kit while it loads — a heading rule and two cards,
/// the same silhouette as the real run so the sheet doesn't jump on arrival.
class WelcomeKitSkeleton extends StatelessWidget {
  const WelcomeKitSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const Shimmer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SkeletonBox(height: 22, width: 120, radius: 6),
          SizedBox(height: 11),
          _Card(height: 150),
          SizedBox(height: 16),
          _Card(height: 230),
        ],
      ),
    );
  }
}

class _Card extends StatelessWidget {
  const _Card({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) =>
      SkeletonBox(height: height, width: double.infinity, radius: AppRadii.md);
}
