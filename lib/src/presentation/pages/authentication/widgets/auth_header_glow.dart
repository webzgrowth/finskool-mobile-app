import 'package:flutter/material.dart';

/// Soft radial glow decorating the top-right of [AuthHeader].
class AuthHeaderGlow extends StatelessWidget {
  const AuthHeaderGlow({super.key, required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 220,
      width: 220,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(colors: [color, color.withValues(alpha: 0)]),
      ),
    );
  }
}
