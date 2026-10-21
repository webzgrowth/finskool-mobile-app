import 'package:flutter/painting.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/html_spans.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';

const base = TextStyle(fontSize: 10);
const bold = TextStyle(fontSize: 10, fontWeight: FontWeight.w700);

String render(String html) =>
    bodySpans(html, base, bold).map((s) => s.text).join();

void main() {
  test('tags do not leak into the rendered text', () {
    expect(render('<p>test</p>'), 'test');
  });

  test('paragraphs separate, without a leading or trailing blank', () {
    expect(render('<p>a</p><p>b</p>'), 'a\n\nb');
    expect(render('<p>a</p><p></p>'), 'a');
  });

  test('bold and italic runs carry their style', () {
    final spans = bodySpans(
      '<p>a <strong>b</strong> <em>c</em></p>',
      base,
      bold,
    );
    expect(
      spans.firstWhere((s) => s.text == 'b').style!.fontWeight,
      FontWeight.w700,
    );
    expect(
      spans.firstWhere((s) => s.text == 'c').style!.fontStyle,
      FontStyle.italic,
    );
  });

  test('lists get bullets, br breaks a single line', () {
    expect(render('<ul><li>one</li><li>two</li></ul>'), '• one\n• two');
    expect(render('<p>a<br>b</p>'), 'a\nb');
  });

  test('entities are unescaped', () {
    expect(
      render('<p>Tata&nbsp;&amp;&nbsp;Sons &#8377;100</p>'),
      'Tata & Sons ₹100',
    );
  });

  test('markdown still renders when no HTML is present', () {
    final spans = bodySpans('plain **bold** tail', base, bold);
    expect(spans.map((s) => s.text).join(), 'plain bold tail');
    expect(spans[1].style!.fontWeight, FontWeight.w700);
  });

  test('inline img srcs are extracted, in all quoting styles', () {
    expect(
      htmlImageUrls(
        '<p>x</p><img src="a.png"/><IMG SRC=\'b.png\'><img src=c.png>',
      ),
      ['a.png', 'b.png', 'c.png'],
    );
    expect(htmlImageUrls('<p>no pictures</p>'), isEmpty);
  });
}
