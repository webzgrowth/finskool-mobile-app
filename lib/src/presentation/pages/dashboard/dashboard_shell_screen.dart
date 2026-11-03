import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/push/push_route.dart';
import 'package:finskool/src/data/push/push_service.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/filter/community_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/catalog/services_catalog_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/filter/services_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart';
import 'package:finskool/src/presentation/pages/dashboard/widgets/kyc_reminder.dart';
import 'package:finskool/src/presentation/bloc/kyc/status/kyc_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/settings/push_settings_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/unread/tickets_unread_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/feed_screen.dart';
import 'package:finskool/src/presentation/pages/communities/communities_screen.dart';
import 'package:finskool/src/presentation/pages/services/services_screen.dart';
import 'package:finskool/src/presentation/bloc/services/unread/services_unread_bloc.dart';

import 'profile/profile_screen.dart';
import 'widgets/app_bottom_nav_bar.dart';

/// Hosts the 4 bottom-nav tabs behind a plain [IndexedStack] — kept as a flat
/// widget switch (not a go_router `StatefulShellRoute`) since the router
/// elsewhere in this app is flat too; revisit only if deep-linking to a
/// specific tab becomes a requirement. `IndexedStack` (not a plain
/// conditional) is what keeps Feed's scroll position across tab switches.
///
/// **No fade/slide on the switch itself** — every major app (WhatsApp,
/// Instagram, Spotify) swaps bottom-nav tab bodies instantly. An
/// `IndexedStack` only *paints* the selected child, so animating a fade-in
/// doesn't cross-fade old-tab-into-new-tab; it reveals the new tab over the
/// bare `Scaffold` background underneath, and since each tab's own background
/// colour differs, that read as a flash no matter how short the animation
/// was. An instant swap is both the fix and the platform convention.
class DashboardShellScreen extends StatefulWidget {
  const DashboardShellScreen({super.key});

  @override
  State<DashboardShellScreen> createState() => _DashboardShellScreenState();
}

class _DashboardShellScreenState extends State<DashboardShellScreen> {
  StreamSubscription<Map<String, dynamic>>? _pushTaps;
  AppLifecycleListener? _lifecycle;

  /// Opens the screen a tapped notification points at. The dashboard is where
  /// we already are, so an unknown `type` simply does nothing.
  void _openPush(Map<String, dynamic> data) {
    final route = routeForPush(data);
    if (!mounted || route == AppRoutes.DASHBOARD_ROUTE_PATH) return;
    context.push(route);
  }

  /// Back in the foreground: a payment the webhook confirmed while we were
  /// away (the member paid, then lost network or killed the app) only shows up
  /// by asking `/auth/mobile/me` again — the payment guide's §10.
  void _onResume() {
    if (!mounted) return;
    context.read<AuthenticatorWatcherBloc>().add(
      const AuthenticatorWatcherEvent.authCheckRequest(),
    );
    context.read<CommunitiesBloc>().add(const CommunitiesEvent.refresh());
    context.read<NotificationsUnreadBloc>().add(
      const NotificationsUnreadEvent.refresh(),
    );
  }

  /// Signing out clears **everything that belongs to the account**. These blocs
  /// live for the whole app, so left alone they hand the *previous* member's
  /// feed, subscriptions, services and profile to the next login — and, because
  /// they already hold data, skip the load and its skeleton entirely.
  void _forgetSession(BuildContext context) {
    context.read<FeedBloc>().add(const FeedEvent.reset());
    context.read<FeedFilterBloc>()
      ..add(const FeedFilterEvent.queryChanged(''))
      ..add(const FeedFilterEvent.filtersCleared());
    context.read<CommunitiesBloc>().add(const CommunitiesEvent.reset());
    context.read<CommunityFilterBloc>().add(
      const CommunityFilterEvent.queryChanged(''),
    );
    context.read<CommunityPurchaseBloc>().add(
      const CommunityPurchaseEvent.cleared(),
    );
    context.read<ServicesCatalogBloc>().add(const ServicesCatalogEvent.reset());
    context.read<ServicesFilterBloc>().add(
      const ServicesFilterEvent.queryChanged(''),
    );
    context.read<EditProfileBloc>().add(const EditProfileEvent.prefill(null));
    context.read<KycBloc>().add(const KycEvent.reset());
    // A half-typed PAN must not wait for the next member.
    context.read<ComplianceBloc>().add(const ComplianceEvent.initial());
    // The password the last member typed must not outlive their session.
    context.read<LoginFormBloc>().add(const LoginFormEvent.initial());
  }

