import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/placeholder_images.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A service card's artwork with the round badge hanging off its bottom-left
/// corner — the same geometry as `CommunityCover` (156 tall, r20, 44px disc),
/// minus the member pill: a service has no members.
class ServiceCover extends StatelessWidget {
  const ServiceCover({super.key, required this.imageUrl, required this.id});

  final String? imageUrl;

  /// Picks a stable stand-in when [imageUrl] is null.
  final String id;

  static const double height = 156;
  static const double badgeSize = 44;

  @override
  Widget build(BuildContext context) {
    final plate = Theme.of(context).colorScheme.surfaceContainerHighest;
    return SizedBox(
      height: height + badgeSize / 2,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadii.lg),
            child: SizedBox(
              height: height,
              width: double.infinity,
              child: CachedNetworkImage(
                imageUrl: imageUrl?.isNotEmpty == true
                    ? imageUrl!
                    : communityCoverFallback(id),
                fit: BoxFit.cover,
                placeholder: (_, _) => ColoredBox(color: plate),
                errorWidget: (_, _, _) => ColoredBox(color: plate),
              ),
            ),
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
                'assets/icons/service_disc.svg',
                height: 20,
                width: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
