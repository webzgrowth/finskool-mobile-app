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
