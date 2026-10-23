import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One shimmer sweep shared by every [SkeletonBox] underneath it, so a
/// screen's whole loading state (several cards' worth of boxes) sweeps in
/// sync — a handful of boxes each running their own independent animation
/// reads as noisy flicker, not a premium loading state.
///
/// Wrap a screen's skeleton list in exactly one of these, near the root; the
/// boxes find it via [of] and fall back to a static (unanimated) fill if none
/// is found, so a `SkeletonBox` is never wrong to use on its own.
class Shimmer extends StatefulWidget {
  const Shimmer({super.key, required this.child});

  final Widget child;

  static _ShimmerState? of(BuildContext context) =>
      context.findAncestorStateOfType<_ShimmerState>();

  @override
  State<Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<Shimmer> with SingleTickerProviderStateMixin {
  late final AnimationController controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1400),
  )..repeat();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

/// One rounded placeholder block — a line of text, an avatar, a whole card's
/// silhouette. Flat grey outside a [Shimmer] (e.g. a widget test with no
/// shimmer ancestor); a soft diagonal highlight sweeping across it inside one.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({
    super.key,
    this.width,
    this.height,
    this.radius = 6,
    this.shape = BoxShape.rectangle,
  });

  /// A circular box (an avatar placeholder) — [radius] is ignored, since the
  /// shape itself already has no corners to round.
  const SkeletonBox.circle({super.key, required double size})
    : width = size,
      height = size,
      radius = 0,
      shape = BoxShape.circle;

  final double? width;
  final double? height;
  final double radius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final base = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppPalette.skeletonBase,
        shape: shape,
        borderRadius: shape == BoxShape.rectangle
            ? BorderRadius.circular(radius)
            : null,
      ),
    );
    final shimmer = Shimmer.of(context);
    if (shimmer == null) return base;

    return AnimatedBuilder(
      animation: shimmer.controller,
      child: base,
      builder: (context, child) {
        // Sweeps from fully off the left edge to fully off the right, so the
        // highlight both enters and exits cleanly rather than popping in.
        final t = shimmer.controller.value;
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) => LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: const [
              AppPalette.skeletonBase,
              AppPalette.skeletonHighlight,
              AppPalette.skeletonBase,
            ],
            stops: const [0.35, 0.5, 0.65],
            transform: _SweepTransform(t),
          ).createShader(bounds),
          child: child,
        );
      },
    );
  }
}

/// Slides the gradient's own bounds from `-extent` to `+extent` relative to
/// the shader's box, i.e. from just off its left edge to just off its right.
class _SweepTransform extends GradientTransform {
  const _SweepTransform(this.t);

  final double t;

  @override
  Matrix4? transform(Rect bounds, {TextDirection? textDirection}) {
    final dx = (t * 2 - 1) * bounds.width * 1.6;
    return Matrix4.translationValues(dx, 0, 0);
  }
}

/// A single placeholder text line — rounded, a fixed height, and a width
/// expressed as a fraction of the row so it reads as "roughly this many
/// characters" without needing real copy to measure against.
class SkeletonLine extends StatelessWidget {
  const SkeletonLine({super.key, this.widthFactor = 1, this.height = 10});

  final double widthFactor;
  final double height;

  @override
  Widget build(BuildContext context) => FractionallySizedBox(
    alignment: Alignment.centerLeft,
    widthFactor: widthFactor,
    child: SkeletonBox(height: height, radius: height / 2),
  );
}
