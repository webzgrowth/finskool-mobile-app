import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_glyphs.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "My requests" — the way into the member's service requests, now that the
/// Services bell is the same notification bell as on every other tab (it used
/// to open this list and carry *its* unread count, which is why Services showed
/// a different badge from Feed and Communities).
///
/// [unread] is the requests' own unread count, shown as a small pill; zero
/// hides it.
class MyRequestsRow extends StatelessWidget {
  const MyRequestsRow({super.key, required this.unread, required this.onTap});

  final int unread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;
    // The service cards' own chrome (white, r20, soft shadow) with the Profile
    // rows' content (teal tile + Figma glyph, title over subtitle, chevron), so
    // it reads as part of the same screen rather than a stray bar.
    return Container(
      margin: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: context.gradients.feedCard,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadii.lg),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppPalette.badgeTeal,
                    borderRadius: BorderRadius.circular(11),
                  ),
                  child: SvgPicture.asset(ProfileGlyphs.support),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('My requests', style: type.rowTitle),
                      const SizedBox(height: 2),
                      Text(
                        'Your enquiries, quotes and payments',
                        style: type.rowSubtitle,
                      ),
                    ],
                  ),
                ),
                if (unread > 0) ...[
                  const SizedBox(width: 8),
                  Container(
                    constraints: const BoxConstraints(minWidth: 22),
                    height: 22,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppPalette.ticketRequired,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                    child: Text(
                      unread > 99 ? '99+' : '$unread',
                      style: type.badge,
                    ),
                  ),
                ],
                const SizedBox(width: 10),
                SvgPicture.asset(ProfileGlyphs.chevron),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
