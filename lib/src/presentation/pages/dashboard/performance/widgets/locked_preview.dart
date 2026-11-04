import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The blurred trade list behind the unlock card (Figma `Blurred list`, a
/// 7px layer blur). Drawn as neutral row shapes rather than invented stock
/// names: the blur makes the text unreadable anyway, and a free member's
/// screen should never imply trades the server didn't send.
class LockedPreview extends StatelessWidget {
  const LockedPreview({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
      child: ImageFiltered(
        // Figma's blur radius is twice Flutter's sigma.
        imageFilter: ImageFilter.blur(sigmaX: 3.5, sigmaY: 3.5),
        child: Container(
          color: AppPalette.white,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                for (var i = 0; i < 5; i++) ...[
                  if (i > 0)
                    const Divider(
                      height: 1,
                      thickness: 1,
                      color: AppPalette.perfRowRule,
                    ),
                  const _Row(),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        children: [
          _Block(
            width: 38,
            height: 38,
            radius: 12,
            tint: AppPalette.perfNoteDisc,
          ),
          const SizedBox(width: 12),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _Block(width: 110, height: 13, radius: 6),
              SizedBox(height: 8),
              _Block(width: 150, height: 10, radius: 5),
            ],
          ),
          const Spacer(),
          const Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _Block(width: 60, height: 15, radius: 8),
              SizedBox(height: 6),
              _Block(width: 72, height: 14, radius: 7),
            ],
          ),
        ],
      ),
    );
  }
}

class _Block extends StatelessWidget {
  const _Block({
    required this.width,
    required this.height,
    required this.radius,
    this.tint = AppPalette.perfTrack,
  });

  final double width;
  final double height;
  final double radius;
  final Color tint;

  @override
  Widget build(BuildContext context) => Container(
    width: width,
    height: height,
    decoration: BoxDecoration(
      color: tint,
      borderRadius: BorderRadius.circular(radius),
    ),
  );
}
