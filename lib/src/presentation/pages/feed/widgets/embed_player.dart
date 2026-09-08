import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

/// Renders a YouTube/Instagram embed URL inline via a WebView — true
/// in-feed playback rather than a tap-to-open-externally thumbnail.
class EmbedPlayer extends StatefulWidget {
  const EmbedPlayer({super.key, required this.embedUrl});

  final String embedUrl;

  @override
  State<EmbedPlayer> createState() => _EmbedPlayerState();
}

class _EmbedPlayerState extends State<EmbedPlayer> {
  late final WebViewController _controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setBackgroundColor(Colors.black)
    ..loadRequest(Uri.parse(widget.embedUrl));

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: WebViewWidget(controller: _controller),
    );
  }
}
