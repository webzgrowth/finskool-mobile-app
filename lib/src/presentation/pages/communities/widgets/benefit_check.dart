import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The tick beside each "What You Get" benefit.
///
/// Figma (`921:21497` + `921:21498`): an 11px teal disc holding the 9px
/// Feather check, exported with a near-white `#F9F8FF` stroke — so the
/// glyph is drawn on the disc rather than tinted onto the card.
/// [size] defaults to the community card's 11px; the Subscription Detail
/// screen draws the same tick larger, so the glyph scales with the disc
/// rather than a second widget existing for one number.
class BenefitCheck extends StatelessWidget {
  const BenefitCheck({super.key, this.size = 11});

  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size,
      width: size,
      decoration: const BoxDecoration(
        color: AppPalette.communityChipTint,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/check_circle_glyph.svg',
          height: size * 9 / 11,
          width: size * 9 / 11,
        ),
      ),
    );
  }
}
