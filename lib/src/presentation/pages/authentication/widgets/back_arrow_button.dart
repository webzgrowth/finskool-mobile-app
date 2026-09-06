import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'auth_field_icons.dart';

/// The teal back arrow used across the password-reset screens — Figma
/// builds it by rotating its "arrow-right" icon 180°, so we do the same
/// with the exact exported SVG rather than a Material glyph.
class BackArrowButton extends StatelessWidget {
  const BackArrowButton({super.key, this.onTap});

  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap ?? () => Navigator.of(context).maybePop(),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.sm),
        child: Transform.rotate(
          angle: math.pi,
          child: SvgPicture.asset(
            AuthFieldIcons.arrowRight,
            height: 16,
            width: 16,
          ),
        ),
      ),
    );
  }
}
