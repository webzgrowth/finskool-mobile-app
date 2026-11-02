import 'package:flutter/foundation.dart' show Factory;
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:finskool/src/comman/embed_urls.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Renders an Instagram post — or any embed kind added server-side later —
/// inline in the card. YouTube does **not** come through here; it has its own
/// native player (`youtube_embed_player.dart`).
///
/// The embed URL is **loaded directly**, not wrapped in an `<iframe>` inside
/// our own `loadHtmlString` document. That wrapper existed for YouTube's
/// referer check, and YouTube no longer uses this widget. For Instagram it
/// was actively harmful: its embed script sizes itself by posting messages to
/// `window.parent`, and nesting it one frame deeper under a synthetic origin
/// left posts intermittently blank.
///
/// A real `userAgent` is set for the same reason — Instagram serves a
/// stripped or empty page to clients it doesn't recognise, which is the other
/// common cause of a blank embed.
class EmbedPlayer extends StatefulWidget {
  const EmbedPlayer({super.key, required this.embedUrl});

  final String embedUrl;

  @override
  State<EmbedPlayer> createState() => _EmbedPlayerState();
}

class _EmbedPlayerState extends State<EmbedPlayer> {
  late final WebViewController _controller = _build();
  bool _loading = true;
  bool _failed = false;

  /// Instagram's embed is served to browsers; an unrecognised agent gets a
  /// login wall or nothing at all.
  static const _userAgent =
      'Mozilla/5.0 (iPhone; CPU iPhone OS 17_0 like Mac OS X) '
      'AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.0 Mobile Safari/604.1';

