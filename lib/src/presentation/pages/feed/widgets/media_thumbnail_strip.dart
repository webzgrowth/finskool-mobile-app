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
      height: 37.1,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: media.length,
        separatorBuilder: (_, _) => const SizedBox(width: 5.9),
        itemBuilder: (context, i) {
          final active = i == activeIndex;
          return GestureDetector(
            onTap: () => onTap(i),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: SizedBox(
                width: 37.1,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    _Poster(item: media[i]),
                    // Active stays as is; the rest are veiled with white at
                    // 20% (Figma `#FFFFFF33`) rather than darkened.
                    if (!active) Container(color: const Color(0x33FFFFFF)),
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

/// A preview still, or a play glyph on a dark plate when the item has none.
///
/// A `videos` entry carries a real `thumbnailUrl`, so most embeds now show
/// their actual frame here. An embed that came through `imageUrls` has no
/// poster at all — its `imageUrl` is the embed URL, which would 404 as an
/// image — so it falls back rather than rendering a broken tile.
class _Poster extends StatelessWidget {
  const _Poster({required this.item});

  final PostMediaModel item;

  @override
  Widget build(BuildContext context) {
    final poster = item.posterUrl;
    final fallback = ColoredBox(
      color: Colors.black54,
      child: item.isEmbed
          ? const Icon(Icons.play_arrow_rounded, color: Colors.white, size: 20)
          : const SizedBox.shrink(),
    );
    if (poster == null) return fallback;

    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: poster,
          fit: BoxFit.cover,
          placeholder: (_, _) => const ColoredBox(color: Colors.black26),
          errorWidget: (_, _, _) => fallback,
        ),
        if (item.isEmbed)
          const Center(
            child: Icon(
              Icons.play_arrow_rounded,
              color: Colors.white,
              size: 20,
            ),
          ),
      ],
    );
  }
}
