import 'package:flutter/material.dart';

/// Fades a child in while it rises a few pixels, once, when it first builds.
///
/// [index] staggers siblings: each waits `index * step` before starting, so a
/// column of cards settles top to bottom instead of popping in together. It is
/// a `TweenAnimationBuilder` rather than a controller on purpose — nothing
/// else needs to drive it, and it disposes itself.
///
/// Respects the OS "reduce motion" setting: with animations disabled the child
/// is simply shown.
class FadeSlideIn extends StatelessWidget {
  const FadeSlideIn({
    super.key,
    required this.child,
    this.index = 0,
    this.step = const Duration(milliseconds: 60),
    this.duration = const Duration(milliseconds: 420),
    this.dy = 16,
  });

  final Widget child;
  final int index;
  final Duration step;
  final Duration duration;

  /// How far below its resting place the child starts, in px.
  final double dy;

  @override
  Widget build(BuildContext context) {
    if (MediaQuery.disableAnimationsOf(context)) return child;
    final delay = step * index;
    final total = duration + delay;
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: total,
      curve: Interval(
        delay.inMilliseconds / total.inMilliseconds,
        1,
        curve: Curves.easeOutCubic,
      ),
      child: child,
      builder: (context, t, child) => Opacity(
        opacity: t,
        child: Transform.translate(
          offset: Offset(0, (1 - t) * dy),
          child: child,
        ),
      ),
    );
  }
}
