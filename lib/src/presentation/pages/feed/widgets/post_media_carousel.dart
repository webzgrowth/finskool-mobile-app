import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/comman/media_ratio_cache.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';

import 'embed_player.dart';
import 'lazy_embed.dart';
import 'native_video_player.dart';
import 'youtube_embed_player.dart';
import 'media_thumbnail_strip.dart';

/// Horizontal `PageView` of a post's media items — images (shown whole, at
/// their own aspect ratio) or an inline embedded YouTube/Instagram/native
/// player — with the dot indicator overlaid on the media itself, and a
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

  /// The key a page's resolved ratio is remembered under — its media URL.
  String _keyFor(int page) {
    final item = widget.media[page];
    return item.embedUrl ?? item.imageUrl;
  }

  /// Whole images/videos aren't cropped (`BoxFit.contain`), so the box has to
  /// be the media's own shape or it would letterbox. An **image** or **native
  /// uploaded video** only learns its true ratio once it decodes/initialises,
  /// so it's looked up in the app-wide [MediaRatioCache] first: a card that's
  /// been seen once is the right size from its first frame, even after the
  /// list disposed and rebuilt it — see that class for why this matters (the
  /// feed "juggled" because a rebuilt card restarted at the fallback and then
  /// jumped to its real shape under the user's finger). Only a media item with
  /// neither a server ratio nor a cached one uses the fallback: a square for
  /// an image, 16:9 for a video.
  /// YouTube/Instagram have a fixed ratio up front; their players don't
  /// expose the clip's true shape.
  double _ratioFor(int page) {
    final item = widget.media[page];
    final known = MediaRatioCache.of(_keyFor(page));
    // The backend's measured ratio wins: it is there on the first frame and
    // never changes, so the card is its final size before anything loads. The
    // decoded ratio (cache) covers a post saved before sizes were recorded.
    // Clamped like a decoded one, so a freak upload can't make a tall card.
    final declared = item.ratio?.clamp(0.5, 2.0);
    return switch (item.type) {
      PostMediaType.image => declared ?? known ?? 1.0,
      PostMediaType.nativeVideo => declared ?? known ?? item.aspectRatio,
      _ => item.aspectRatio,
    };
  }

  void _onResolvedRatio(int index, double ratio) {
    if (!ratio.isFinite || ratio <= 0) return;
    // Clamped so one absurdly tall/wide upload can't make a screen-tall card.
    final clamped = ratio.clamp(0.5, 2.0);
    final key = _keyFor(index);
    if (MediaRatioCache.of(key) == clamped) return;
    MediaRatioCache.put(key, clamped);
    setState(() {});
  }

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
    final page = _page.clamp(0, widget.media.length - 1);
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          // No `AnimatedSize`: it animated the card's height over 200ms every
          // time an image/video resolved its real ratio, and inside a
          // scrolling sliver that re-lays-out the list every frame while the
          // finger is moving — the feed "juggled" and fought the drag. A
          // one-off snap when the ratio lands is far less disruptive than a
          // continuous resize under the user's thumb.
          child: ConstrainedBox(
            constraints: const BoxConstraints(),
            child: AspectRatio(
              aspectRatio: _ratioFor(page),
              child: Stack(
                children: [
                  PageView.builder(
                    controller: _controller,
                    itemCount: widget.media.length,
                    onPageChanged: (i) => setState(() => _page = i),
                    itemBuilder: (context, i) => _MediaItem(
                      item: widget.media[i],
                      onRatio: (r) => _onResolvedRatio(i, r),
                    ),
                  ),
                  if (widget.media.length > 1)
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 12.4,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(widget.media.length, (i) {
                          final active = i == _page;
                          return AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            // Figma: a 16.4x6.6 white pill beside 6.4px
                            // `#E0E0E0` dots, 1.5 apart.
                            margin: const EdgeInsets.symmetric(
                              horizontal: 0.75,
                            ),
                            height: 6.5,
                            width: active ? 16.4 : 6.4,
                            decoration: BoxDecoration(
                              color: active
                                  ? AppPalette.white
                                  : AppPalette.feedDot,
                              borderRadius: BorderRadius.circular(3.3),
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
          const SizedBox(height: 10),
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
  const _MediaItem({required this.item, required this.onRatio});

  final PostMediaModel item;

  /// Fired with the media's real width/height ratio once known — for an image
  /// (decoded) or a native video (`video_player` initialised) — so the
  /// carousel can size the card to the whole picture/clip.
  final ValueChanged<double> onRatio;

  @override
  Widget build(BuildContext context) {
    // Players are wrapped in `LazyEmbed`, which shows the poster until the
    // post is on screen. That is deliberate and load-bearing — see its docs:
    // a live platform view in a scrolling list painted over the bottom nav.
    final videoId = item.videoId;
    if (videoId != null) {
      return LazyEmbed(
        item: item,
        player: (_) =>
            YoutubeEmbedPlayer(videoId: videoId, aspectRatio: item.aspectRatio),
      );
    }
    if (item.type == PostMediaType.nativeVideo) {
      return LazyEmbed(
        item: item,
        player: (_) => NativeVideoPlayer(
          url: item.embedUrl ?? item.imageUrl,
          onRatio: onRatio,
        ),
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
        _FeedImage(url: item.imageUrl, onRatio: onRatio),
        if (item.durationLabel != null)
          Positioned(
            right: 12.7,
            top: 11,
            child: Container(
              height: 10.9,
              padding: const EdgeInsets.symmetric(horizontal: 5.4),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Colors.black.withValues(alpha: 0.6),
                borderRadius: BorderRadius.circular(3.1),
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

/// An uploaded picture, shown **whole** — `BoxFit.contain`, not `cover`, so
/// nothing is cropped off. It reports its real aspect ratio via [onRatio]
/// once decoded, which the carousel uses to size the card to the picture;
/// with the box at the picture's own ratio, `contain` fills it exactly, so
/// there's no letterboxing in the common case either.
class _FeedImage extends StatefulWidget {
  const _FeedImage({required this.url, required this.onRatio});

  final String url;
  final ValueChanged<double> onRatio;

  @override
  State<_FeedImage> createState() => _FeedImageState();
}

class _FeedImageState extends State<_FeedImage> {
  late final ImageProvider _provider = CachedNetworkImageProvider(widget.url);
  ImageStream? _stream;
  late final ImageStreamListener _listener = ImageStreamListener(
    (info, _) {
      final image = info.image;
      if (image.height != 0 && mounted) {
        widget.onRatio(image.width / image.height);
      }
    },
    // A failed decode keeps the fallback ratio; `errorBuilder` draws the tile.
    onError: (_, _) {},
  );

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Read the config now (needs `context`), but attach the listener **after**
    // the frame. `CachedNetworkImageProvider`'s completer replays a cached
    // result/error *synchronously* on `addListener`, and that replay reaches
    // the display `Image`'s own `_ImageState` — doing it during this build (a
    // `setState() called during build` crash, which is exactly what fired).
    // Off the frame there is no build in flight, so the replay is harmless.
    final config = createLocalImageConfiguration(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      final stream = _provider.resolve(config);
      if (stream.key != _stream?.key) {
        _stream?.removeListener(_listener);
        _stream = stream..addListener(_listener);
      }
    });
  }

  @override
  void dispose() {
    _stream?.removeListener(_listener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Image(
      image: _provider,
      fit: BoxFit.contain,
      frameBuilder: (context, child, frame, wasSync) =>
          frame == null && !wasSync
          ? ColoredBox(color: cs.surfaceContainer)
          : child,
      errorBuilder: (context, _, _) => ColoredBox(
        color: cs.surfaceContainer,
        child: Icon(Icons.image_not_supported_outlined, color: cs.outline),
      ),
    );
  }
}
