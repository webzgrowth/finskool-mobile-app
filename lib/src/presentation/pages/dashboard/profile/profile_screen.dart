import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/unread/tickets_unread_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';

import 'widgets/logout_button.dart';

import 'package:finskool/src/comman/widgets/fade_slide_in.dart';

import 'widgets/profile_sections.dart';
import 'widgets/profile_header.dart';

/// The Profile tab — Final page, frame `Profile` (`1372:1676`): an avatar header, then five
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
    // The signed-out redirect lives on DashboardShellScreen — the session
    // can expire from any tab, so it isn't this screen's job.
    return BlocBuilder<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
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
              // `ListView` auto-pads its top edge by the status-bar inset
              // when not given an explicit `padding`, which would stack a
              // second gap above the header; `ProfileHeader` bleeds behind the
              // status bar itself.
              padding: EdgeInsets.zero,
              children: [
                ProfileHeader(user: user),
                ColoredBox(
                  color: AppPalette.white,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: BlocBuilder<CommunitiesBloc, CommunitiesState>(
                      builder: (context, communities) =>
                          BlocBuilder<TicketsUnreadBloc, TicketsUnreadState>(
                            builder: (context, unread) => ProfileSections(
                              subscribed: communities.communities
                                  .where(
                                    (c) =>
                                        c.access == CommunityAccess.subscribed,
                                  )
                                  .toList(),
                              unreadTickets: unread.count,
                              notificationsOn:
                                  user?.postNotificationsEnabled ?? true,
                              onToggleNotifications: (value) =>
                                  context.read<AuthenticatorWatcherBloc>().add(
                                    AuthenticatorWatcherEvent.notificationsToggled(
                                      value,
                                    ),
                                  ),
                              onRenew: (c) => _renew(context, c),
                            ),
                          ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.sm,
                    AppSpacing.lg,
                    AppSpacing.xl,
                  ),
                  // Figma has no visible logout row in this mockup, so it
                  // stays a clearly separate destructive action below the
                  // sections rather than folded into one of them.
                  child: LogoutButton(
                    loading: authState.maybeMap(
                      authenticating: (_) => true,
                      orElse: () => false,
                    ),
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
