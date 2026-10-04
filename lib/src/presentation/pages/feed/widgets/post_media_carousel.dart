import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';

import 'embed_player.dart';
import 'lazy_embed.dart';
import 'youtube_embed_player.dart';
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
          // Follows the item on screen, so a portrait Instagram embed isn't
          // squeezed into the 16:9 a video wants. Animated because a mixed
          // carousel would otherwise snap height mid-swipe.
          child: AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeOut,
            child: AspectRatio(
              aspectRatio: widget
                  .media[_page.clamp(0, widget.media.length - 1)]
                  .aspectRatio,
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: widget.media.length,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (context, i) =>
                        _MediaItem(item: widget.media[i]),
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
                              color: Colors.white.withValues(
                                alpha: active ? 1 : 0.5,
                              ),
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
    // Both players are wrapped in `LazyEmbed`, which shows the poster frame
    // until tapped. That is deliberate and load-bearing — see its docs: a
    // live platform view in a scrolling list painted over the bottom nav bar.
    //
    // YouTube gets the real player — controls, scrubbing, fullscreen — keyed
    // straight off the API's `externalId`. Everything else (Instagram, and
    // any `kind` added server-side later) falls through to the WebView
    // iframe, which is still the only way to render those inline.
    final videoId = item.videoId;
    if (videoId != null) {
      return LazyEmbed(
        item: item,
        player: (_) => YoutubeEmbedPlayer(videoId: videoId),
      );
    }
    if (item.isEmbed) {
      // `imageUrl` is the fallback rather than a bang: a `videos` entry
      // always supplies `embedUrl`, but an embed sniffed out of `imageUrls`
      // only has the one URL, and the mock datasource's JSON may omit it.
      return LazyEmbed(
        item: item,
        player: (_) => EmbedPlayer(embedUrl: item.embedUrl ?? item.imageUrl),
      );
    }
    return Stack(
      fit: StackFit.expand,
      children: [
        CachedNetworkImage(
          imageUrl: item.imageUrl,
          fit: BoxFit.cover,
          // Both states are drawn rather than left to the default, which is
          // nothing at all — a post whose image 404s used to render as an
          // empty 16:9 hole with no hint that media was even there.
          placeholder: (context, _) =>
              ColoredBox(color: Theme.of(context).colorScheme.surfaceContainer),
          errorWidget: (context, _, _) => ColoredBox(
            color: Theme.of(context).colorScheme.surfaceContainer,
            child: Icon(
              Icons.image_not_supported_outlined,
              color: Theme.of(context).colorScheme.outline,
            ),
          ),
        ),
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
                // Figma: Inter 500 · 8.5 · #FFFFFF
                style: context.feedType.durationBadge,
              ),
            ),
          ),
      ],
    );
  }
}
