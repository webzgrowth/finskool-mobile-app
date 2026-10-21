import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/fade_slide_in.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'profile_glyphs.dart';
import 'profile_menu_row.dart';
import 'profile_section_card.dart';
import 'profile_toggle.dart';
import 'subscription_row.dart';

/// The five cards under the header, each fading up a beat after the one above.
///
/// Takes plain data so it can be rendered (and golden-tested) without the
/// blocs that feed it; `ProfileScreen` does the composing.
class ProfileSections extends StatelessWidget {
  const ProfileSections({
    super.key,
    required this.subscribed,
    required this.unreadTickets,
    required this.notificationsOn,
    required this.onToggleNotifications,
    required this.onRenew,
  });

  final List<CommunityModel> subscribed;
  final int unreadTickets;
  final bool notificationsOn;
  final ValueChanged<bool> onToggleNotifications;
  final ValueChanged<CommunityModel> onRenew;

  @override
  Widget build(BuildContext context) {
    void go(String path) => context.push(path);
    return Column(
      children: [
        FadeSlideIn(
          child: ProfileSectionCard(
            title: 'My Subscription',
            rows: [
              for (final c in subscribed)
                SubscriptionRow(
                  community: c,
                  onTap: () => context.push(
                    AppRoutes.SUBSCRIPTION_DETAIL_ROUTE_PATH,
                    extra: c,
                  ),
                  onRenew: () => onRenew(c),
                ),
            ],
          ),
        ),
        FadeSlideIn(
          index: 1,
          child: ProfileSectionCard(
            title: 'Account',
            rows: [
              ProfileMenuRow(
                glyph: ProfileGlyphs.user,
                title: 'Edit Profile',
                subtitle: 'Name, email and phone',
                onTap: () => go(AppRoutes.EDIT_PROFILE_ROUTE_PATH),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.gift,
                title: 'Welcome kits',
                subtitle: 'Videos, guides and insights',
                onTap: () => go(AppRoutes.WELCOME_KITS_ROUTE_PATH),
              ),
            ],
          ),
        ),
        FadeSlideIn(
          index: 2,
          child: ProfileSectionCard(
            title: 'Support',
            rows: [
              ProfileMenuRow(
                glyph: ProfileGlyphs.tickets,
                title: 'My tickets',
                subtitle: 'Track your queries',
                // The real unread-reply count, kept live by the socket;
                // hidden at zero rather than an empty "0" disc.
                trailing: unreadTickets > 0
                    ? _CountBadge(count: unreadTickets)
                    : null,
                onTap: () => go(AppRoutes.SUPPORT_TICKETS_ROUTE_PATH),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.support,
                title: 'Help & support',
                subtitle: 'FAQs and contact',
                onTap: () => go(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.star,
                title: 'Give feedback',
                subtitle: 'Tell us what to improve',
                onTap: () => go(AppRoutes.GIVE_FEEDBACK_ROUTE_PATH),
              ),
            ],
          ),
        ),
        FadeSlideIn(
          index: 3,
          child: ProfileSectionCard(
            title: 'Finskool21',
            rows: [
              ProfileMenuRow(
                glyph: ProfileGlyphs.rupee,
                title: 'About & SEBI info',
                subtitle: 'Registration, awards, disclaimer',
                onTap: () => go(AppRoutes.ABOUT_SEBI_ROUTE_PATH),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.share,
                title: 'Share the app',
                subtitle: 'Invite friends to Finskool21',
                onTap: () => go(AppRoutes.SHARE_APP_ROUTE_PATH),
              ),
            ],
          ),
        ),
        FadeSlideIn(
          index: 4,
          child: ProfileSectionCard(
            title: 'Settings',
            rows: [
              ProfileMenuRow(
                glyph: ProfileGlyphs.bell,
                title: 'Notifications',
                trailing: ProfileToggle(
                  value: notificationsOn,
                  onChanged: onToggleNotifications,
                ),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.privacy,
                title: 'Privacy & security',
                onTap: () => go(AppRoutes.PRIVACY_SECURITY_ROUTE_PATH),
              ),
              ProfileMenuRow(
                glyph: ProfileGlyphs.document,
                title: 'Terms & privacy policy',
                onTap: () => go(AppRoutes.TERMS_PRIVACY_ROUTE_PATH),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CountBadge extends StatelessWidget {
  const _CountBadge({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 20,
      width: 20,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppPalette.ticketRequired,
        shape: BoxShape.circle,
      ),
      child: Text('$count', style: context.profileType.badge),
    );
  }
}
