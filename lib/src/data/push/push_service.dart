import 'dart:async';
import 'dart:convert';
import 'dart:io' show Platform;

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Messages that land while the app is closed. A top-level function, because
/// FCM runs it in its own isolate. The OS draws the banner itself for a
/// notification message; this only has to make sure Firebase is up.
@pragma('vm:entry-point')
Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
}

/// Push notifications: permission, the device's FCM token, and routing taps.
///
/// **Only real push notifications — there is no in-app banner.** While the app
/// is open the system banner is shown the same as when it is closed: iOS by
/// its foreground presentation options, Android by posting a local
/// notification (FCM draws none in the foreground). The live socket updates the
/// inbox and the bell badge silently, so a notification is never shown twice.
///
/// **Never throws.** Push is an extra: with Firebase unconfigured, the user
/// refusing permission, or iOS without an APNs key (no Apple developer
/// account yet), the app must carry on exactly as before.
///
/// Tapped notifications arrive on [taps] carrying the message's `data` map
/// (see `push_route.dart` for what each `type` opens).
@lazySingleton
class PushService {
  PushService(this._api);

  final ApiClient _api;

  static const String channelId = 'finskool_default';

  /// The status-bar icon: a white silhouette of the logo on transparent
  /// (`res/drawable-*/ic_stat_finskool.png`). Android masks a small icon by its
  /// alpha, so the opaque launcher icon this used to point at drew as a blank
  /// square. FCM's own banners get the same drawable from the manifest.
  static const String _smallIcon = 'ic_stat_finskool';

  final _local = FlutterLocalNotificationsPlugin();
  final _taps = StreamController<Map<String, dynamic>>.broadcast();
  StreamSubscription<String>? _refresh;
  bool _ready = false;
  bool _registered = false;

  Map<String, dynamic>? _pending;

  Stream<Map<String, dynamic>> get taps => _taps.stream;

  /// A notification tapped while the app was **closed**. It arrives before
  /// anyone is listening (and before sign-in is confirmed), so it waits here
  /// for the shell to collect it once.
  Map<String, dynamic>? takePending() {
    final p = _pending;
    _pending = null;
    return p;
  }

  /// Once at startup, before `runApp`.
  Future<void> init() async {
    try {
      await Firebase.initializeApp();
      FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
      // The local-notifications plugin creates the Android channel FCM's
      // banners use (high importance, or they don't heads-up) and draws the
      // notification for a message that arrives while the app is open.
      await _local.initialize(
        settings: const InitializationSettings(
          android: AndroidInitializationSettings(_smallIcon),
        ),
        onDidReceiveNotificationResponse: (r) {
          final payload = r.payload;
          if (payload == null || payload.isEmpty) return;
          try {
            _taps.add(Map<String, dynamic>.from(jsonDecode(payload) as Map));
          } catch (_) {}
        },
      );
      await _local
          .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin
          >()
          ?.createNotificationChannel(
            const AndroidNotificationChannel(
              channelId,
              'Finskool21',
              importance: Importance.high,
            ),
          );
      // iOS: show the system banner (and sound/badge) even while the app is
      // open. Android ignores this and is handled in `_onForeground`.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
            alert: true,
            badge: true,
            sound: true,
          );
      FirebaseMessaging.onMessage.listen(_onForeground);
      FirebaseMessaging.onMessageOpenedApp.listen((m) => _taps.add(m.data));
      final launch = await FirebaseMessaging.instance.getInitialMessage();
      if (launch != null) _pending = launch.data;
      _ready = true;
    } catch (e) {
      debugPrint('Push disabled: $e');
    }
  }

  /// After sign-in: ask permission, then give the backend this device's token.
  ///
  /// Called once per sign-in, never skipped on a "same token as last time"
  /// check: a login creates a **new session with no token** (the backend never
  /// carries the previous one over), and the call is idempotent anyway.
  Future<void> register() async {
    if (!_ready || _registered) return;
    try {
      final settings = await FirebaseMessaging.instance.requestPermission();
      if (settings.authorizationStatus == AuthorizationStatus.denied) {
        // Notifications are off in system settings: tell the server to stop.
        await _api.delete(Api.pushToken);
        return;
      }
      // `getToken`/`onTokenRefresh` are deprecated in favour of `register()`
      // + `onRegistered`, but those yield a Firebase Installation ID. The
      // backend sends through FCM v1 to the classic registration token (and
      // its docs test with it), so stay on the classic API.
      // ignore: deprecated_member_use
      final token = await FirebaseMessaging.instance.getToken();
      if (token == null) return;
      // For Firebase console → Messaging → "Send test message". Debug only.
      if (kDebugMode) debugPrint('FCM token: $token');
      await _send(token);
      _registered = true;
      // ignore: deprecated_member_use
      _refresh ??= FirebaseMessaging.instance.onTokenRefresh.listen(_send);
    } catch (e) {
      // iOS lands here until an APNs key is uploaded to Firebase.
      debugPrint('Push registration skipped: $e');
    }
  }

  /// On sign-out, so the next account on this phone registers afresh.
  void reset() => _registered = false;

  Future<void> _send(String token) async {
    try {
      await _api.put(
        Api.pushToken,
        body: {'token': token, 'platform': Platform.isIOS ? 'ios' : 'android'},
      );
    } catch (e) {
      debugPrint('Push token upload failed: $e');
    }
  }

  /// Android draws nothing for an FCM message while the app is open, so post
  /// the notification ourselves — carrying the routing `data`, so tapping it
  /// opens the same screen a closed-app notification would. iOS already showed
  /// its own (see the presentation options in [init]).
  Future<void> _onForeground(RemoteMessage message) async {
    final n = message.notification;
    if (!Platform.isAndroid || n == null) return;
    await _local.show(
      id: message.hashCode,
      title: n.title,
      body: n.body,
      payload: jsonEncode(message.data),
      notificationDetails: const NotificationDetails(
        android: AndroidNotificationDetails(
          channelId,
          'Finskool21',
          importance: Importance.high,
          priority: Priority.high,
          icon: _smallIcon,
          color: AppPalette.primary,
        ),
      ),
    );
  }
}
