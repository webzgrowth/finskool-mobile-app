import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'native_video_controls.dart';

/// A genuine uploaded video file — not an embed page — played by a real
/// decoder (`video_player`) rather than a WebView, which was never built to
/// open a raw media URL and is why these posts weren't opening at all. See
/// `PostMediaModel.nativeVideo` / `looksLikeVideoFile`.
///
/// Mounted and disposed by `LazyEmbed` as the post scrolls in and out of
/// view — same lifecycle as the embed players, for the same reason: one
/// post playing at a time, nothing decoding offscreen.
///
/// **Muted autoplay, same rule as `YoutubeEmbedPlayer`**: it starts silent
/// and the viewer turns sound on themselves, via the speaker button this
/// widget draws — `video_player` has no built-in controls at all, embedded
/// or otherwise, so unlike the YouTube path this one was never going to come
/// with a mute button for free. The bottom bar (`NativeVideoControls`) is that
/// button plus play/pause and a seek bar; tapping the picture also toggles
/// play/pause.
class NativeVideoPlayer extends StatefulWidget {
  const NativeVideoPlayer({
    super.key,
    required this.url,
    this.onRatio,
    this.controlsInset = 8,
  });

  /// Space between the control bar and the bottom edge of the video.
  final double controlsInset;

  final String url;

  /// Reports the clip's real width/height once `video_player` initialises, so
  /// the carousel can size the card to the whole video (shown with
  /// `BoxFit.contain`) instead of cropping it into a fixed 16:9 box. Unlike
  /// YouTube/Instagram, an uploaded file's true ratio *is* available here.
  final ValueChanged<double>? onRatio;

  @override
  State<NativeVideoPlayer> createState() => _NativeVideoPlayerState();
}

enum _Status { loading, ready, failed }

class _NativeVideoPlayerState extends State<NativeVideoPlayer> {
  late final VideoPlayerController _controller =
      VideoPlayerController.networkUrl(Uri.parse(widget.url));
  _Status _status = _Status.loading;
  bool _muted = true;

  /// Whether the clip was playing when a seek-drag began, so it resumes after.
  bool _resumeAfterSeek = false;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    try {
      await _controller.initialize();
      // A decode failure can "succeed" into a 0×0 track — treat it as a
      // failure rather than painting an empty (transparent → card-white)
      // surface, which was the whole "white background, no loading" bug.
      if (_controller.value.size.isEmpty) {
        throw StateError('empty video track');
      }
      await _controller.setVolume(0);
      await _controller.setLooping(true);
      await _controller.play();
      final ratio = _controller.value.aspectRatio;
      if (ratio.isFinite && ratio > 0) widget.onRatio?.call(ratio);
      if (mounted) setState(() => _status = _Status.ready);
    } catch (_) {
      if (mounted) setState(() => _status = _Status.failed);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleMute() {
    setState(() => _muted = !_muted);
    _controller.setVolume(_muted ? 0 : 1);
  }

  void _togglePlay() =>
      _controller.value.isPlaying ? _controller.pause() : _controller.play();

  void _seekStart() {
    _resumeAfterSeek = _controller.value.isPlaying;
    _controller.pause();
  }

  Future<void> _seekEnd(Duration to) async {
    await _controller.seekTo(to);
    if (_resumeAfterSeek) await _controller.play();
  }

  @override
  Widget build(BuildContext context) {
    switch (_status) {
      case _Status.loading:
        return const ColoredBox(
          color: Colors.black38,
          child: Center(
            child: SizedBox(
              height: 22,
              width: 22,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            ),
          ),
        );
      case _Status.failed:
        return ColoredBox(
          color: Colors.black38,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.videocam_off_rounded,
                  color: Colors.white70,
                  size: 28,
                ),
                const SizedBox(height: 6),
                Text(
                  "This video can't be played",
                  style: Theme.of(context).textTheme.bodySmall
                      ?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        );
      case _Status.ready:
        return Stack(
          fit: StackFit.expand,
          children: [
            const ColoredBox(color: Colors.black),
            // `contain`, shown **whole**: the carousel sizes the card to this
            // clip's own ratio (reported via `onRatio`), so `contain` fills
            // the box exactly in the common case — no crop, and only a thin
            // black bar on the black plate for a ratio clamped at the extreme.
            // `AspectRatio` is the simplest correct `contain` here, and the
            // `ClipRect` keeps it inside the box during the resize animation.
            GestureDetector(
              onTap: _togglePlay,
              behavior: HitTestBehavior.opaque,
              child: ClipRect(
                child: Center(
                  child: AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 8,
              right: 8,
              bottom: widget.controlsInset,
              child: ValueListenableBuilder<VideoPlayerValue>(
                valueListenable: _controller,
                builder: (_, v, _) => NativeVideoControls(
                  position: v.position,
                  duration: v.duration,
                  playing: v.isPlaying,
                  muted: _muted,
                  onTogglePlay: _togglePlay,
                  onToggleMute: _toggleMute,
                  onSeekStart: _seekStart,
                  onSeekEnd: _seekEnd,
                ),
              ),
            ),
          ],
        );
    }
  }
}
