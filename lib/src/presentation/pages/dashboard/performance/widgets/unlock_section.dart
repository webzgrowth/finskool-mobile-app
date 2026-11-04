import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'locked_preview.dart';
import 'unlock_copy.dart';

// White at ~90% over the page colour at the top; the page colour itself at the
// bottom (measured from Figma's render: (251,253,253) → (231,243,243)).
final _washTop = AppPalette.white.withValues(alpha: 0.9);
const _washBottom = AppPalette.feedBase;

/// What a free member sees under their preview (Figma `Locked trades`): the
/// rest of the list blurred out, with a "Members only" card on top that says
/// what a subscription adds and sends them to the plans.
class UnlockSection extends StatelessWidget {
  const UnlockSection({super.key, required this.copy, required this.onTap});

  final UnlockCopy copy;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Stack(
      children: [
        const Positioned.fill(child: LockedPreview()),
        // The wash over the blurred rows: near-white at the top, fading to the
        // page colour at the bottom, so the section has no lower edge and just
        // melts into the background (Figma `Rectangle` over `Blurred list`).
        Positioned.fill(
          child: DecoratedBox(
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [_washTop, _washBottom],
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(22, 8, 22, 12),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(22, 22, 22, 20),
            decoration: BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: AppPalette.perfUnlockBorder),
              boxShadow: const [
                BoxShadow(
                  color: AppPalette.perfUnlockShadow,
                  offset: Offset(0, 18),
                  blurRadius: 40,
                  spreadRadius: -8,
                ),
              ],
            ),
            child: Column(
              children: [
                _MembersBadge(style: type.unlockBadge),
                const SizedBox(height: 14),
                Text(
                  copy.title,
                  textAlign: TextAlign.center,
                  style: type.unlockTitle,
                ),
                const SizedBox(height: 6),
                Text(
                  copy.body,
                  textAlign: TextAlign.center,
                  style: type.unlockBody,
                ),
                const SizedBox(height: 16),
                _Perks(perks: copy.perks, style: type.perk),
                const SizedBox(height: 16),
                _PlansButton(style: type.planButton, onTap: onTap),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _MembersBadge extends StatelessWidget {
  const _MembersBadge({required this.style});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 5, 10, 5),
      decoration: BoxDecoration(
        color: AppPalette.cardTitle,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(
            'assets/icons/lock_small_icon.svg',
            width: 11,
            colorFilter: const ColorFilter.mode(
              AppPalette.perfCountPill,
              BlendMode.srcIn,
            ),
          ),
          const SizedBox(width: 6),
          Text('Members only', style: style),
        ],
      ),
    );
  }
}

class _Perks extends StatelessWidget {
  const _Perks({required this.perks, required this.style});

  final List<String> perks;
  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: AppPalette.perfDetail,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (var i = 0; i < perks.length; i++) ...[
            if (i > 0) const SizedBox(height: 9),
            Row(
              children: [
                Container(
                  width: 14,
                  height: 14,
                  decoration: const BoxDecoration(
                    color: AppPalette.infoVerifiedPlate,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 9,
                    color: AppPalette.badgeTeal,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(child: Text(perks[i], style: style)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _PlansButton extends StatelessWidget {
  const _PlansButton({required this.style, required this.onTap});

  final TextStyle style;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'View plans',
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          height: 46,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(999),
            gradient: const LinearGradient(
              colors: [AppPalette.perfCountPill, AppPalette.badgeTeal],
            ),
          ),
          child: Text('View plans  →', style: style),
        ),
      ),
    );
  }
}
