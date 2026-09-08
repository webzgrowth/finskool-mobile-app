/// A single item in a [FeedPostModel]'s media carousel.
///
/// `youtubeEmbed`/`instagramEmbed` are rendered inline via a WebView
/// (`webview_flutter`) — see `widgets/embed_player.dart`. Native
/// uploaded-video playback is out of scope; the "01:11"-style duration
/// badge on an `image` item is purely decorative.
enum PostMediaType { image, youtubeEmbed, instagramEmbed }

class PostMediaModel {
  const PostMediaModel({
    required this.type,
    required this.imageUrl,
    this.embedUrl,
    this.durationLabel,
  });

  final PostMediaType type;
  final String imageUrl;
  final String? embedUrl;
  final String? durationLabel;

  factory PostMediaModel.fromJson(Map<String, dynamic> json) =>
      PostMediaModel(
        type: PostMediaType.values.firstWhere((t) => t.name == json['type']),
        imageUrl: json['imageUrl'] as String,
        embedUrl: json['embedUrl'] as String?,
        durationLabel: json['durationLabel'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'type': type.name,
        'imageUrl': imageUrl,
        'embedUrl': embedUrl,
        'durationLabel': durationLabel,
      };
}
