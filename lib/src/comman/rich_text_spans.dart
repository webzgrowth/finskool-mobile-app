import 'package:flutter/painting.dart';

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
      spans.add(TextSpan(text: text.substring(index, match.start), style: base));
    }
    spans.add(TextSpan(text: match.group(1), style: bold));
    index = match.end;
  }
  if (index < text.length) {
    spans.add(TextSpan(text: text.substring(index), style: base));
  }
  return spans;
}
