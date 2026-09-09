import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/feed_screen.dart';
import 'communities/communities_screen.dart';
import 'performance/performance_screen.dart';
import 'profile/profile_screen.dart';
import 'widgets/app_bottom_nav_bar.dart';

/// Hosts the 4 bottom-nav tabs behind an [IndexedStack] — kept as a flat
/// widget switch (not a go_router `StatefulShellRoute`) since the router
/// elsewhere in this app is flat too; revisit only if deep-linking to a
/// specific tab becomes a requirement. `IndexedStack` (not a plain
/// conditional) is what keeps Feed's scroll position across tab switches.
class DashboardShellScreen extends StatelessWidget {
  const DashboardShellScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
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
    );
  }
}
