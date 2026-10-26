import 'package:flutter/painting.dart';

import 'rich_text_spans.dart';

/// Renders the markdown subset the admin's welcome-kit editor produces:
/// **bold** runs stay bold, `- ` / `* ` list lines get a bullet, headings lose
/// their `#`, and `[label](url)` / `*italic*` / `_italic_` collapse to their
/// plain text.
///
/// Deliberately a normaliser feeding [boldSpans], not a markdown engine:
/// links aren't tappable and italics aren't italic. Those are the two things
/// the API's "render them as markdown" note implies that this doesn't do —
/// worth a real package only if kits start leaning on them.
List<TextSpan> markdownSpans(String text, TextStyle base, TextStyle bold) =>
    boldSpans(markdownToText(text), base, bold);

String markdownToText(String markdown) {
  var text = markdown.replaceAll('\r\n', '\n');
  // `[label](url)` -> `label`
  text = text.replaceAllMapped(RegExp(r'\[([^\]]+)\]\([^)]*\)'), (m) => m[1]!);
  // Line-level markers.
  text = text
      .split('\n')
      .map((line) {
        final bullet = RegExp(r'^\s*[-*+]\s+(.*)$').firstMatch(line);
        if (bullet != null) return '• ${bullet[1]}';
        return line.replaceFirst(RegExp(r'^\s*#{1,6}\s+'), '');
      })
      .join('\n');
  // `*italic*` / `_italic_` (single markers only — `**bold**` is left alone).
  text = text.replaceAllMapped(
    RegExp(r'(?<![*\w])\*(?!\*)([^*\n]+?)(?<!\*)\*(?![*\w])'),
    (m) => m[1]!,
  );
  text = text.replaceAllMapped(
    RegExp(r'(?<![\w])_([^_\n]+?)_(?![\w])'),
    (m) => m[1]!,
  );
  return text.trim();
}
