import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/relative_time.dart';
import 'package:finskool/src/comman/widgets/notification_card.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/data/push/push_route.dart';
import 'package:finskool/src/presentation/bloc/notifications/inbox/notifications_inbox_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The inbox body as a list of children for `InfoPage`: skeletons while the
/// first page loads, a retry on a failed first load, an empty state, or the
/// cards (with a spinner while the next page loads).
List<Widget> notificationListChildren(
  BuildContext context,
  NotificationsInboxState state,
) {
  final type = context.notificationType;

  if (state.items.isEmpty) {
    if (state.state.isLoading || state.state.isEmpty) {
      return [
        for (var i = 0; i < 5; i++)
          const Padding(
            padding: EdgeInsets.only(bottom: 12),
            child: SkeletonBox(height: 98, radius: 22),
          ),
      ];
    }
    if (state.state.isError) {
      return [
        const SizedBox(height: 40),
        Text(state.message, textAlign: TextAlign.center, style: type.empty),
        TextButton(
          onPressed: () => context.read<NotificationsInboxBloc>().add(
            const NotificationsInboxEvent.load(),
          ),
          child: const Text('Try again'),
        ),
      ];
    }
    return [
      const SizedBox(height: 60),
      Text(
        'No notifications yet.\nNew posts, payments and replies will show up '
        'here.',
        textAlign: TextAlign.center,
        style: type.empty,
      ),
    ];
  }

  return [
    for (final n in state.items)
      Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: NotificationCard(
          title: n.title,
          body: n.message,
          time: relativeTime(n.createdAt),
          unread: !n.isRead,
          onTap: () {
            if (!n.isRead) {
              context.read<NotificationsInboxBloc>().add(
                NotificationsInboxEvent.markRead(n.id),
              );
              context.read<NotificationsUnreadBloc>().add(
                const NotificationsUnreadEvent.decremented(1),
              );
            }
            context.push(routeForPush(n.data, rowCommunityId: n.communityId));
          },
        ),
      ),
    if (state.isLoadingMore)
      const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Center(child: CircularProgressIndicator()),
      ),
  ];
}
