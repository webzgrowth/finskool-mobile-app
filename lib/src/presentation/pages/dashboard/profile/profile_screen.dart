import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'widgets/logout_button.dart';
import 'widgets/profile_hero_banner.dart';
import 'widgets/profile_icons.dart';
import 'widgets/profile_identity_info.dart';
import 'widgets/profile_menu_row.dart';
import 'widgets/profile_section_card.dart';
import 'widgets/subscription_row.dart';

/// The Profile tab — Figma `893:15731`: an avatar header, then five
/// sectioned cards of menu rows (My Subscription, Account, Support,
/// Finskool21, Settings).
///
/// Composes two blocs in the widget layer, no new bloc for the screen
/// itself: [AuthenticatorWatcherBloc] for identity (also owns the
/// Notifications toggle — see CLAUDE.md "Profile" on why that isn't a
/// separate bloc) and [CommunitiesBloc] filtered to subscribed entries for
/// "My Subscription", same composition `CommunitiesScreen` already uses.
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listenWhen: (previous, current) => previous != current,
      listener: (context, state) {
        state.mapOrNull(
          unauthenticated: (_) => context.go(AppRoutes.LOGIN_ROUTE_PATH),
        );
      },
      builder: (context, authState) {
        final user = authState.mapOrNull(authenticated: (s) => s.user);
        final cs = Theme.of(context).colorScheme;

        return Scaffold(
          // Plain white, not the teal-tinted `surfaceContainer` the Feed/
          // Communities tabs use — the reference screenshot's body is flat
          // white behind the grey section cards.
          backgroundColor: cs.surface,
          // `top: false` — the hero banner bleeds its background behind the
          // status bar itself (see `ProfileHeroBanner`), same as
          // `SearchTopBar` on Feed/Communities; a full `SafeArea` would
          // inset the content down and leave a gap above the image instead.
          body: SafeArea(
            top: false,
            // Plain `ListView` — the banner is just the first item and
            // scrolls away with everything else, like the rest of this
            // screen. An earlier pass wrapped it in a floating/snap
            // `SliverAppBar` (the technique `SearchTopBar` uses on
            // Feed/Communities), but that's wrong here: floating means the
            // banner hides on scroll-down and pops back the moment you
            // scroll up even slightly, which reads as the avatar getting
            // "stuck" mid-scroll — fine for a compact search bar, not for
            // a tall identity header that should behave like normal
            // content.
            child: ListView(
              // `ListView` (unlike `CustomScrollView`) auto-pads its top
              // edge by `MediaQuery.padding.top` when not given an
              // explicit `padding` — since `SafeArea(top: false)` leaves
              // that inset value in place for `ProfileHeroBanner` to
              // consume itself, this auto-padding stacked a *second*
              // status-bar-height gap above the banner, pushing the teal
              // image down below the status bar instead of bleeding
              // behind it.
              padding: EdgeInsets.zero,
              children: [
                ProfileHeroBanner(user: user),
                ProfileIdentityInfo(user: user),
                BlocBuilder<CommunitiesBloc, CommunitiesState>(
                  builder: (context, communitiesState) {
                    final subscribed = communitiesState.communities
                        .where((c) => c.access == CommunityAccess.subscribed)
                        .toList();
                    if (subscribed.isEmpty) return const SizedBox.shrink();
                    return ProfileSectionCard(
                      title: 'My Subscription',
                      rows: [
                        for (final community in subscribed)
                          SubscriptionRow(
                            community: community,
                            onTap: () => context.push(
                              '/community/${community.id}',
                              extra: community.name,
                            ),
                            onRenew: () => _renew(context, community),
                          ),
                      ],
                    );
                  },
                ),
                ProfileSectionCard(
                  title: 'Account',
                  rows: [
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.user),
                      title: 'Edit Profile',
                      subtitle: 'Name, email and phone',
                      onTap: () =>
                          context.push(AppRoutes.EDIT_PROFILE_ROUTE_PATH),
                    ),
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.gift),
                      title: 'Welcome kits',
                      subtitle: 'Videos, guides and insights',
                      onTap: () =>
                          context.push(AppRoutes.WELCOME_KITS_ROUTE_PATH),
                    ),
                  ],
                ),
                ProfileSectionCard(
                  title: 'Support',
                  rows: [
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.tickets),
                      title: 'My tickets',
                      subtitle: 'Track your queries',
                      // Decorative mock count, same treatment as the Feed's
                      // "01:11" duration badge — not a ticketing domain
                      // model for one badge number.
                      trailing: const _CountBadge(count: 4),
                      onTap: () =>
                          context.push(AppRoutes.SUPPORT_TICKETS_ROUTE_PATH),
                    ),
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.support),
                      title: 'Help & support',
                      subtitle: 'FAQs and contact',
                      onTap: () =>
                          context.push(AppRoutes.HELP_SUPPORT_ROUTE_PATH),
                    ),
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.star),
                      title: 'Give feedback',
                      subtitle: 'Tell us what to improve',
                      onTap: () =>
                          context.push(AppRoutes.GIVE_FEEDBACK_ROUTE_PATH),
                    ),
                  ],
                ),
                ProfileSectionCard(
                  title: 'Finskool21',
                  rows: [
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.rupee),
                      title: 'About & SEBI info',
                      subtitle: 'Registration, awards, disclaimer',
                      onTap: () =>
                          context.push(AppRoutes.ABOUT_SEBI_ROUTE_PATH),
                    ),
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.share),
                      title: 'Share the app',
                      subtitle: 'Invite friends to Finskool21',
                      onTap: () =>
                          context.push(AppRoutes.SHARE_APP_ROUTE_PATH),
                    ),
                  ],
                ),
                ProfileSectionCard(
                  title: 'Settings',
                  rows: [
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.notifications),
                      title: 'Notifications',
                      trailing: Switch(
                        value: user?.postNotificationsEnabled ?? true,
                        // Overrides the app-wide (teal) switch theme
                        // deliberately — the reference screenshot's toggle
                        // is green here, not the brand teal every other
                        // switch in the app uses.
                        activeThumbColor: cs.onPrimary,
                        activeTrackColor: AppPalette.announcementGreen,
                        onChanged: (value) => context
                            .read<AuthenticatorWatcherBloc>()
                            .add(AuthenticatorWatcherEvent
                                .notificationsToggled(value)),
                      ),
                    ),
                    ProfileMenuRow(
                      icon: const Icon(ProfileIcons.document),
                      title: 'Terms & privacy policy',
                      onTap: () =>
                          context.push(AppRoutes.TERMS_PRIVACY_ROUTE_PATH),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                      AppSpacing.lg, AppSpacing.sm, AppSpacing.lg, AppSpacing.xl),
                  // Figma has no visible logout row in this mockup, so it
                  // stays a clearly separate destructive action below the
                  // sections rather than folded into one of them.
                  child: LogoutButton(
                    loading: authState.maybeMap(
                        authenticating: (_) => true, orElse: () => false),
                    onPressed: () => context
                        .read<AuthenticatorWatcherBloc>()
                        .add(const AuthenticatorWatcherEvent.signOut()),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Re-buys the community's current headline plan — the simplest faithful
  /// reading of "Renew" given there's no dedicated renewal flow designed:
  /// it's the same mocked purchase → compliance-skip → payment-success path
  /// a fresh purchase takes, just starting from an already-subscribed
  /// community instead of a locked one.
  void _renew(BuildContext context, CommunityModel community) {
    final plan = community.headlinePlan;
    if (plan == null) return;
    context.read<CommunityPurchaseBloc>().add(
          CommunityPurchaseEvent.started(community: community, plan: plan),
        );
    context.read<ComplianceBloc>().add(const ComplianceEvent.initial());
    context.push(AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_PATH);
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
        color: AppPalette.notificationDot,
        shape: BoxShape.circle,
      ),
      child: Text('$count', style: context.profileType.badge),
    );
  }
}
