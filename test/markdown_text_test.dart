import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/markdown_text.dart';

void main() {
  test('bullets, headings and links collapse to plain text', () {
    expect(markdownToText('- one\n* two'), '• one\n• two');
    expect(markdownToText('## Heading'), 'Heading');
    expect(
      markdownToText('see [the docs](https://x.io) now'),
      'see the docs now',
    );
  });

  test('italics lose their markers but bold survives for boldSpans', () {
    expect(markdownToText('an *emphasised* word'), 'an emphasised word');
    expect(markdownToText('an _emphasised_ word'), 'an emphasised word');
    expect(markdownToText('a **bold** word'), 'a **bold** word');
  });
}
