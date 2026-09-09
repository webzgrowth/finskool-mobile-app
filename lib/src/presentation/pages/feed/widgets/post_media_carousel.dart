import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'embed_player.dart';
import 'media_thumbnail_strip.dart';

/// Horizontal `PageView` of a post's media items — images (with an
/// optional duration badge) or an inline embedded YouTube/Instagram
/// player — with the dot indicator overlaid on the image itself, and a
/// tappable preview thumbnail strip underneath (per Figma).
class PostMediaCarousel extends StatefulWidget {
  const PostMediaCarousel({super.key, required this.media});

  final List<PostMediaModel> media;

  @override
  State<PostMediaCarousel> createState() => _PostMediaCarouselState();
}

class _PostMediaCarouselState extends State<PostMediaCarousel> {
  final _controller = PageController();
  int _page = 0;

  void _goTo(int index) {
    _controller.animateToPage(
      index,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    if (widget.media.isEmpty) return const SizedBox.shrink();
    return Column(
      children: [
        ClipRRect(
          borderRadius: AppRadii.medium,
          child: AspectRatio(
            aspectRatio: 16 / 9,
            child: Stack(
              children: [
                PageView.builder(
                  controller: _controller,
                  itemCount: widget.media.length,
                  onPageChanged: (i) => setState(() => _page = i),
                  itemBuilder: (context, i) => _MediaItem(item: widget.media[i]),
                ),
                if (widget.media.length > 1)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: AppSpacing.sm,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(widget.media.length, (i) {
                        final active = i == _page;
                        return AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.symmetric(horizontal: 2),
                          height: 6,
                          width: active ? 18 : 6,
                          decoration: BoxDecoration(
                            color: Colors.white
                                .withValues(alpha: active ? 1 : 0.5),
                            borderRadius: BorderRadius.circular(3),
                          ),
                        );
                      }),
                    ),
                  ),
              ],
            ),
          ),
        ),
        if (widget.media.length > 1) ...[
          const SizedBox(height: AppSpacing.sm),
          MediaThumbnailStrip(
            media: widget.media,
            activeIndex: _page,
            onTap: _goTo,
          ),
        ],
      ],
    );
  }
}

class _MediaItem extends StatelessWidget {
  const _MediaItem({required this.item});

  final PostMediaModel item;

  @override
  Widget build(BuildContext context) {
    if (item.type != PostMediaType.image) {
      return EmbedPlayer(embedUrl: item.embedUrl!);
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(imageUrl: item.imageUrl, fit: BoxFit.cover),
        if (item.durationLabel != null)
          Positioned(
            right: AppSpacing.sm,
            top: AppSpacing.sm,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: AppRadii.small,
              ),
              child: Text(
                item.durationLabel!,
                style: const TextStyle(color: Colors.white, fontSize: 11),
              ),
            ),
          ),
      ],
    );
  }
}
