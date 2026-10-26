import 'package:finskool/src/comman/routes.dart';

/// Where a tapped push (or banner) should land, from its `data` map.
///
/// Contract (push_notifcation.md §5): `type` is `ticket` / `service` / `post`
/// / `subscription`, `id` is that thing's id, and `communityId` rides along
/// for posts and subscriptions. **Every value is a string**, and an unknown
/// `type` must never break the app — it falls back to the dashboard (there is
/// no notification inbox screen yet).
String routeForPush(Map<String, dynamic> data) {
  final id = data['id']?.toString();
  final communityId = data['communityId']?.toString();
  switch (data['type']) {
    case 'ticket' when id != null && id.isNotEmpty:
      return AppRoutes.ticketDetail(id);
    case 'service' when id != null && id.isNotEmpty:
      return AppRoutes.serviceChat(id);
    case 'post':
    case 'subscription':
      final community = (communityId?.isNotEmpty ?? false) ? communityId : id;
      return (community == null || community.isEmpty)
          ? AppRoutes.DASHBOARD_ROUTE_PATH
          : '/community/$community';
    default:
      return AppRoutes.DASHBOARD_ROUTE_PATH;
  }
}