  @override
  void dispose() {
    _lifecycle?.dispose();
    _pushTaps?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _pushTaps = locator<PushService>().taps.listen(_openPush);
    _lifecycle = AppLifecycleListener(onResume: _onResume);
    // Re-resolve the session on entry. Logging in only updates LoginFormBloc,
    // so without this the watcher would still say "unauthenticated" and the
    // Profile tab would show nobody. Doing it here covers every route into
    // the shell — login, signup, and the Google path — in one place.
    context.read<AuthenticatorWatcherBloc>().add(
      const AuthenticatorWatcherEvent.authCheckRequest(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listenWhen: (previous, current) => previous != current,
      // Owned by the shell, not the Profile tab: the session can die from
      // anywhere (a login on another device expires this one mid-scroll, and
      // `SessionExpiry` reports it), and every tab is behind this widget.
      listener: (context, state) {
        state.mapOrNull<void>(
          // A confirmed session is what the tickets socket needs. Done here,
          // not in `initState`, because `authCheckRequest` is asynchronous:
          // connecting before it resolves would race a dead cookie.
          authenticated: (_) {
            // Ask the server whether it has the member's DOB + PAN, on every
            // login and launch. The Profile shows the answer and the purchase
            // flow decides from the server, not from a local flag.
            context.read<KycBloc>().add(const KycEvent.load());
            context.read<TicketsUnreadBloc>().add(
              const TicketsUnreadEvent.started(),
            );
            context.read<ServicesUnreadBloc>().add(
              const ServicesUnreadEvent.started(),
            );
            context.read<NotificationsUnreadBloc>().add(
              const NotificationsUnreadEvent.started(),
            );
            context.read<PushSettingsBloc>().add(
              const PushSettingsEvent.load(),
            );
            final push = locator<PushService>()..register();
            // A tap that cold-started the app waited for sign-in to be
            // confirmed; collect it now that there is a session to open it in.
            final pending = push.takePending();
            if (pending != null) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => _openPush(pending),
              );
            }
          },
          unauthenticated: (_) {
            // Close the socket with the session — it authenticated once, at
            // upgrade, so it would otherwise keep streaming this account's
            // events into whoever signs in next.
            context.read<TicketsUnreadBloc>().add(
              const TicketsUnreadEvent.stopped(),
            );
            context.read<ServicesUnreadBloc>().add(
              const ServicesUnreadEvent.stopped(),
            );
            context.read<NotificationsUnreadBloc>().add(
              const NotificationsUnreadEvent.stopped(),
            );
            context.read<PushSettingsBloc>().add(
              const PushSettingsEvent.reset(),
            );
            locator<PushService>().reset();
            _forgetSession(context);
            // Back to Feed before leaving. BottomNavBloc is a singleton, so the
            // index would otherwise still point at whatever tab the user was on
            // when the next login opens the shell.
            context.read<BottomNavBloc>().add(const BottomNavEvent.reset());
            context.go(AppRoutes.LOGIN_ROUTE_PATH);
          },
        );
      },
      child: KycReminder(
        child: BlocBuilder<BottomNavBloc, BottomNavState>(
          builder: (context, state) {
            return Scaffold(
              body: IndexedStack(
                index: state.selectedIndex,
                children: const [
                  FeedScreen(),
                  CommunitiesScreen(),
                  ServicesScreen(),
                  ProfileScreen(),
                ],
              ),
              bottomNavigationBar: const AppBottomNavBar(),
            );
          },
        ),
      ),
    );
  }
}
