import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/presentation/bloc/notifications/inbox/notifications_inbox_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/widgets/info_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/notification_list.dart';

/// The notification inbox, behind the bell. **Not in Figma** — the design only
/// covers the push itself and the in-app banner — so it is the banner's own
/// card, stacked, on the Info screens' hero chrome. Flag it for the designer.
///
/// The inbox is the source of truth; pushes and the socket only nudge. It is
/// re-read on open and on every return to the foreground, since nothing is
/// replayed while the app was away.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<NotificationsInboxBloc>()
            ..add(const NotificationsInboxEvent.load()),
      child: const _View(),
    );
  }
}

class _View extends StatefulWidget {
  const _View();

  @override
  State<_View> createState() => _ViewState();
}

class _ViewState extends State<_View> {
  final _scroll = ScrollController();
  late final AppLifecycleListener _lifecycle;

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
    _lifecycle = AppLifecycleListener(onResume: _refresh);
  }

  @override
  void dispose() {
    _lifecycle.dispose();
    _scroll.dispose();
    super.dispose();
  }

  void _refresh() {
    if (!mounted) return;
    context.read<NotificationsInboxBloc>().add(
      const NotificationsInboxEvent.load(),
    );
    context.read<NotificationsUnreadBloc>().add(
      const NotificationsUnreadEvent.refresh(),
    );
  }

  /// Pages in more when the member nears the bottom — and **only then**.
  ///
  /// Three guards, all load-bearing (the feed learned them the hard way):
  /// * nothing to page when the list doesn't scroll (`maxScrollExtent` 0);
  /// * the trigger distance is **clamped to half the list**. A flat
  ///   `max - 300` goes negative on a short list, which made the test true
  ///   from `pixels: 0` and fired on every scroll notification;
  /// * the bloc's own `hasMore` / `isLoadingMore` are checked *here too*, so a
  ///   finished or in-flight list stops dispatching at the source instead of
  ///   churning one dropped event per scroll tick.
  void _onScroll() {
    final bloc = context.read<NotificationsInboxBloc>();
    final s = bloc.state;
    if (!s.hasMore || s.isLoadingMore || s.loadMoreFailed) return;
    final p = _scroll.position;
    if (p.maxScrollExtent <= 0) return;
    final trigger = (p.maxScrollExtent / 2).clamp(0.0, 300.0);
    if (p.pixels >= p.maxScrollExtent - trigger) {
      bloc.add(const NotificationsInboxEvent.loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationsInboxBloc, NotificationsInboxState>(
      builder: (context, state) {
        return InfoPage(
          title: 'Notifications',
          subtitle: state.unread == 0
              ? "You're all caught up"
              : '${state.unread} unread',
          controller: _scroll,
          onRefresh: () async => _refresh(),
          action: state.unread == 0
              ? null
              : GestureDetector(
                  onTap: () {
                    context.read<NotificationsInboxBloc>().add(
                      const NotificationsInboxEvent.markAllRead(),
                    );
                    context.read<NotificationsUnreadBloc>().add(
                      const NotificationsUnreadEvent.allRead(),
                    );
                  },
                  child: Text(
                    'Mark all read',
                    style: context.infoType.heroSubtitle.copyWith(
                      color: AppPalette.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
          children: notificationListChildren(context, state),
        );
      },
    );
  }
}
