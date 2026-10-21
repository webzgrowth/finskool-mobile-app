import 'package:flutter/painting.dart';

import 'html_spans.dart';

/// Splits `**bold**` runs out of a string into styled [TextSpan]s.
///
/// The Figma canvas annotates the community descriptions with "important
/// words in the description will be bold" (`921:21875`), so the mock copy
/// carries `**…**` markers and this turns them into real bold runs.
///
/// Unmatched `**` is left as literal text rather than swallowed, so a stray
/// marker shows up in the UI instead of silently eating the rest of the
/// sentence.
List<TextSpan> boldSpans(String text, TextStyle base, TextStyle bold) {
  final spans = <TextSpan>[];
  final pattern = RegExp(r'\*\*(.+?)\*\*', dotAll: true);
  var index = 0;

  for (final match in pattern.allMatches(text)) {
    if (match.start > index) {
      spans.add(
        TextSpan(text: text.substring(index, match.start), style: base),
      );
    }
    spans.add(TextSpan(text: match.group(1), style: bold));
    index = match.end;
  }
  if (index < text.length) {
    spans.add(TextSpan(text: text.substring(index), style: base));
  }
  return spans;
}

/// A post body, whichever of the two shapes the backend sends it in.
///
/// `GET /mobile/posts` calls `content` Markdown, but the admin composer emits
/// HTML — so sniff for a tag and route accordingly rather than picking one and
/// rendering the other's markup as literal text.
List<TextSpan> bodySpans(String text, TextStyle base, TextStyle bold) =>
    _htmlTag.hasMatch(text)
    ? htmlSpans(text, base, bold)
    : boldSpans(text, base, bold);

final _htmlTag = RegExp(r'<\s*/?\s*[a-zA-Z][^>]*>');
