/// Turns whatever URL a post carries into one that is actually *embeddable*
/// in an `<iframe>`, plus the origin that iframe has to be served from.
///
/// A watch/permalink URL is not an embed URL. Dropping
/// `youtube.com/watch?v=ID` or `instagram.com/p/ID/` straight into an iframe
/// gives YouTube's "Video player configuration error" (error 153) or a blank
/// Instagram frame, because neither host allows its normal page to be framed.
library;

class EmbedTarget {
  const EmbedTarget({required this.src, required this.origin});

  /// What goes in the iframe's `src`.
  final String src;

  /// The document origin the iframe must be served under. YouTube rejects an
  /// embed whose referer is null — which is exactly what a bare
  /// `loadRequest` produces — so this is passed as the WebView's `baseUrl`.
  final String origin;
}

const _youtubeOrigin = 'https://www.youtube.com';
const _instagramOrigin = 'https://www.instagram.com';

EmbedTarget embedTargetFor(String url) {
  final uri = Uri.tryParse(url);
  final host = uri?.host.toLowerCase().replaceFirst('www.', '') ?? '';

  if (host.endsWith('instagram.com')) {
    return EmbedTarget(src: _instagramEmbed(uri!), origin: _instagramOrigin);
  }
  final videoId = _youtubeId(uri);
  if (videoId != null) {
    return EmbedTarget(src: _youtubeEmbed(videoId), origin: _youtubeOrigin);
  }
  // Something else entirely — a direct file, or a host added server-side that
  // this build has never seen. Frame it as-is and let the WebView try.
  return EmbedTarget(src: url, origin: url);
}

/// The 11-character video id, from any of the shapes the API might hand over:
/// public because a `videos` entry supplies `externalId` outright, but a
/// YouTube link found in `imageUrls` or the post body supplies only a URL.
String? youtubeVideoId(String url) => _youtubeId(Uri.tryParse(url));

/// The 11-character video id, from any of the shapes the API might hand over:
/// `watch?v=ID`, `youtu.be/ID`, `/embed/ID`, `/shorts/ID`, `/live/ID` — and
/// on either `youtube.com` or `youtube-nocookie.com`.
String? _youtubeId(Uri? uri) {
  if (uri == null) return null;
  final host = uri.host.toLowerCase().replaceFirst('www.', '');
  if (host == 'youtu.be') {
    return uri.pathSegments.isEmpty ? null : uri.pathSegments.first;
  }
  if (!host.endsWith('youtube.com') && !host.endsWith('youtube-nocookie.com')) {
    return null;
  }
  final fromQuery = uri.queryParameters['v'];
  if (fromQuery != null && fromQuery.isNotEmpty) return fromQuery;

  final segments = uri.pathSegments;
  for (final marker in const ['embed', 'shorts', 'live', 'v']) {
    final i = segments.indexOf(marker);
    if (i != -1 && i + 1 < segments.length) return segments[i + 1];
  }
  return null;
}

/// `playsinline=1` is what keeps playback inside the card on iOS instead of
/// handing it to the fullscreen system player. `rel=0` keeps the end screen's
/// suggestions within the same channel, and `modestbranding=1` drops the
/// corner logo.
String _youtubeEmbed(String id) => '$_youtubeOrigin/embed/$id'
    '?playsinline=1&rel=0&modestbranding=1&enablejsapi=1';

/// Instagram frames only its `/embed` route — `/p/<code>/`, `/reel/<code>/`
/// and `/tv/<code>/` all become `/<kind>/<code>/embed`.
///
/// Plain `/embed`, not `/embed/captioned`: the captioned variant grows to
/// whatever the caption needs, which no fixed card ratio can hold without
/// cropping it mid-sentence. The caption stays one tap away in Instagram.
String _instagramEmbed(Uri uri) {
  final segments = uri.pathSegments.where((s) => s.isNotEmpty).toList();
  if (segments.contains('embed')) return uri.toString();

  final i = segments.indexWhere((s) => s == 'p' || s == 'reel' || s == 'tv');
  if (i == -1 || i + 1 >= segments.length) return uri.toString();
  return '$_instagramOrigin/${segments[i]}/${segments[i + 1]}/embed';
}
