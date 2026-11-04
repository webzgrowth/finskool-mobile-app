import 'package:flutter/services.dart';

/// Auto-inserts `/` while the member types a date — `DDMMYYYY` becomes
/// `DD/MM/YYYY` as they go, rather than asking them to type the slashes
/// themselves. Used on the compliance screen's Date of Birth field.
///
/// Non-digit input (including a slash the member types themselves) is
/// dropped and the slashes are rebuilt from scratch each edit.
///
/// **A slash is written only *before* the digit that follows it**, never after
/// the last one. Writing it right after the 2nd and 4th digit (the first
/// version) meant deleting the slash in `12/` left `12`, which was instantly
/// rebuilt as `12/` — backspace appeared dead at every slash, and the member
/// could not edit the day or month once past it.
class DateSlashFormatter extends TextInputFormatter {
  const DateSlashFormatter();

  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');
    final limited = digits.length > 8 ? digits.substring(0, 8) : digits;

    final buffer = StringBuffer();
    for (var i = 0; i < limited.length; i++) {
      if (i == 2 || i == 4) buffer.write('/');
      buffer.write(limited[i]);
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
