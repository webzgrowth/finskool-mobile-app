import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The full-width call-to-action at the foot of a community card.
///
/// Figma (`750:1142`): 42 high, radius 10, `#108B8B`, label then a 15px
/// arrow. Not [AuthSubmitButton] — that one takes its fill from the global
/// `ElevatedButton` theme (brand `primary`, #1E9299) and uses a Material
/// `Icons.arrow_forward`, whereas this is a different teal and the exact
/// exported arrow. Reuses `assets/icons/arrow_right.svg`, which is the same
/// glyph the community button uses, tinted white here.
class CommunityCtaButton extends StatelessWidget {
  const CommunityCtaButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.leadingLock = false,
  });

  final String label;
  final VoidCallback onPressed;
  final bool loading;

  /// Figma prefixes the locked-community CTA with an 11px padlock
  /// (`921:21480`).
  final bool leadingLock;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 42,
      width: double.infinity,
      child: Material(
        color: AppPalette.badgeTeal,
        borderRadius: BorderRadius.circular(AppRadii.sm),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: loading ? null : onPressed,
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (leadingLock) ...[
                  SvgPicture.asset(
                    'assets/icons/lock_small_icon.svg',
                    height: 11,
                    width: 10.6,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Text(label, style: context.communityType.cta),
                const SizedBox(width: AppSpacing.sm),
                if (loading)
                  const SizedBox(
                    height: 15,
                    width: 15,
                    child: CircularProgressIndicator(
                        strokeWidth: 2, color: Colors.white),
                  )
                else
                  SvgPicture.asset(
                    'assets/icons/arrow_right.svg',
                    height: 15.07,
                    width: 15.07,
                    colorFilter: const ColorFilter.mode(
                        AppPalette.white, BlendMode.srcIn),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
