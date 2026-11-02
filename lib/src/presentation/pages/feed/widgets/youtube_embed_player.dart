import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

/// YouTube playback inside the feed card, via `youtube_player_flutter`.
///
/// Takes the **video id**, not a URL: the API's `videos[].externalId` is
/// exactly what the controller wants, so nothing has to parse a watch link.
///
/// Mounted and disposed by `LazyEmbed` as the post scrolls in and out of
/// view, which is what makes [autoPlay] safe here.
///
/// This replaced a hand-rolled WebView iframe. That worked, but only after
/// serving our own HTML document under a matching `baseUrl` — a bare
/// `loadRequest` on an embed URL has no origin and YouTube answers with
/// "Video player configuration error / Error 153". The package owns that
/// problem now, and brings real controls, scrubbing and fullscreen with it.
/// `EmbedPlayer` is still the renderer for Instagram and anything else.
class YoutubeEmbedPlayer extends StatefulWidget {
  const YoutubeEmbedPlayer({
    super.key,
    required this.videoId,
    required this.aspectRatio,
  });

  final String videoId;

  /// Must match the box the carousel actually gives this widget (332:171,
  /// via `PostMediaModel.aspectRatio` — **not** a bare 16:9). The player
  /// package sizes its video surface from this value on the assumption it
  /// owns the whole box; a mismatch doesn't letterbox, it overflows the
  /// bottom of a box that's already fixed by the carousel's own
  /// `AspectRatio` ancestor — which a hardcoded 16/9 here did, every time.
  final double aspectRatio;

  @override
  State<YoutubeEmbedPlayer> createState() => _YoutubeEmbedPlayerState();
}

class _YoutubeEmbedPlayerState extends State<YoutubeEmbedPlayer> {
  late YoutubePlayerController _controller = _build();

  // `youtube_player_flutter` v10's own controls overlay has no volume
  // control at all — not a button we failed to wire up, there's genuinely
  // none in the package (checked its `ControlsOverlay`/`BottomBar`/
  // `PlaybackControls` source: play/pause, skip, fullscreen, a seek bar, no
  // mute). `YoutubePlayerParams.showControls` is also silently ignored on
  // mobile — the package always hides YouTube's own native controls in
  // favour of its own — so there was never a route to sound at all. This
  // button, driven straight off the controller's own `mute()`/`unMute()`,
  // is the fix.
  bool _muted = true;

  YoutubePlayerController _build({bool mute = true, double? start}) =>
      YoutubePlayerController.fromVideoId(
        videoId: widget.videoId,
        startSeconds: start,
        // Autoplays because `LazyEmbed` only builds this widget once the post
        // is actually on screen — it is never constructed for a card the
        // viewer can't see, so this can't start a video off in the distance.
        autoPlay: true,
        params: YoutubePlayerParams(
          // **Muted, and it has to be.** Webviews refuse unmuted autoplay, and
          // the refusal is silent, so it would read as a broken player. Sound
          // is then a deliberate tap on `_MuteButton` below.
          mute: mute,
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
    _muted = true;
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  /// Mute / unmute. Unmuting is the delicate half: the iframe's `unMute()` is
  /// run from Flutter, not from a tap *inside* the web page, and a WebView may
  /// treat that as "no user gesture" and quietly leave the video silent — which
  /// read as "there is no audio". So after asking, it **checks** (`isMuted`) and,
  /// if the player refused, rebuilds the player unmuted at the same second.
  /// Both platforms are configured to allow unmuted playback without a tap, so
  /// a player *created* unmuted does start with sound.
  Future<void> _toggleMute() async {
    if (!_muted) {
      setState(() => _muted = true);
      await _controller.mute();
      return;
    }
    setState(() => _muted = false);
    final controller = _controller;
    await controller.unMute();
    await controller.setVolume(100);
    await Future<void>.delayed(const Duration(milliseconds: 350));
    if (!mounted || controller != _controller) return;
    if (await controller.isMuted) await _reloadUnmuted();
  }

  Future<void> _reloadUnmuted() async {
    final at = await _controller.currentTime;
    if (!mounted) return;
    final old = _controller;
    setState(() => _controller = _build(mute: false, start: at));
    old.close();
  }

  @override
  Widget build(BuildContext context) {
    // The real overflow fix is the **ratio** (`widget.aspectRatio` is now
    // 16:9, not the 332:171 that squeezed the package's controls `Column`
    // ~3px too tall for its box — see `PostMediaModel.aspectRatio`). `ClipRect`
    // stays as cheap insurance: it clips any sub-pixel paint from a mid-swipe
    // `AnimatedSize` frame, though it can't suppress a Flex *assertion*, which
    // is why it alone never fixed this.
    return ClipRect(
      child: Stack(
        fit: StackFit.expand,
        children: [
          YoutubePlayer(
            controller: _controller,
            aspectRatio: widget.aspectRatio,
            // Default is true: a vertical drag on the player toggles
            // fullscreen, which swallows the very gesture the feed needs to
            // scroll past a YouTube card — "it won't scroll over the video".
            // Fullscreen is still one tap on the player's own button.
            enableFullScreenOnVerticalDrag: false,
          ),
          Positioned(
            right: 8,
            bottom: 8,
            child: GestureDetector(
              onTap: _toggleMute,
              behavior: HitTestBehavior.opaque,
              child: Container(
                height: 28,
                width: 28,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.45),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _muted ? Icons.volume_off_rounded : Icons.volume_up_rounded,
                  color: Colors.white,
                  size: 16,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
