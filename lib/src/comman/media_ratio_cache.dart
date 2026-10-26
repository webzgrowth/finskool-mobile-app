/// Remembers each media item's real width/height ratio for the life of the
/// app, keyed by its URL.
///
/// **Why this exists:** an image or uploaded video only learns its true shape
/// after it decodes/initialises, and `PostMediaCarousel` sizes its card from
/// that. Without a memory, the learned ratio lived in the carousel's `State`,
/// which a scrolling `SliverList` disposes the moment the card leaves the
/// viewport — so scrolling back to it rebuilt the card at the 16:9/1:1
/// *fallback*, then jumped to the real shape (a portrait reel is ~2:1 tall)
/// a moment later when the video initialised. That repeated resize, under the
/// user's finger, is what read as the feed "juggling up and down". With the
/// ratio cached, a card that has been seen once is the right size from its
/// very first frame, every time.
///
/// Plain static map on purpose: it's a pure memo with no lifecycle worth a
/// bloc, and an entry is a few bytes.
class MediaRatioCache {
  MediaRatioCache._();

  static final Map<String, double> _ratios = {};

  static double? of(String url) => _ratios[url];

  static void put(String url, double ratio) => _ratios[url] = ratio;
}
