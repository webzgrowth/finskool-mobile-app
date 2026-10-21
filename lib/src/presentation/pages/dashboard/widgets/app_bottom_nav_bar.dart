import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';

import 'package:finskool/src/utilities/theme/theme.dart';

import 'nav_bar_item.dart';

/// The 4-tab dashboard bottom bar, driven entirely by [BottomNavBloc].
///
/// The three glyphs are Figma's own exports from `iPhone 16 - 12`
/// (`element-3`, the people group and the trend arrow — the last is named
/// `search-alt-2_svgrepo.com` in the file but is drawn as the arrow, which is
/// what ships). They replace the Material stand-ins this bar used to carry.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  static const _glyphs = [
    'assets/icons/nav_feed.svg',
    'assets/icons/nav_communities.svg',
    'assets/icons/nav_performance.svg',
  ];
  static const _labels = ['Feed', 'Communities', 'Performance', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // The Communities badge is the sum of every community's unread
    // announcements — the only badge backed by real data. Figma also shows
    // one on Feed; that needs an unread-post count the feed doesn't track
    // yet, so it's deliberately absent rather than faked.
    final announcements = context.select<CommunitiesBloc, int>(
      (b) => b.state.totalNewAnnouncements,
    );
    // The Profile tab shows the real signed-in avatar, not an icon — see
    // NavBarItem.customIcon.
    final user = context.select<AuthenticatorWatcherBloc, UserModel?>(
      (b) => b.state.mapOrNull(authenticated: (s) => s.user),
    );

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: AppPalette.white,
            border: Border(top: BorderSide(color: cs.outlineVariant)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          // Figma spaces the four tabs with space-between inside a 42 / 29px
          // gutter — not four equal columns — so Communities and Performance
          // (the wide labels) sit closer together than Feed and Profile do.
          child: LayoutBuilder(
            builder: (context, box) => Padding(
              padding: EdgeInsets.only(
                left: box.maxWidth * 42 / 393,
                right: box.maxWidth * 29 / 393,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(_labels.length, (i) {
                  final isProfile = i == _labels.length - 1;
                  return NavBarItem(
                    glyph: isProfile ? null : _glyphs[i],
                    customIcon: isProfile
                        ? UserAvatar(user: user, radius: 10.5)
                        : null,
                    label: _labels[i],
                    badgeCount: i == 1 ? announcements : null,
                    selected: state.selectedIndex == i,
                    onTap: () => context.read<BottomNavBloc>().add(
                      BottomNavEvent.tabChanged(i),
                    ),
                  );
                }),
              ),
            ),
          ),
        );
      },
    );
  }
}
