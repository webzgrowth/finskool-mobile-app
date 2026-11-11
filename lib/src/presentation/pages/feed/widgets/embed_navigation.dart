import 'package:url_launcher/url_launcher.dart';

/// Whether a navigation inside an embed's WebView should leave the WebView.
///
/// The embed page is a single document that must stay on screen. Once it has
/// loaded, any **main-frame** navigation is the viewer tapping something on it
/// — "View profile", the caption, the post itself — and Instagram answers those
/// with its own full page (a login wall, or an error), which used to replace
/// the post in the card. Those links are handed to the system instead (the
/// Instagram app, or the browser). Frames *inside* the embed (its media and
/// widget iframes) and the page's own first load are left alone.
bool shouldOpenOutside({
  required String url,
  required bool isMainFrame,
  required bool pageLoaded,
}) => isMainFrame && pageLoaded && !url.startsWith('about:');

/// Decides whether a main-frame navigation may really leave the app.
///
/// A page can ask to navigate **without anyone touching it** — Instagram's
/// embed script re-tries its "open in the app" jump when the page regains focus,
/// so after coming back from Instagram the feed bounced straight out again,
/// untouched. A navigation is only honoured when it follows a real touch on the
/// embed ([touched]) within [gestureWindow], the app is in the foreground, and
/// nothing was launched in the last [cooldown] (a double tap, or a page that
/// asks twice, opens Instagram once).
class OutsideLaunchGuard {
  OutsideLaunchGuard({DateTime Function()? clock})
    : _now = clock ?? DateTime.now;

  static const gestureWindow = Duration(milliseconds: 1500);
  static const cooldown = Duration(seconds: 3);
  static const settleAfterResume = Duration(milliseconds: 1500);

  final DateTime Function() _now;
  DateTime? _touchedAt;
  DateTime? _launchedAt;
  DateTime? _resumedAt;
  bool _foreground = true;

  void touched() => _touchedAt = _now();

  void lifecycle({required bool foreground}) {
    if (foreground && !_foreground) _resumedAt = _now();
    _foreground = foreground;
  }

  /// True (and the launch is recorded) when [url] may open outside.
  bool allow() {
    final now = _now();
    bool within(DateTime? t, Duration d) => t != null && now.difference(t) < d;
    if (!_foreground) return false;
    if (within(_resumedAt, settleAfterResume)) return false;
    if (!within(_touchedAt, gestureWindow)) return false;
    if (within(_launchedAt, cooldown)) return false;
    _launchedAt = now;
    return true;
  }
}

/// Opens [url] outside the app's WebView. Only web links and Instagram's own
/// scheme are passed on; anything else a page might ask for is ignored.
Future<void> openOutside(String url) async {
  final uri = Uri.tryParse(url);
  if (uri == null) return;
  const allowed = {'http', 'https', 'instagram'};
  if (!allowed.contains(uri.scheme)) return;
  try {
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  } catch (_) {
    // No app or browser can take it: nothing sensible to show over a post.
  }
}
