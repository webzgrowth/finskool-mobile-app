import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A community card's header image, with the member-count pill and the
/// circular chart badge that overlaps its bottom-left corner.
///
/// Figma (`750:1117`): 156 tall, radius 20; pill is white-at-10%, 27 high,
/// fully rounded; the badge is a 44px `#153D3A` disc holding a 21x20 chart
/// glyph, sitting half outside the image.
class CommunityCover extends StatelessWidget {
  const CommunityCover({
    super.key,
    required this.imageUrl,
    required this.memberCount,
  });

  final String? imageUrl;
  final int memberCount;

  static const double height = 156;
  static const double badgeSize = 44;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return SizedBox(
      // Room for the badge to hang below the image.
      height: height + badgeSize / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: imageUrl == null
                  ? ColoredBox(color: cs.surfaceContainerHighest)
                  : CachedNetworkImage(
                      imageUrl: imageUrl!,
                      fit: BoxFit.cover,
                      placeholder: (_, _) =>
                          ColoredBox(color: cs.surfaceContainerHighest),
                      errorWidget: (_, _, _) =>
                          ColoredBox(color: cs.surfaceContainerHighest),
                    ),
            ),
          ),
          Positioned(
            top: 13,
            right: 14,
            child: _MemberPill(count: memberCount),
          ),
          Positioned(
            left: AppSpacing.lg,
            top: height - badgeSize / 2,
            child: Container(
              height: badgeSize,
              width: badgeSize,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppPalette.reactionRing,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/community_chart.svg',
                height: 20,
                width: 21,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MemberPill extends StatelessWidget {
  const _MemberPill({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    // Frosted glass, not a flat scrim: the fill is white at 10%, which only
    // reads as the design intends once what's behind it is blurred.
    return ClipRRect(
      borderRadius: BorderRadius.circular(50),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
        child: Container(
          height: 27,
          padding: const EdgeInsets.symmetric(horizontal: 11),
          decoration: BoxDecoration(
            color: AppPalette.white.withValues(alpha: 0.18),
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: AppPalette.white.withValues(alpha: 0.25),
              width: 0.8,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/community_members.svg',
                height: 10,
                width: 12.875,
              ),
              const SizedBox(width: AppSpacing.sm),
              Text('$count Members', style: context.communityType.memberCount),
            ],
          ),
        ),
      ),
    );
  }
}
