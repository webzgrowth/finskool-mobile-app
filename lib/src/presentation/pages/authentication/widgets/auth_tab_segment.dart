import 'package:flutter/material.dart';

/// One tappable label inside [AuthTabSwitch].
class AuthTabSegment extends StatelessWidget {
  const AuthTabSegment({
    super.key,
    required this.label,
    required this.active,
    required this.style,
    required this.onTap,
  });

  final String label;
  final bool active;
  final TextStyle? style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Center(
          child: AnimatedDefaultTextStyle(
            duration: const Duration(milliseconds: 220),
            style: style!.copyWith(
              color: active ? cs.onSurface : cs.onSurfaceVariant,
            ),
            child: Text(label),
          ),
        ),
      ),
    );
  }
}
