import 'package:flutter/material.dart';

/// One expanding, fading ring — a "radar ping" reading outward from the
/// logo. [SplashRipples] lays three of these at staggered phases so a new
/// one starts roughly every third of [pulse]'s cycle, which is what makes
/// it read as a continuous pulse rather than three rings ticking in sync.
class SplashRipple extends StatelessWidget {
  const SplashRipple({super.key, required this.pulse, required this.phase});

  final Animation<double> pulse;

  /// 0–1, this ring's offset into the shared cycle.
  final double phase;

  static const double _minSize = 110;
  static const double _maxSize = 230;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: pulse,
      builder: (context, _) {
        final t = (pulse.value + phase) % 1.0;
        final size = _minSize + (_maxSize - _minSize) * t;
        // Fades in quickly, then back out — never pops in at full strength,
        // and is fully gone by the time it reaches its largest size.
        final opacity = (t < 0.15 ? t / 0.15 : 1 - (t - 0.15) / 0.85) * 0.45;
        return Container(
          height: size,
          width: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.white.withValues(alpha: opacity.clamp(0, 1)),
              width: 1.4,
            ),
          ),
        );
      },
    );
  }
}

/// Three [SplashRipple]s at even phase offsets, stacked behind the logo.
class SplashRipples extends StatelessWidget {
  const SplashRipples({super.key, required this.pulse});

  final Animation<double> pulse;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        for (var i = 0; i < 3; i++) SplashRipple(pulse: pulse, phase: i / 3),
      ],
    );
  }
}
