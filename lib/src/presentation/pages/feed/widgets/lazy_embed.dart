import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A video's poster frame with a play button, which becomes the real player
/// on tap.
///
/// **This exists for a rendering bug, not for looks.** The players are
/// native *platform views* (a WebView). Flutter composites those by inserting
/// the native view and painting any overlapping Flutter widgets into overlay
/// layers above it — and inside a scrolling list that goes wrong: a video
/// scrolled to the bottom of the feed painted straight over the bottom
/// navigation bar. The layout was never wrong (the shell's `Scaffold` has no
/// `extendBody`), so no amount of padding or clipping fixes it. Not creating
/// the platform view until it is asked for does.
///
/// It is also simply correct for a feed: without this, every video card on
/// screen holds a live WebView, which is heavy on memory and battery.
///
/// The poster is the API's own `thumbnailUrl`, so this is the real frame of
/// the video rather than a grey placeholder.
class LazyEmbed extends StatefulWidget {
  const LazyEmbed({super.key, required this.item, required this.player});

  final PostMediaModel item;

  /// Built only once the viewer taps. A builder, not a widget, so the player
  /// — and the platform view behind it — is never constructed otherwise.
  final WidgetBuilder player;

  @override
  State<LazyEmbed> createState() => _LazyEmbedState();
}

class _LazyEmbedState extends State<LazyEmbed> {
  bool _started = false;

  @override
  Widget build(BuildContext context) {
    if (_started) return widget.player(context);

    final poster = widget.item.posterUrl;
    return GestureDetector(
      onTap: () => setState(() => _started = true),
      child: Stack(
        fit: StackFit.expand,
        children: [
          if (poster != null)
            CachedNetworkImage(
              imageUrl: poster,
              fit: BoxFit.cover,
              placeholder: (_, _) => const ColoredBox(color: Colors.black26),
              errorWidget: (_, _, _) => const ColoredBox(color: Colors.black87),
            )
          else
            const ColoredBox(color: Colors.black87),
          const _PlayBadge(),
          if (widget.item.title != null)
            Positioned(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: AppSpacing.sm,
              child: Text(
                widget.item.title!,
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
      ),
    );
  }
}

class _PlayBadge extends StatelessWidget {
  const _PlayBadge();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: 44,
        width: 44,
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white70, width: 1.5),
        ),
        child: const Icon(Icons.play_arrow_rounded,
            color: Colors.white, size: 28),
      ),
    );
  }
}
