import 'package:flutter/material.dart';

/// An [IndexedStack] whose newly shown child fades in while rising a few px.
///
/// Every child stays mounted, as with a plain `IndexedStack`, so a tab keeps
/// its scroll position and state. To make that true under animation, **each
/// child is wrapped in the same widgets whether or not it is active** — only
/// the animation fed to them changes. Swapping a wrapper in and out for the
/// active child would change its element type and throw its state away.
class AnimatedIndexedStack extends StatefulWidget {
  const AnimatedIndexedStack({
    super.key,
    required this.index,
    required this.children,
    this.duration = const Duration(milliseconds: 260),
    this.dy = 0.012,
  });

  final int index;
  final List<Widget> children;
  final Duration duration;

  /// Rise distance as a fraction of the child's height.
  final double dy;

  @override
  State<AnimatedIndexedStack> createState() => _AnimatedIndexedStackState();
}

class _AnimatedIndexedStackState extends State<AnimatedIndexedStack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: widget.duration,
    value: 1,
  );
  late final Animation<double> _curve = CurvedAnimation(
    parent: _controller,
    curve: Curves.easeOutCubic,
  );

  @override
  void didUpdateWidget(AnimatedIndexedStack old) {
    super.didUpdateWidget(old);
    if (old.index != widget.index) _controller.forward(from: 0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const still = AlwaysStoppedAnimation<double>(1);
    final rise = Tween(
      begin: Offset(0, widget.dy),
      end: Offset.zero,
    ).animate(_curve);
    return IndexedStack(
      index: widget.index,
      children: [
        for (var i = 0; i < widget.children.length; i++)
          FadeTransition(
            opacity: i == widget.index ? _curve : still,
            child: SlideTransition(
              position: i == widget.index
                  ? rise
                  : const AlwaysStoppedAnimation(Offset.zero),
              child: widget.children[i],
            ),
          ),
      ],
    );
  }
}
