import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The community header card — cover image under a teal scrim, with a
/// white chart disc top-left and the category/name/Active stack bottom-left.
class SubscriptionCommunityCard extends StatelessWidget {
  const SubscriptionCommunityCard({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.subscriptionType;

    return Container(
      height: 125,
      decoration: BoxDecoration(
        color: AppPalette.primary,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (community.coverImageUrl != null)
            CachedNetworkImage(
              imageUrl: community.coverImageUrl!,
              fit: BoxFit.cover,
              placeholder: (_, _) => const SizedBox.shrink(),
              errorWidget: (_, _, _) => const SizedBox.shrink(),
            ),
          // The art runs edge to edge but the copy sits on the left, so the
          // scrim is horizontal — a bottom-up fade would wash out the name
          // while leaving the right side unreadable.
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  AppPalette.primary,
                  AppPalette.primary.withValues(alpha: 0.55),
                ],
              ),
            ),
          ),
          Positioned(
            top: AppSpacing.md,
            left: AppSpacing.md,
            child: Container(
              height: 34,
              width: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: cs.surface,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset(
                'assets/icons/community_chart.svg',
                height: 16,
                width: 16,
                colorFilter: const ColorFilter.mode(
                  AppPalette.primary,
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Positioned(
            left: AppSpacing.md,
            right: AppSpacing.md,
            bottom: AppSpacing.md,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (community.category != null)
                  Text(community.category!, style: type.category),
                const SizedBox(height: 2),
                Text(community.name, style: type.communityName),
                const SizedBox(height: 6),
                _ActivePill(type: type),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivePill extends StatelessWidget {
  const _ActivePill({required this.type});

  final SubscriptionDetailTypography type;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(AppRadii.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 5,
            width: 5,
            decoration: const BoxDecoration(
              color: AppPalette.announcementGreen,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text('Active', style: type.activeStatus),
        ],
      ),
    );
  }
}
