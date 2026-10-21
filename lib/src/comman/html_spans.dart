import 'package:flutter/painting.dart';

/// Renders a post body that arrives as **HTML**.
///
/// `GET /mobile/posts` documents `content` as "Markdown source", but the
/// admin side composes posts in a rich-text editor, so what actually arrives
/// is HTML (`<p>test</p>`). Rendering it raw put the tags on screen.
///
/// This is a deliberately small subset — the tags a rich-text editor emits —
/// rather than a dependency on `flutter_html`: bold, italic, line structure
/// and list bullets. Anything else is dropped to its text content, which
/// degrades to plain paragraphs rather than to markup leaking into the UI.
/// Reach for a real HTML package only if posts start carrying tables, images
/// or links that have to be tappable.
List<TextSpan> htmlSpans(String html, TextStyle base, TextStyle bold) {
  final spans = <TextSpan>[];
  final buffer = StringBuffer();
  var depthBold = 0;
  var depthItalic = 0;

  void flush() {
    if (buffer.isEmpty) return;
    spans.add(
      TextSpan(
        text: buffer.toString(),
        style: depthBold > 0
            ? (depthItalic > 0
                  ? bold.copyWith(fontStyle: FontStyle.italic)
                  : bold)
            : (depthItalic > 0
                  ? base.copyWith(fontStyle: FontStyle.italic)
                  : base),
      ),
    );
    buffer.clear();
  }

  /// A block boundary is one blank line at most, and never a leading one —
  /// `<p>a</p><p>b</p>` must not open the body with an empty row.
  void breakLine({bool paragraph = false}) {
    final sofar = buffer.toString();
    if (sofar.isEmpty && spans.isEmpty) return;
    if (sofar.endsWith('\n\n') || (sofar.endsWith('\n') && !paragraph)) return;
    buffer.write(paragraph && !sofar.endsWith('\n') ? '\n\n' : '\n');
  }

  for (final token in _tokens.allMatches(html)) {
    final tag = token.group(1);
    if (tag == null) {
      buffer.write(_unescape(token.group(0)!));
      continue;
    }
    final closing = tag.startsWith('/');
    final name = tag.replaceFirst('/', '').split(RegExp(r'[\s/>]')).first;
    switch (name.toLowerCase()) {
      case 'b' || 'strong':
        flush();
        depthBold += closing ? -1 : 1;
      case 'i' || 'em':
        flush();
        depthItalic += closing ? -1 : 1;
      case 'br':
        breakLine();
      case 'p' || 'div' || 'h1' || 'h2' || 'h3' || 'h4' || 'h5' || 'h6':
        breakLine(paragraph: true);
      case 'li':
        breakLine();
        if (!closing) buffer.write('• ');
      case 'ul' || 'ol' || 'blockquote':
        breakLine(paragraph: true);
    }
  }
  flush();

  // Editors routinely close with a trailing `<p></p>`, which would render as
  // dead vertical space under the body.
  if (spans.isNotEmpty) {
    final last = spans.removeLast();
    final trimmed = last.text!.trimRight();
    if (trimmed.isNotEmpty)
      spans.add(TextSpan(text: trimmed, style: last.style));
  }
  return spans;
}

/// Text runs and tags, in order. The text alternative is non-greedy up to the
/// next `<`, so a stray `<` in prose doesn't swallow the rest of the body.
final _tokens = RegExp(r'<([^>]+)>|[^<]+');

const _entities = {
  '&nbsp;': ' ',
  '&amp;': '&',
  '&lt;': '<',
  '&gt;': '>',
  '&quot;': '"',
  '&#39;': "'",
  '&apos;': "'",
};

String _unescape(String text) {
  var out = text;
  _entities.forEach((entity, char) => out = out.replaceAll(entity, char));
  return out.replaceAllMapped(
    RegExp(r'&#(\d+);'),
    (m) => String.fromCharCode(int.parse(m.group(1)!)),
  );
}

/// `src` of every `<img>` in an HTML body, in document order.
///
/// A rich-text composer embeds uploaded images inline in `content` rather
/// than listing them in `imageUrls`, so a post can carry pictures while that
/// array is empty. [htmlSpans] drops `<img>` (it has no text), so without
/// this they would be lost entirely.
List<String> htmlImageUrls(String html) => _img
    .allMatches(html)
    .map((m) => _unescape(m.group(1) ?? m.group(2) ?? m.group(3)!))
    .where((url) => url.isNotEmpty)
    .toList();

final _img = RegExp(
  '''<img[^>]*\\bsrc\\s*=\\s*(?:"([^"]*)"|'([^']*)'|([^\\s>]+))''',
  caseSensitive: false,
);
