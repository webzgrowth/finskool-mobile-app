import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'back_arrow_button.dart';

/// Back arrow + centered title used at the top of each password-reset
/// screen's card ("Reset password", "New password", ...).
///
/// Wrapped in a fixed-height [SizedBox] with [Positioned]/[Center] rather
/// than a loosely-constrained `Stack(alignment: center)` — the latter let
/// the icon and title size themselves independently, so they didn't
/// actually align to the same vertical center.
class ResetCardTitle extends StatelessWidget {
  const ResetCardTitle({super.key, required this.title, this.onBack});

  final String title;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            child: Center(child: BackArrowButton(onTap: onBack)),
          ),
          Center(
            child: Text(
              title,
              style: manrope(
                size: 18,
                weight: 700,
                height: 1.3,
                color: AppPalette.cardTitle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
