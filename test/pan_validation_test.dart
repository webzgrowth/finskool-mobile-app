import 'package:flutter_test/flutter_test.dart';

/// Mirrors `compliance_validation.dart`'s `_panPattern` — kept in sync
/// rather than imported, since that pattern is private to the extension
/// file. If the real pattern changes, update this one too.
final _panPattern = RegExp(r'^[A-Z]{3}[PCHABGJLFT][A-Z][0-9]{4}[A-Z]$');

void main() {
  test('accepts a real-format PAN for every holder type', () {
    for (final type in ['P', 'C', 'H', 'A', 'B', 'G', 'J', 'L', 'F', 'T']) {
      expect(_panPattern.hasMatch('AAA${type}L1234C'), isTrue, reason: type);
    }
  });

  test('rejects a 4th character that is not a real holder-type code', () {
    // Old regex (5 letters + 4 digits + 1 letter) accepted this; a real PAN
    // never has 'D' as its 4th character.
    expect(_panPattern.hasMatch('ABCDE1234F'), isFalse);
  });

  test('rejects wrong lengths and digit/letter swaps', () {
    expect(_panPattern.hasMatch('AAAPL12345'), isFalse); // 5 digits
    expect(_panPattern.hasMatch('AAAPL123C'), isFalse); // 3 digits
    expect(_panPattern.hasMatch('AAAP11234C'), isFalse); // digit at pos 5
  });
}
