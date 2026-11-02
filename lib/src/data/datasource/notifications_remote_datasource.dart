import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';

/// The notification inbox and the push master switch. Like every datasource
/// these *throw*; the repository catches once via `handleErrors`.
@lazySingleton
class NotificationsRemoteDatasource {
  NotificationsRemoteDatasource(this._client);

  final ApiClient _client;

  Future<NotificationsPage> getPage(int page, {int pageSize = 20}) async {
    final data = await _client.get(
      Api.notifications,
      query: {'page': page, 'pageSize': pageSize},
    );
    if (data == null) throw ApiException('The server returned no inbox.');
    return NotificationsPage.fromJson(data);
  }

  /// Counts every unread row across all communities.
  Future<int> getUnreadCount() async {
    final data = await _client.get(Api.notificationsUnreadCount);
    return (data?['count'] as num?)?.toInt() ?? 0;
  }

  Future<void> markRead(String id) => _client.patch(Api.notificationRead(id));

  Future<void> markAllRead() => _client.patch(Api.notificationsMarkAllRead);

  Future<bool> getPushEnabled() async {
    final data = await _client.get(Api.pushSettings);
    return data?['pushEnabled'] as bool? ?? true;
  }

  Future<bool> setPushEnabled(bool enabled) async {
    final data = await _client.patch(
      Api.pushSettings,
      body: {'pushEnabled': enabled},
    );
    return data?['pushEnabled'] as bool? ?? enabled;
  }
}
