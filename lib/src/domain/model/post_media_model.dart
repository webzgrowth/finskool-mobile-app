import 'package:finskool/src/comman/embed_urls.dart';

/// A single item in a [FeedPostModel]'s media carousel.
///
/// Embeds are rendered inline via a WebView (`widgets/embed_player.dart`) —
/// true in-feed playback, not a tap-to-open-externally thumbnail. Native
/// uploaded-video playback is still out of scope, so a `kind` this build
/// doesn't recognise falls back to [videoEmbed] and is handed to the same
/// WebView rather than being dropped.
enum PostMediaType { image, youtubeEmbed, instagramEmbed, videoEmbed }

class PostMediaModel {
  const PostMediaModel({
    required this.type,
    required this.imageUrl,
    this.embedUrl,
    this.thumbnailUrl,
    this.title,
    this.videoId,
    this.durationLabel,
  });

  final PostMediaType type;
  final String imageUrl;
  final String? embedUrl;

  /// The embed's poster frame, which the API **does** supply for a `videos`
  /// entry (`thumbnailUrl`) even though it supplies none for an `imageUrls`
  /// embed. Used by the carousel's preview strip.
  final String? thumbnailUrl;

  /// The video's own title, e.g. the YouTube title. Null for an image.
  final String? title;

  /// YouTube's 11-character video id — the API's `externalId`, which is
  /// exactly what `YoutubePlayerController.fromVideoId` wants, so a YouTube
  /// item needs no URL parsing at all. Falls back to parsing the URL for a
  /// link that arrived through `imageUrls` or the post body, and is null for
  /// everything that isn't YouTube.
  final String? videoId;
  final String? durationLabel;

  bool get isEmbed => type != PostMediaType.image;

  /// How tall the carousel should be for this item. Figma draws images and
  /// video at 332x171 — a hair wider than 16:9 (`605:15442`). Instagram's
  /// embed is portrait, and forcing it into a landscape box crops the picture
  /// and the account header off the frame, so it keeps 4:5.
  double get aspectRatio =>
      type == PostMediaType.instagramEmbed ? 4 / 5 : 332 / 171;

  /// A still worth rendering, or null when this item has none and the
  /// WebView is the only thing that can show it.
  String? get posterUrl {
    if (thumbnailUrl != null && thumbnailUrl!.isNotEmpty) return thumbnailUrl;
    return type == PostMediaType.image ? imageUrl : null;
  }

  /// A post's flat `imageUrls: [String]` — no type, so the media kind is
  /// sniffed from the URL's host. Also used for pictures found inline in the
  /// HTML body.
  ///
  /// This path has no poster frame and no duration: for an embed [imageUrl]
  /// carries the embed URL itself, which is why [posterUrl] refuses to hand
  /// it to an image widget.
  factory PostMediaModel.fromUrl(String url) {
    final host = Uri.tryParse(url)?.host.toLowerCase() ?? '';
    final type = host.endsWith('youtube.com') || host.endsWith('youtu.be')
        ? PostMediaType.youtubeEmbed
        : host.endsWith('instagram.com')
        ? PostMediaType.instagramEmbed
        : PostMediaType.image;
    return PostMediaModel(
      type: type,
      imageUrl: url,
      embedUrl: type == PostMediaType.image ? null : url,
      videoId: type == PostMediaType.youtubeEmbed ? youtubeVideoId(url) : null,
    );
  }

  /// A post's `videos: [...]` array — typed, and far richer than
  /// `imageUrls`: `kind`, a watch `url`, a ready-made `embedUrl`, the video
  /// `title` and a real `thumbnailUrl`.
  ///
  /// Undocumented in the OpenAPI spec, which lists only `imageUrls`. It is
  /// nonetheless what the backend sends, so it is parsed defensively — an
  /// entry with no usable URL at all returns null and is skipped rather than
  /// rendering an empty player.
  static PostMediaModel? fromVideoJson(Map<String, dynamic> json) {
    final embedUrl = json['embedUrl'] as String?;
    final url = json['url'] as String?;
    final playable = (embedUrl?.isNotEmpty ?? false)
        ? embedUrl!
        : (url?.isNotEmpty ?? false)
        ? url!
        : null;
    if (playable == null) return null;

    final kind = (json['kind'] as String?)?.toLowerCase();
    return PostMediaModel(
      type: switch (kind) {
        'youtube' => PostMediaType.youtubeEmbed,
        'instagram' => PostMediaType.instagramEmbed,
        // 'upload', 'vimeo', anything new — still a video, still playable in
        // the WebView. Better than dropping it for not being on a list.
        _ => PostMediaType.videoEmbed,
      },
      imageUrl: playable,
      embedUrl: playable,
      thumbnailUrl: json['thumbnailUrl'] as String?,
      title: json['title'] as String?,
      // `externalId` straight off the payload; the URL parse is only the
      // fallback for a payload that omits it.
      videoId: kind == 'youtube'
          ? ((json['externalId'] as String?)?.isNotEmpty ?? false)
                ? json['externalId'] as String
                : youtubeVideoId(playable)
          : null,
    );
  }

  factory PostMediaModel.fromJson(Map<String, dynamic> json) => PostMediaModel(
    type: PostMediaType.values.firstWhere((t) => t.name == json['type']),
    imageUrl: json['imageUrl'] as String,
    embedUrl: json['embedUrl'] as String?,
    thumbnailUrl: json['thumbnailUrl'] as String?,
    title: json['title'] as String?,
    videoId: json['videoId'] as String?,
    durationLabel: json['durationLabel'] as String?,
  );

  Map<String, dynamic> toJson() => {
    'type': type.name,
    'imageUrl': imageUrl,
    'embedUrl': embedUrl,
    'thumbnailUrl': thumbnailUrl,
    'title': title,
    'videoId': videoId,
    'durationLabel': durationLabel,
  };
}
