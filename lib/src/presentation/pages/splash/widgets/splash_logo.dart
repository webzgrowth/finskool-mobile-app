import 'package:flutter/material.dart';

/// The logo mark, with a soft breathing glow behind it and a one-shot
/// diagonal light-sweep across it once it's settled — the glossy "catching
/// the light" moment that makes an otherwise-static badge feel alive.
class SplashLogo extends StatelessWidget {
  const SplashLogo({super.key, required this.glow, required this.sweep});

  /// 0–1, loops: drives the glow's gentle breathe.
  final Animation<double> glow;

  /// 0–1, plays once near the end of the entrance: drives the sweep.
  final Animation<double> sweep;

  static const double _size = 96;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([glow, sweep]),
      builder: (context, _) {
        // 0→1→0 over the glow's cycle — a breathe, not a one-way fade.
        final breathe = (glow.value < 0.5 ? glow.value : 1 - glow.value) * 2;
        return Container(
          height: _size + 40,
          width: _size + 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                Colors.white.withValues(alpha: 0.22 + 0.1 * breathe),
                Colors.white.withValues(alpha: 0),
              ],
            ),
          ),
          child: ShaderMask(
            blendMode: BlendMode.srcATop,
            shaderCallback: (bounds) => LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: 0),
                Colors.white.withValues(alpha: 0.85),
                Colors.white.withValues(alpha: 0),
              ],
              // Transparent either side of the sweep, opaque-white at its
              // centre, slid from fully off-frame to fully past it as
              // [sweep] runs — the `BlendMode.srcATop` only lightens the
              // logo where this gradient is itself opaque.
              stops: const [0.35, 0.5, 0.65],
              transform: _SweepTransform(sweep.value),
            ).createShader(bounds),
            child: Container(
              height: _size,
              width: _size,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset('assets/images/logo.png', fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }
}

class _SweepTransform extends GradientTransform {
  const _SweepTransform(this.t);

  final double t;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dx = (t * 2 - 1) * bounds.width * 1.6;
    return Matrix4.translationValues(dx, 0, 0);
  }
}
