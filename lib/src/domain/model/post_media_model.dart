import 'package:finskool/src/comman/embed_urls.dart';

/// A single item in a [FeedPostModel]'s media carousel.
///
/// Third-party embeds (Instagram, Vimeo, anything with no raw file URL) are
/// rendered inline via a WebView (`widgets/embed_player.dart`). A genuine
/// uploaded video file — [nativeVideo], sniffed by its own URL's extension
/// (see [looksLikeVideoFile]) rather than trusted to an unconfirmed `kind`
/// string — plays through `widgets/native_video_player.dart` instead
/// (`video_player`, a real decoder, not a WebView asked to open a raw media
/// URL it was never built for). [videoEmbed] is the fallback for a `kind`
/// this build doesn't otherwise recognise and that doesn't look like a raw
/// file either — still handed to the WebView rather than being dropped.
enum PostMediaType {
  image,
  youtubeEmbed,
  instagramEmbed,
  videoEmbed,
  nativeVideo,
}

/// Common raw video containers a server might link to directly. Checked
/// against the URL's path (query strings and all) rather than its end, since
/// a signed/CDN URL often has `?token=…` after the extension.
final _videoFileExtensions = RegExp(
  r'\.(mp4|mov|m4v|webm|mkv)(\?|$)',
  caseSensitive: false,
);

/// True for a URL that points at a raw video file a real decoder can open —
/// as opposed to an embed *page* (a YouTube/Instagram/Vimeo URL), which a
/// video decoder can't do anything with.
bool looksLikeVideoFile(String url) => _videoFileExtensions.hasMatch(url);

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

  /// How tall the carousel should be for this item (images resolve their own
  /// ratio — see `_FeedImage` — so this only governs the embed/video types).
  ///
  /// * Instagram's embed is portrait; a landscape box crops its picture and
  ///   account header off, so it keeps 4:5.
  /// * **YouTube / native / other video is 16:9, not Figma's 332:171.** The
  ///   332:171 media box (1.94) is a hair *shorter* than 16:9, and the
  ///   `youtube_player_flutter` controls overlay lays its title bar, spacer
  ///   and bottom bar in a fixed-height `Column` bounded by this ratio — at
  ///   1.94 that Column is ~3px too tall for its box and throws a RenderFlex
  ///   overflow (a `ClipRect` can't suppress a Flex assertion). 16:9 is the
  ///   video's real ratio anyway and gives the controls the room they need.
  double get aspectRatio => switch (type) {
    PostMediaType.instagramEmbed => 4 / 5,
    PostMediaType.image => 332 / 171, // fallback only, until `_FeedImage` loads
    _ => 16 / 9,
  };

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
        : looksLikeVideoFile(url)
        ? PostMediaType.nativeVideo
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

    // The raw file URL, if either field carries one. Preferred over
    // [playable] for a native video: an admin upload's `url` is the real
    // `.mp4`, while `embedUrl` — if the backend even sets it — would be a
    // player *page* a decoder can't open, and [playable] prefers `embedUrl`.
    final rawFile = [url, embedUrl].firstWhere(
      (u) => u != null && u.isNotEmpty && looksLikeVideoFile(u),
      orElse: () => null,
    );

    // A genuine uploaded video, decided by the file itself where possible and
    // by an upload-ish `kind` only as a fallback (a signed/CDN URL can lack a
    // recognisable extension). YouTube/Instagram always win first.
    const nativeKinds = {'upload', 'video', 'file', 'native', 'raw'};
    final isNative =
        kind != 'youtube' &&
        kind != 'instagram' &&
        (rawFile != null || (kind != null && nativeKinds.contains(kind)));

    final type = kind == 'youtube'
        ? PostMediaType.youtubeEmbed
        : kind == 'instagram'
        ? PostMediaType.instagramEmbed
        : isNative
        ? PostMediaType.nativeVideo
        // A real embed *page* (Vimeo and the like) still goes to the WebView —
        // better than dropping it for not being on a list.
        : PostMediaType.videoEmbed;

    // A native video must carry its raw file URL, not a player-page embedUrl.
    final src = isNative ? (rawFile ?? url ?? playable) : playable;

    return PostMediaModel(
      type: type,
      imageUrl: src,
      embedUrl: src,
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