  WebViewController _build() {
    final target = embedTargetFor(widget.embedUrl);

    final params = WebViewPlatform.instance is WebKitWebViewPlatform
        ? WebKitWebViewControllerCreationParams(
            allowsInlineMediaPlayback: true,
            mediaTypesRequiringUserAction: const {},
          )
        : const PlatformWebViewControllerCreationParams();

    final controller = WebViewController.fromPlatformCreationParams(params)
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      // Not black: Instagram's embed page paints no background of its own (it
      // expects the host page's), so a black WebView showed through as a dark
      // rectangle where the post should be.
      ..setBackgroundColor(AppPalette.feedMediaPlate)
      ..setUserAgent(_userAgent)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            _controller.runJavaScript(_autoplayScript);
            _settle(failed: false);
          },
          // Surfaced rather than swallowed: a silently blank frame is
          // indistinguishable from a post that's simply slow.
          onWebResourceError: (error) {
            if (error.isForMainFrame ?? true) _settle(failed: true);
          },
          onHttpError: (_) => _settle(failed: true),
        ),
      )
      ..loadRequest(Uri.parse(target.src));

    // Android's equivalent of the WebKit params above: without it the first
    // tap is swallowed as the "user gesture" rather than starting playback.
    final platform = controller.platform;
    if (platform is AndroidWebViewController) {
      platform.setMediaPlaybackRequiresUserGesture(false);
    }
    return controller;
  }

  /// Makes the embed behave like Instagram's own feed: the post's video starts
  /// **muted** on its own, loops, and keeps its controls so the viewer can
  /// unmute — as the YouTube player does.
  ///
  /// Possible because the embed page is loaded as the top-level document (not
  /// framed), so its `<video>` is reachable. Browsers only allow autoplay when
  /// muted, hence `muted` first; iOS and Android are also configured above not
  /// to demand a tap. The page builds its player lazily, so this polls for ~20s
  /// and, when there is only a poster with a play button, presses it.
  static const _autoplayScript = '''
(function () {
  var style = document.createElement('style');
  style.textContent = 'html,body{background:#F4F4F4 !important}' +
    '#fs-bar{position:fixed;left:8px;right:8px;bottom:8px;z-index:2147483647;' +
    'display:flex;align-items:center;gap:6px;padding:4px 8px;border-radius:20px;' +
    'background:rgba(0,0,0,.6);color:#fff;font:600 12px -apple-system,sans-serif;' +
    'touch-action:manipulation}' +
    '#fs-bar button{background:none;border:0;color:#fff;font:inherit;' +
    'min-width:34px;height:30px;padding:0 4px}' +
    '#fs-bar input{flex:1;min-width:40px;height:24px}';
  document.head.appendChild(style);

  // Our own control bar. Instagram's page lays its own UI over the <video>, so
  // the native controls were unreachable — no scrubbing, no sound. These are
  // ordinary buttons *inside* the page, so a tap on one is a real user gesture
  // and the browser lets the sound come on.
  function addControls(v) {
    if (document.getElementById('fs-bar')) return;
    v.controls = false;
    var bar = document.createElement('div');
    bar.id = 'fs-bar';
    function btn(label, fn) {
      var b = document.createElement('button');
      b.textContent = label;
      b.addEventListener('click', function (e) {
        e.stopPropagation();
        fn();
      });
      bar.appendChild(b);
      return b;
    }
    btn('\u23EA10', function () { v.currentTime = Math.max(0, v.currentTime - 10); });
    var play = btn('\u23F8', function () { v.paused ? v.play() : v.pause(); });
    btn('10\u23E9', function () {
      v.currentTime = Math.min(v.duration || 1e9, v.currentTime + 10);
    });
    var seek = document.createElement('input');
    seek.type = 'range';
    seek.min = 0;
    seek.max = 1000;
    seek.value = 0;
    seek.addEventListener('input', function () {
      if (v.duration) v.currentTime = v.duration * seek.value / 1000;
    });
    bar.appendChild(seek);
    var sound = btn('\uD83D\uDD07', function () {
      v.muted = !v.muted;
      if (!v.muted) { v.volume = 1; }
      sound.textContent = v.muted ? '\uD83D\uDD07' : '\uD83D\uDD0A';
    });
    v.addEventListener('timeupdate', function () {
      if (v.duration) seek.value = Math.round(1000 * v.currentTime / v.duration);
    });
    v.addEventListener('play', function () { play.textContent = '\u23F8'; });
    v.addEventListener('pause', function () { play.textContent = '\u25B6'; });
    document.body.appendChild(bar);
  }

  function start() {
    var v = document.querySelector('video');
    if (v) {
      v.muted = true;
      v.setAttribute('muted', '');
      v.playsInline = true;
      v.setAttribute('playsinline', '');
      v.loop = true;
      addControls(v);
      var p = v.play();
      if (p && p.catch) p.catch(function () {});
      return true;
    }
    var b = document.querySelector(
      '[class*="PlayButton"],[class*="playButton"],[aria-label*="Play" i]'
    );
    if (b) b.click();
    return false;
  }
  var tries = 0;
  var timer = setInterval(function () {
    if (start() || ++tries > 40) clearInterval(timer);
  }, 500);
})();
''';

  void _settle({required bool failed}) {
    if (!mounted) return;
    setState(() {
      _loading = false;
      // A late sub-resource failure must not blank a frame that already
      // painted, so only the first outcome counts.
      _failed = _failed || failed;
    });
  }

  // No AspectRatio of its own: the carousel sizes the box, per item, because
  // an Instagram embed is portrait where a YouTube one is 16:9.
  @override
  Widget build(BuildContext context) {
    if (_failed) return const _EmbedUnavailable();
    return Stack(
      fit: StackFit.expand,
      children: [
        WebViewWidget(
          controller: _controller,
          // Left to the defaults, every horizontal drag on the post went to the
          // carousel's `PageView` — so the video's scrubber (rewind / forward)
          // could never be dragged, and a tap could be lost to the scroll
          // arena. Claim taps and **horizontal** drags for the page; vertical
          // drags still scroll the feed past it.
          gestureRecognizers: {
            Factory<TapGestureRecognizer>(TapGestureRecognizer.new),
            Factory<HorizontalDragGestureRecognizer>(
              HorizontalDragGestureRecognizer.new,
            ),
          },
        ),
        if (_loading)
          const ColoredBox(
            color: AppPalette.feedMediaPlate,
            child: Center(
              child: SizedBox(
                height: 22,
                width: 22,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
            ),
          ),
      ],
    );
  }
}

/// Shown when the embed genuinely can't render — a deleted or private
/// Instagram post, or no network. Better than a black rectangle.
class _EmbedUnavailable extends StatelessWidget {
  const _EmbedUnavailable();

  @override
  Widget build(BuildContext context) {
    return const ColoredBox(
      color: AppPalette.feedMediaPlate,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.link_off_rounded,
              color: AppPalette.ticketHint,
              size: 22,
            ),
            SizedBox(height: 6),
            Text(
              "This post can't be shown",
              style: TextStyle(color: AppPalette.ticketHint, fontSize: 11),
            ),
          ],
        ),
      ),
    );
  }
}
