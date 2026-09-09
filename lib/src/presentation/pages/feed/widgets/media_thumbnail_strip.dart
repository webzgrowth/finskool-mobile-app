import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';

/// The row of small preview thumbnails under the main carousel — tapping
/// one jumps the carousel to that item.
class MediaThumbnailStrip extends StatelessWidget {
  const MediaThumbnailStrip({
    super.key,
    required this.media,
    required this.activeIndex,
    required this.onTap,
  });

  final List<PostMediaModel> media;
  final int activeIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: media.length,
        separatorBuilder: (_, _) => const SizedBox(width: AppSpacing.xs),
        itemBuilder: (context, i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: ClipRRect(
              borderRadius: AppRadii.small,
              child: SizedBox(
                width: 64,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    CachedNetworkImage(imageUrl: media[i].imageUrl, fit: BoxFit.cover),
                    // Active thumbnail stays full brightness; the rest
                    // are dimmed with a grey scrim instead of putting a
                    // border on the active one.
                    if (!active)
                      Container(color: Colors.black.withValues(alpha: 0.45)),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
