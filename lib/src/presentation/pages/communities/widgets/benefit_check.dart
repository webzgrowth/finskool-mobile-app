import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The tick beside each "What You Get" benefit.
///
/// Figma (`921:21497` + `921:21498`): an 11px teal disc holding the 9px
/// Feather check, exported with a near-white `#F9F8FF` stroke — so the
/// glyph is drawn on the disc rather than tinted onto the card.
class BenefitCheck extends StatelessWidget {
  const BenefitCheck({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 11,
      width: 11,
      decoration: const BoxDecoration(
        color: AppPalette.communityChipTint,
        shape: BoxShape.circle,
      ),
      child: Center(
        child: SvgPicture.asset(
          'assets/icons/check_circle_glyph.svg',
          height: 9,
          width: 9,
        ),
      ),
    );
  }
}
