/// One row of the member's notification inbox — also the payload of a live
/// `notification.created` socket event and, via [data], the routing contract
/// of a push.
///
/// **Two different `type`s.** [type] is the row's own kind (`ticket-update`,
/// `post`, …) and is an **open set**: an unknown one must still render from
/// [title] and [message]. [data] carries the *routing* type (`post`, `feed`,
/// `subscription`, `ticket`, `service`…) and is what a tap routes on. It is
/// null on old rows that predate routing data.
class AppNotification {
  const AppNotification({
    required this.id,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    required this.createdAt,
    this.communityId,
    this.data,
  });

  final String id;
  final String? communityId;
  final String type;
  final String title;
  final String message;
  final Map<String, dynamic>? data;
  final bool isRead;
  final DateTime createdAt;

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    final raw = json['data'];
    return AppNotification(
      id: json['id'] as String? ?? '',
      communityId: json['communityId'] as String?,
      type: json['type'] as String? ?? '',
      title: json['title'] as String? ?? '',
      message: json['message'] as String? ?? '',
      data: raw is Map ? Map<String, dynamic>.from(raw) : null,
      isRead: json['isRead'] as bool? ?? false,
      createdAt:
          DateTime.tryParse(json['createdAt'] as String? ?? '') ??
          DateTime.now(),
    );
  }

  AppNotification copyWith({bool? isRead}) => AppNotification(
    id: id,
    communityId: communityId,
    type: type,
    title: title,
    message: message,
    data: data,
    isRead: isRead ?? this.isRead,
    createdAt: createdAt,
  );
}

/// A page of the inbox, newest first.
class NotificationsPage {
  const NotificationsPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });

  final List<AppNotification> items;
  final int page;
  final int totalPages;

  bool get hasMore => page < totalPages;

  factory NotificationsPage.fromJson(Map<String, dynamic> json) =>
      NotificationsPage(
        items: [
          for (final e in (json['notifications'] as List?) ?? const [])
            if (e is Map<String, dynamic>) AppNotification.fromJson(e),
        ],
        page: (json['page'] as num?)?.toInt() ?? 1,
        totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      );
}
