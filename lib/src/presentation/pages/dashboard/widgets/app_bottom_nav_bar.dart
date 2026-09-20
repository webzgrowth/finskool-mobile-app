import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'nav_bar_item.dart';

/// The 4-tab dashboard bottom bar, driven entirely by [BottomNavBloc].
///
/// Feed/Communities/Performance are `IconData` — the first two are Material
/// stand-ins for exports Figma access was rate-limited before delivering
/// (`element-3`, `Frame 2121453450`; see CLAUDE.md "Profile"). Performance
/// deliberately does **not** use Figma's own node for that tab, which is
/// literally the search-bar glyph reused — confirmed a placeholder in the
/// design file itself, not a real icon to export.
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  static const _icons = [
    Icons.grid_view_rounded, // Feed — stand-in for `element-3`
    Icons.groups_rounded, // Communities — stand-in for `Frame 2121453450`
    Icons.trending_up_rounded, // Performance — deliberate stand-in, see above
  ];
  static const _labels = ['Feed', 'Communities', 'Performance', 'Profile'];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // The Communities badge is the sum of every community's unread
    // announcements — the only badge backed by real data. Figma also shows
    // one on Feed; that needs an unread-post count the feed doesn't track
    // yet, so it's deliberately absent rather than faked.
    final announcements = context
        .select<CommunitiesBloc, int>((b) => b.state.totalNewAnnouncements);
    // The Profile tab shows the real signed-in avatar, not an icon — see
    // NavBarItem.customIcon.
    final user = context.select<AuthenticatorWatcherBloc, UserModel?>(
        (b) => b.state.mapOrNull(authenticated: (s) => s.user));

    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Container(
          decoration: BoxDecoration(
            color: cs.surface,
            border: Border(top: BorderSide(color: cs.outlineVariant)),
          ),
          padding: EdgeInsets.only(
            bottom: MediaQuery.paddingOf(context).bottom,
          ),
          child: Row(
            children: List.generate(_labels.length, (i) {
              final isProfile = i == _labels.length - 1;
              return Expanded(
                child: NavBarItem(
                  icon: isProfile ? null : _icons[i],
                  customIcon:
                      isProfile ? UserAvatar(user: user, radius: 16) : null,
                  label: _labels[i],
                  badgeCount: i == 1 ? announcements : null,
                  selected: state.selectedIndex == i,
                  onTap: () => context
                      .read<BottomNavBloc>()
                      .add(BottomNavEvent.tabChanged(i)),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
