import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/placeholder_images.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The community header card: 130 tall, r10, the cover art running under a
/// scrim that is solid `#108B8B` on the left (where the copy sits) and clears
/// to the art on the right. A 36px white disc with the chart glyph top-left,
/// then category / name / the "Active" pill stacked bottom-left.
class SubscriptionCommunityCard extends StatelessWidget {
  const SubscriptionCommunityCard({super.key, required this.community});

  final CommunityModel community;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Container(
      height: 130,
      decoration: BoxDecoration(
        color: AppPalette.badgeTeal,
        borderRadius: BorderRadius.circular(10),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // Falls back to a stand-in cover like the catalog card does — the
          // API supplies no `coverImageUrl` for most communities yet.
          CachedNetworkImage(
            imageUrl: community.coverImageUrl?.isNotEmpty == true
                ? community.coverImageUrl!
                : communityCoverFallback(community.id),
            fit: BoxFit.cover,
            placeholder: (_, _) => const SizedBox.shrink(),
            errorWidget: (_, _, _) => const SizedBox.shrink(),
          ),
          // The copy is on the left, so the scrim is horizontal: solid teal
          // under the text, clearing to the art — a bottom-up fade would wash
          // out the name and leave the right side unreadable.
          const DecoratedBox(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppPalette.badgeTeal,
                  AppPalette.badgeTeal,
                  Color(0x00108B8B),
                ],
                stops: [0, 0.42, 1],
              ),
            ),
          ),
          Positioned(
            top: 10,
            left: 17,
            child: Container(
              height: 36,
              width: 36,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppPalette.white,
                shape: BoxShape.circle,
              ),
              child: SvgPicture.asset('assets/icons/sub_chart.svg'),
            ),
          ),
          Positioned(
            left: 17,
            bottom: 18,
            right: 17,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (community.category != null)
                  Text(community.category!, style: type.category),
                const SizedBox(height: 3),
                Text(community.name, style: type.communityName),
                const SizedBox(height: 4.5),
                const _ActivePill(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActivePill extends StatelessWidget {
  const _ActivePill();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 16,
      padding: const EdgeInsets.symmetric(horizontal: 8.4),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(40),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 4,
            width: 4,
            decoration: const BoxDecoration(
              color: AppPalette.profileRenew,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 3.2),
          Text('Active', style: context.subscriptionType.activeStatus),
        ],
      ),
    );
  }
}
