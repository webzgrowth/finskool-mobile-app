import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/date_slash_formatter.dart';

TextEditingValue _tev(String text) => TextEditingValue(
  text: text,
  selection: TextSelection.collapsed(offset: text.length),
);

void main() {
  const formatter = DateSlashFormatter();

  test('inserts slashes after DD and MM as digits are typed', () {
    expect(formatter.formatEditUpdate(_tev(''), _tev('0')).text, '0');
    expect(formatter.formatEditUpdate(_tev('0'), _tev('01')).text, '01/');
    expect(formatter.formatEditUpdate(_tev('01/'), _tev('01/0')).text, '01/0');
    expect(
      formatter.formatEditUpdate(_tev('01/0'), _tev('01/01')).text,
      '01/01/',
    );
    expect(
      formatter.formatEditUpdate(_tev('01/01/'), _tev('01/01/2000')).text,
      '01/01/2000',
    );
  });

  test('caps at 8 digits (DDMMYYYY)', () {
    final result = formatter.formatEditUpdate(
      _tev('01/01/2000'),
      _tev('01/01/20009999'),
    );
    expect(result.text, '01/01/2000');
  });

  test('strips non-digit input, including a manually typed slash', () {
    expect(formatter.formatEditUpdate(_tev(''), _tev('a1/b2')).text, '12/');
  });
}
