import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'nav_bar_item.dart';

/// The 4-tab dashboard bottom bar, driven entirely by [BottomNavBloc].
class AppBottomNavBar extends StatelessWidget {
  const AppBottomNavBar({super.key});

  static const _items = [
    (icon: Icons.grid_view_rounded, label: 'Feed'),
    (icon: Icons.groups_rounded, label: 'Communities'),
    (icon: Icons.trending_up_rounded, label: 'Performance'),
    (icon: Icons.person_rounded, label: 'Profile'),
  ];

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
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
            children: List.generate(_items.length, (i) {
              final item = _items[i];
              return Expanded(
                child: NavBarItem(
                  icon: item.icon,
                  label: item.label,
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
