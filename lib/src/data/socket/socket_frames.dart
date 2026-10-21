/// The wire format of `wss://<host>/ws/tickets` (§6).
///
/// Every request is a JSON **text** frame (binary is rejected) carrying an
/// `id`, and the server answers with **exactly one** ack bearing the same
/// id. Pushed events have no `id` and an `event` that is never `ack`.
library;

/// A request frame. `id` is ours and only has to be unique per connection.
class SocketRequest {
  const SocketRequest({
    required this.id,
    required this.action,
    required this.payload,
  });

  final String id;
  final String action;
  final Map<String, dynamic> payload;

  Map<String, dynamic> toJson() => {
    'id': id,
    'action': action,
    'payload': payload,
  };
}

/// `{ "event": "ack", "id", "ok", "data" | "error" }`.
class SocketAck {
  const SocketAck({required this.id, required this.ok, this.data, this.error});

  final String id;
  final bool ok;
  final Map<String, dynamic>? data;
  final SocketError? error;

  factory SocketAck.fromJson(Map<String, dynamic> json) => SocketAck(
    id: json['id'] as String? ?? '',
    ok: json['ok'] as bool? ?? false,
    data: json['data'] as Map<String, dynamic>?,
    error: json['error'] is Map<String, dynamic>
        ? SocketError.fromJson(json['error'] as Map<String, dynamic>)
        : null,
  );
}

/// A failed ack. [code] is what callers branch on — `TICKET_RESOLVED`,
/// `RATE_LIMITED`, `AUTH_INVALID`, and note that **not-found is `HTTP_404`**,
/// not `NOT_FOUND` (§8).
class SocketError implements Exception {
  const SocketError(this.code, this.message, {this.errors});

  final String code;
  final String message;

  /// Per-field messages on a `VALIDATION_ERROR`.
  final Map<String, dynamic>? errors;

  bool get isResolved => code == 'TICKET_RESOLVED';
  bool get isAuth => code == 'AUTH_INVALID';
  bool get isRateLimited => code == 'RATE_LIMITED';

  factory SocketError.fromJson(Map<String, dynamic> json) => SocketError(
    json['code'] as String? ?? 'INTERNAL_ERROR',
    json['message'] as String? ?? 'Something went wrong. Please retry.',
    errors: json['errors'] as Map<String, dynamic>?,
  );

  @override
  String toString() => 'SocketError($code): $message';
}

/// A pushed event: `ticket.created`, `ticket.message`, `ticket.updated`,
/// `ticket.read`.
///
/// The name is kept as the full dotted string so the same connection can
/// carry the services module's `service.*` traffic later without renaming
/// anything.
class SocketEvent {
  const SocketEvent({required this.event, required this.data, this.ticketId});

  final String event;
  final String? ticketId;
  final Map<String, dynamic> data;

  factory SocketEvent.fromJson(Map<String, dynamic> json) => SocketEvent(
    event: json['event'] as String? ?? '',
    ticketId: json['ticketId'] as String?,
    data: json['data'] as Map<String, dynamic>? ?? const {},
  );
}

/// Whether the socket can currently carry a message. The spec requires a
/// visible "reconnecting" state, because with the socket down the member
/// can neither send nor load history (§1).
enum SocketStatus { idle, connecting, live, offline }

extension SocketStatusX on SocketStatus {
  bool get canSend => this == SocketStatus.live;
}
