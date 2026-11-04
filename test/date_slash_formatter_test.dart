import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/date_slash_formatter.dart';

/// Types or deletes the way a keyboard would: the old value plus the one edit.
String _edit(String from, String to) => const DateSlashFormatter()
    .formatEditUpdate(TextEditingValue(text: from), TextEditingValue(text: to))
    .text;

void main() {
  test('slashes appear as the next digit is typed, never trailing', () {
    expect(_edit('', '1'), '1');
    expect(_edit('1', '12'), '12');
    expect(_edit('12', '123'), '12/3');
    expect(_edit('12/0', '12/04'), '12/04');
    expect(_edit('12/04', '12/041'), '12/04/1');
    expect(_edit('12/04/199', '12/04/1995'), '12/04/1995');
    expect(_edit('12/04/1995', '12/04/19955'), '12/04/1995', reason: 'capped');
  });

  test('backspace walks back through the slashes instead of sticking', () {
    // Deleting the "3" in "12/3" leaves "12/" — which must become "12", so the
    // next backspace removes a digit. It used to rebuild "12/" forever.
    expect(_edit('12/3', '12/'), '12');
    expect(_edit('12', '1'), '1');
    expect(_edit('12/04/1', '12/04/'), '12/04');
    expect(_edit('12/04', '12/0'), '12/0');
  });

  test('typed slashes and letters are dropped', () {
    expect(_edit('12', '12/'), '12');
    expect(_edit('1', '1a'), '1');
  });
}
