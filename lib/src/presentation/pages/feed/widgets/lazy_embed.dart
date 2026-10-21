import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Mounts a video's player while the post is on screen and tears it down
/// when it isn't — the feed autoplay behaviour of every other social app.
///
/// **The mounting is the point, not just the autoplay.** These players are
/// native *platform views* (a WebView). Flutter composites those by inserting
/// the native view and painting overlapping Flutter widgets into overlay
/// layers above it, and in a scrolling list that goes wrong: a video low in
/// the feed painted straight over the bottom navigation bar. The layout was
/// never at fault (the shell's `Scaffold` has no `extendBody`), so padding
/// and clipping can't fix it. Holding at most one or two live views, and
/// none at all for anything offscreen, is what keeps it in check — and it is
/// also the difference between a feed with one WebView and one with ten.
///
/// Hysteresis is deliberate: mount at [_mountAbove], unmount only below
/// [_unmountBelow]. A single threshold would thrash a player in and out at
/// the boundary, and every remount costs a page load.
class LazyEmbed extends StatefulWidget {
  const LazyEmbed({super.key, required this.item, required this.player});

  final PostMediaModel item;

  /// Built only while visible. A builder, not a widget, so the platform view
  /// behind it genuinely does not exist the rest of the time.
  final WidgetBuilder player;

  /// Enough of the post on screen to be worth playing.
  static const double _mountAbove = 0.7;

  /// Mostly gone. Anything between the two keeps its current state.
  static const double _unmountBelow = 0.4;

  @override
  State<LazyEmbed> createState() => _LazyEmbedState();
}

class _LazyEmbedState extends State<LazyEmbed> {
  bool _live = false;

  void _onVisibility(VisibilityInfo info) {
    if (!mounted) return;
    final fraction = info.visibleFraction;
    if (!_live && fraction >= LazyEmbed._mountAbove) {
      setState(() => _live = true);
    } else if (_live && fraction < LazyEmbed._unmountBelow) {
      setState(() => _live = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      // Stable across rebuilds and unique per media item, which is what the
      // detector keys its bookkeeping on.
      key: Key('embed-${widget.item.embedUrl ?? widget.item.imageUrl}'),
      onVisibilityChanged: _onVisibility,
      child: _live ? widget.player(context) : _EmbedPoster(item: widget.item),
    );
  }
}

/// What shows before the player mounts, and again once it scrolls away.
///
/// A YouTube item has the API's real `thumbnailUrl`. An Instagram one has
/// **no poster at all** — the API supplies none and its embed URL is not an
/// image — so rather than the black rectangle that used to sit there, it
/// gets a branded plate that reads as "a post, loading".
class _EmbedPoster extends StatelessWidget {
  const _EmbedPoster({required this.item});

  final PostMediaModel item;

  @override
  Widget build(BuildContext context) {
    final poster = item.posterUrl;
    return Stack(
      fit: StackFit.expand,
      children: [
        if (poster != null)
          CachedNetworkImage(
            imageUrl: poster,
            fit: BoxFit.cover,
            placeholder: (_, _) => const _Plate(),
            errorWidget: (_, _, _) => const _Plate(),
          )
        else
          const _Plate(),
        const Center(
          child: SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(strokeWidth: 2),
          ),
        ),
        if (item.title != null)
          Positioned(
            left: AppSpacing.sm,
            right: AppSpacing.sm,
            bottom: AppSpacing.sm,
            child: Text(
              item.title!,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w600,
                shadows: [Shadow(blurRadius: 6, color: Colors.black87)],
              ),
            ),
          ),
      ],
    );
  }
}

/// Instagram has no artwork to show, so this stands in for it: Figma's light
/// `#F4F4F4` plate. It was a dark gradient, which read as a broken player.
class _Plate extends StatelessWidget {
  const _Plate();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(color: AppPalette.feedMediaPlate);
  }
}
