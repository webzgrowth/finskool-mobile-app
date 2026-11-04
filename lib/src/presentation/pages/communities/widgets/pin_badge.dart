import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Marks a community the member has bought. Subscribed communities are pinned
/// to the top of the list (`CommunitiesState.pinnedFirst`), and this is the
/// card's own sign of why it is there.
///
/// Frosted glass like the member-count pill opposite it, so the two read as one
/// family. The glyph is Material's `push_pin` — Figma's `911:20521` only says
/// the card "will be pinned" and its own mark couldn't be exported, so swap in
/// that asset if the designer supplies one.
class PinBadge extends StatelessWidget {
  const PinBadge({super.key});

  static const double size = 27;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Pinned',
      child: ClipOval(
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
          child: Container(
            height: size,
            width: size,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppPalette.white.withValues(alpha: 0.18),
              shape: BoxShape.circle,
              border: Border.all(
                color: AppPalette.white.withValues(alpha: 0.25),
                width: 0.8,
              ),
            ),
            child: const Icon(
              Icons.push_pin,
              size: 14,
              color: AppPalette.white,
            ),
          ),
        ),
      ),
    );
  }
}
