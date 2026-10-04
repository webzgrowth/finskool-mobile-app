import 'dart:async';

/// Broadcasts "the session this app was holding is no longer valid".
///
/// `SessionInterceptor` drops the dead cookie when the server rejects it, but
/// dropping it silently leaves the user sitting in a signed-in shell until
/// they next restart the app — every request failing, nothing explaining why.
/// This is how that reaches the UI: `AuthenticatorWatcherBloc` listens and
/// flips to `unauthenticated`, which the dashboard shell turns into a trip
/// back to `/login`.
///
/// A plain singleton with a broadcast stream rather than a bloc: the
/// interceptor lives in the data layer and must not depend on presentation,
/// and this fires from inside a Dio callback, not an event handler.
class SessionExpiry {
  SessionExpiry._();

  static final SessionExpiry instance = SessionExpiry._();

  final _controller = StreamController<void>.broadcast();

  /// Fires once per detected expiry. Broadcast, so late subscribers simply
  /// miss earlier events — which is correct: the watcher resolves the
  /// current session on launch anyway.
  Stream<void> get stream => _controller.stream;

  void notifyExpired() {
    if (!_controller.isClosed) _controller.add(null);
  }
}
