import 'dart:io' show Platform;

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/fade_slide_in.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'connect_account_row.dart';
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
    this.postAlertsOn = true,
    this.onTogglePostAlerts,
    this.linkedProviders = const [],
    this.connecting,
    this.onConnect,
  });

  final List<CommunityModel> subscribed;
  final int unreadTickets;
  final bool notificationsOn;
  final ValueChanged<bool> onToggleNotifications;

  /// Community post alerts — a *different* setting from the master switch
  /// above (it also stops the inbox row, not just the banner). **Not in
  /// Figma**, which draws a single Notifications switch; the backend has two,
  /// so the second is a plain extra row. Null hides it.
  final bool postAlertsOn;
  final ValueChanged<bool>? onTogglePostAlerts;
  final ValueChanged<CommunityModel> onRenew;

  /// The providers already linked to this account (`user.linkedProviders`).
  final List<String> linkedProviders;

  /// The provider whose Connect is in flight, if any.
  final SocialProvider? connecting;

  /// Taps on a Connect pill. Null hides the Connect rows (a golden, a build
  /// with no social login).
  final ValueChanged<SocialProvider>? onConnect;

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
              if (onConnect != null) ...[
                for (final provider in [
                  SocialProvider.google,
                  // Apple sign-in is iPhone-only (see `SocialAuthButtons`).
                  if (Platform.isIOS) SocialProvider.apple,
                ])
                  ConnectAccountRow(
                    provider: provider,
                    connected: linkedProviders.contains(provider.name),
                    busy: connecting == provider,
                    onConnect: () => onConnect!(provider),
                  ),
              ],
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
              if (onTogglePostAlerts != null)
                ProfileMenuRow(
                  glyph: ProfileGlyphs.bell,
                  title: 'Post alerts',
                  subtitle: 'New posts and recommendations',
                  trailing: ProfileToggle(
                    value: postAlertsOn,
                    onChanged: onTogglePostAlerts!,
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
