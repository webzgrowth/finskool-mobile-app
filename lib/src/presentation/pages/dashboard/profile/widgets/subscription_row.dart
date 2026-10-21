import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'profile_glyphs.dart';
import 'profile_menu_row.dart';

/// One subscribed community: its name, "Active till…" or a red "Expires in N
/// days", and — inside the renewal window — a green Renew pill in place of
/// the chevron.
///
/// Figma gives each community its own glyph (chart for Intraday, a cap for the
/// Academy, a bolt for Investor); the model carries no icon, so it is picked
/// from `planStyle` and the slug — anything unrecognised gets the chart.
class SubscriptionRow extends StatelessWidget {
  const SubscriptionRow({
    super.key,
    required this.community,
    required this.onTap,
    required this.onRenew,
  });

  final CommunityModel community;
  final VoidCallback onTap;
  final VoidCallback onRenew;

  String get _glyph {
    if (community.planStyle.isTier) return ProfileGlyphs.education;
    final key = '${community.slug} ${community.name}'.toLowerCase();
    if (key.contains('academy')) return ProfileGlyphs.education;
    if (key.contains('investor')) return ProfileGlyphs.investor;
    return ProfileGlyphs.chart;
  }

  @override
  Widget build(BuildContext context) {
    assert(community.access == CommunityAccess.subscribed);
    final type = context.profileType;
    final renew = community.needsRenewal;
    return ProfileMenuRow(
      glyph: _glyph,
      title: community.name,
      subtitle: community.subscriptionStatusLabel,
      subtitleStyle: renew ? type.statusExpiring : null,
      trailing: renew ? _RenewPill(onTap: onRenew) : null,
      // The whole row opens the subscription; only the pill renews. (An
      // earlier pass sent a row tap to the purchase flow, which made an
      // expiring subscription impossible to open.)
      onTap: onTap,
      showChevron: !renew,
    );
  }
}

class _RenewPill extends StatelessWidget {
  const _RenewPill({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 25,
        padding: const EdgeInsets.symmetric(horizontal: 12),
        decoration: BoxDecoration(
          color: AppPalette.profileRenew,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Renew', style: context.profileType.renew),
            const SizedBox(width: 6),
            SvgPicture.asset(
              ProfileGlyphs.chevron,
              colorFilter: const ColorFilter.mode(
                AppPalette.white,
                BlendMode.srcIn,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
