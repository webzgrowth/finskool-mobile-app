import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

/// The shared "success" checkmark animation — replaces every static
/// success illustration in the app (password reset, signup, community
/// purchase) with one Lottie file (`assets/json/Success.json`).
///
/// The file is self-contained: it already draws its own opaque white
/// backdrop plus a teal ring and an animated checkmark stroke, so it
/// replaces a screen's manually-drawn ring/circle wrapper entirely rather
/// than sitting inside one — every call site that used one before this
/// had its background already at `colorScheme.surface` (white), so there's
/// no seam where the Lottie's own white canvas meets the screen.
class SuccessAnimation extends StatelessWidget {
  const SuccessAnimation({super.key, this.size = 220});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Lottie.asset(
      'assets/json/Success.json',
      height: size,
      width: size,
      repeat: false,
    );
  }
}
