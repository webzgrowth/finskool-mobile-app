import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'profile_icons.dart';
import 'profile_menu_row.dart';

/// One entry in the "My Subscription" section — a subscribed community's
/// name, its "Active till…" / "Expires in N days" status, and a Renew pill
/// once it's inside the renewal window (`CommunityModel.needsRenewal`).
///
/// The community row's icon differs from every other Profile row: Figma
/// shows an education glyph on the Academy entry and a chart glyph on the
/// trading ones — derived from `planStyle` since there's no dedicated icon
/// field on the model for a single row's decoration.
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

  @override
  Widget build(BuildContext context) {
    assert(community.access == CommunityAccess.subscribed);
    final renew = community.needsRenewal;

    return ProfileMenuRow(
      icon: Icon(
          community.planStyle.isTier ? ProfileIcons.education : ProfileIcons.chart),
      title: community.name,
      subtitle: community.subscriptionStatusLabel,
      subtitleColor: renew ? context.profileType.statusExpiring.color : null,
      trailing: renew ? _RenewPill(onTap: onRenew) : null,
      onTap: renew ? null : onTap,
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
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: 6),
        decoration: BoxDecoration(
          color: AppPalette.announcementGreen,
          borderRadius: BorderRadius.circular(AppRadii.pill),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Renew',
                style: context.profileType.rowSubtitle.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                    fontWeight: FontWeight.w600)),
            const SizedBox(width: 2),
            Icon(Icons.chevron_right_rounded,
                size: 14, color: Theme.of(context).colorScheme.onPrimary),
          ],
        ),
      ),
    );
  }
}
