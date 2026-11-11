import 'package:finskool/src/comman/routes.dart';

/// Where a tapped push, in-app banner or inbox row should land, from its
/// `data` map — **one function for all three**, so they can never disagree.
///
/// Contract (push guide §6): `type` is `post` / `feed` / `recommendation` /
/// `subscription` / `ticket` / `service`, `id` is that thing's id and
/// `communityId` rides along for posts and subscriptions. **Every value is a
/// string.** An unknown type, or data we can't act on, opens the notification
/// inbox — the guide's rule — so a new kind the server adds never breaks.
///
/// Matches Figma's "Tap opens": community post → the community feed, payment
/// or expiry → My subscription, quote or ticket reply → the chat.
///
/// [rowCommunityId] is the inbox row's own `communityId`, used when `data`
/// carries none — and never replaced by the *post's* id, which used to be
/// taken for a community's and opened the wrong feed.
String routeForPush(Map<String, dynamic>? data, {String? rowCommunityId}) {
  if (data == null) return AppRoutes.NOTIFICATIONS_ROUTE_PATH;
  final id = data['id']?.toString();
  final communityId = data['communityId']?.toString();
  final hasId = id != null && id.isNotEmpty;
  switch (data['type']) {
    case 'ticket' when hasId:
      return AppRoutes.ticketDetail(id);
    case 'service' when hasId:
      return AppRoutes.serviceChat(id);
    case 'post':
      final community = (communityId?.isNotEmpty ?? false)
          ? communityId
          : rowCommunityId;
      if (community == null || community.isEmpty) {
        return AppRoutes.NOTIFICATIONS_ROUTE_PATH;
      }
      // `post` names the exact post to bring to the top of that feed.
      return Uri(
        path: '/community/$community',
        queryParameters: {if (hasId) 'post': id},
      ).toString();
    case 'subscription' when hasId || (communityId?.isNotEmpty ?? false):
      // Resolved by the router: the subscription screen needs the whole
      // community, which a cold tap doesn't have — see `go_router.dart`.
      return '${AppRoutes.SUBSCRIPTION_DETAIL_ROUTE_PATH}'
          '?id=${(communityId?.isNotEmpty ?? false) ? communityId : id}';
    // The public feed has no post screen of its own: it *is* the dashboard.
    case 'feed':
    case 'recommendation':
      return AppRoutes.DASHBOARD_ROUTE_PATH;
    default:
      return AppRoutes.NOTIFICATIONS_ROUTE_PATH;
  }
}
