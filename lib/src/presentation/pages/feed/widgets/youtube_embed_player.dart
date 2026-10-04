import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// YouTube playback inside the feed card, via `youtube_player_flutter`.
///
/// Takes the **video id**, not a URL: the API's `videos[].externalId` is
/// exactly what the controller wants, so nothing has to parse a watch link.
///
/// This replaced a hand-rolled WebView iframe. That worked, but only after
/// serving our own HTML document under a matching `baseUrl` — a bare
/// `loadRequest` on an embed URL has no origin and YouTube answers with
/// "Video player configuration error / Error 153". The package owns that
/// problem now, and brings real controls, scrubbing and fullscreen with it.
/// `EmbedPlayer` is still the renderer for Instagram and anything else.
class YoutubeEmbedPlayer extends StatefulWidget {
  const YoutubeEmbedPlayer({super.key, required this.videoId});

  final String videoId;

  @override
  State<YoutubeEmbedPlayer> createState() => _YoutubeEmbedPlayerState();
}

class _YoutubeEmbedPlayerState extends State<YoutubeEmbedPlayer> {
  late YoutubePlayerController _controller = _build();

  YoutubePlayerController _build() => YoutubePlayerController.fromVideoId(
        videoId: widget.videoId,
        // Never autoplay: several cards are on screen at once and the feed
        // must not start making noise on its own.
        autoPlay: false,
        params: const YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
          // Keeps playback in the card instead of handing iOS the fullscreen
          // system player on the first tap.
          playsInline: true,
          // youtube-nocookie.com, which is also what the backend's `embedUrl`
          // uses — no tracking cookie until the viewer actually plays.
          privacyEnhancedMode: true,
          strictRelatedVideos: true,
          enableCaption: false,
        ),
      );

  /// The carousel reuses one element per page slot, so swiping can hand this
  /// state a different video. Without this the first video keeps playing
  /// under the second one's card.
  @override
  void didUpdateWidget(YoutubeEmbedPlayer old) {
    super.didUpdateWidget(old);
    if (old.videoId == widget.videoId) return;
    _controller.close();
    _controller = _build();
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayer(
      controller: _controller,
      // The carousel already sizes the box; this keeps the surface filling it
      // rather than letterboxing inside its own 16:9.
      aspectRatio: 16 / 9,
    );
  }
}
