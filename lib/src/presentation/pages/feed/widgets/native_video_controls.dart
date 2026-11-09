import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "1:05" / "12:09" — minutes without padding, seconds with.
String formatVideoTime(Duration d) {
  final total = d.inSeconds < 0 ? 0 : d.inSeconds;
  final m = total ~/ 60;
  final s = (total % 60).toString().padLeft(2, '0');
  return '$m:$s';
}

/// The control bar along the bottom of `NativeVideoPlayer`: play/pause, the
/// time, a draggable seek bar, the length, and the speaker.
///
/// `video_player` ships no controls at all, so these are drawn here. It takes
/// plain values and callbacks, not the controller, so it can be tested without
/// a platform video.
///
/// While the thumb is dragged the bar shows the dragged position and **seeks
/// once, on release**: seeking on every tick makes the decoder thrash and the
/// picture stutter. [onSeekStart] lets the player pause for the drag and resume
/// after it. The `Slider` is a child of the carousel's `PageView`, and being
/// the deeper horizontal-drag recognizer it wins the gesture arena, so
/// scrubbing does not turn the page.
class NativeVideoControls extends StatefulWidget {
  const NativeVideoControls({
    super.key,
    required this.position,
    required this.duration,
    required this.playing,
    required this.muted,
    required this.onTogglePlay,
    required this.onToggleMute,
    required this.onSeekStart,
    required this.onSeekEnd,
  });

  final Duration position;
  final Duration duration;
  final bool playing;
  final bool muted;
  final VoidCallback onTogglePlay;
  final VoidCallback onToggleMute;
  final VoidCallback onSeekStart;
  final ValueChanged<Duration> onSeekEnd;

  @override
  State<NativeVideoControls> createState() => _NativeVideoControlsState();
}

class _NativeVideoControlsState extends State<NativeVideoControls> {
  /// 0..1 while the thumb is held; null otherwise (follow playback).
  double? _drag;

  double get _fraction {
    final total = widget.duration.inMilliseconds;
    if (total <= 0) return 0;
    return (widget.position.inMilliseconds / total).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    final fraction = _drag ?? _fraction;
    final shown = _drag == null
        ? widget.position
        : Duration(
            milliseconds: (widget.duration.inMilliseconds * _drag!).round(),
          );
    final label = Theme.of(context).textTheme.labelSmall
        ?.copyWith(color: AppPalette.white, fontSize: 10);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black.withValues(alpha: 0.55),
      ),
      child: SizedBox(
        height: 36,
        child: Row(
          children: [
            _IconTap(
              semantics: widget.playing ? 'Pause' : 'Play',
              icon: widget.playing
                  ? Icons.pause_rounded
                  : Icons.play_arrow_rounded,
              onTap: widget.onTogglePlay,
            ),
            Text(formatVideoTime(shown), style: label),
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 3,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 6,
                  ),
                  overlayShape: SliderComponentShape.noOverlay,
                  activeTrackColor: AppPalette.white,
                  inactiveTrackColor: AppPalette.white.withValues(alpha: 0.3),
                  thumbColor: AppPalette.white,
                ),
                child: Slider(
                  value: fraction,
                  onChangeStart: (_) {
                    widget.onSeekStart();
                    setState(() => _drag = fraction);
                  },
                  onChanged: (v) => setState(() => _drag = v),
                  onChangeEnd: (v) {
                    widget.onSeekEnd(
                      Duration(
                        milliseconds: (widget.duration.inMilliseconds * v)
                            .round(),
                      ),
                    );
                    setState(() => _drag = null);
                  },
                ),
              ),
            ),
            Text(formatVideoTime(widget.duration), style: label),
            _IconTap(
              semantics: widget.muted ? 'Unmute' : 'Mute',
              icon: widget.muted
                  ? Icons.volume_off_rounded
                  : Icons.volume_up_rounded,
              onTap: widget.onToggleMute,
            ),
          ],
        ),
      ),
    );
  }
}

class _IconTap extends StatelessWidget {
  const _IconTap({
    required this.semantics,
    required this.icon,
    required this.onTap,
  });

  final String semantics;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label: semantics,
    child: GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 36,
        height: 36,
        child: Icon(icon, color: AppPalette.white, size: 20),
      ),
    ),
  );
}
