import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'package:finskool/src/presentation/bloc/tickets/unread/tickets_unread_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/feed_screen.dart';
import 'package:finskool/src/presentation/pages/communities/communities_screen.dart';

import 'performance/performance_screen.dart';
import 'profile/profile_screen.dart';
import 'widgets/app_bottom_nav_bar.dart';

/// Hosts the 4 bottom-nav tabs behind an [IndexedStack] — kept as a flat
/// widget switch (not a go_router `StatefulShellRoute`) since the router
/// elsewhere in this app is flat too; revisit only if deep-linking to a
/// specific tab becomes a requirement. `IndexedStack` (not a plain
/// conditional) is what keeps Feed's scroll position across tab switches.
class DashboardShellScreen extends StatefulWidget {
  const DashboardShellScreen({super.key});

  @override
  State<DashboardShellScreen> createState() => _DashboardShellScreenState();
}

class _DashboardShellScreenState extends State<DashboardShellScreen> {
  @override
  void initState() {
    super.initState();
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
          authenticated: (_) => context.read<TicketsUnreadBloc>().add(
            const TicketsUnreadEvent.started(),
          ),
          unauthenticated: (_) {
            // Close the socket with the session — it authenticated once, at
            // upgrade, so it would otherwise keep streaming this account's
            // events into whoever signs in next.
            context.read<TicketsUnreadBloc>().add(
              const TicketsUnreadEvent.stopped(),
            );
            // Back to Feed before leaving. BottomNavBloc is a singleton, so the
            // index would otherwise still point at whatever tab the user was on
            // when the next login opens the shell.
            context.read<BottomNavBloc>().add(const BottomNavEvent.reset());
            context.go(AppRoutes.LOGIN_ROUTE_PATH);
          },
        );
      },
      child: BlocBuilder<BottomNavBloc, BottomNavState>(
        builder: (context, state) {
          return Scaffold(
            body: IndexedStack(
              index: state.selectedIndex,
              children: const [
                FeedScreen(),
                CommunitiesScreen(),
                PerformanceScreen(),
                ProfileScreen(),
              ],
            ),
            bottomNavigationBar: const AppBottomNavBar(),
          );
        },
      ),
    );
  }
}
