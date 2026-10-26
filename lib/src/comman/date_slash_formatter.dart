import 'package:flutter/services.dart';

/// Auto-inserts `/` while the member types a date — `DDMMYYYY` becomes
/// `DD/MM/YYYY` (or `DD/MM/YY` if they stop at 6 digits) as they go, rather
/// than asking them to type the slashes themselves. Used on the compliance
/// screen's Date of Birth field, which `_dobPattern`
/// (`compliance_validation.dart`) accepts in either length.
///
/// Non-digit input (including a slash the member types themselves) is
/// dropped and the slashes are rebuilt from scratch each edit — simplest
/// correct behaviour for a field this short, and it makes backspacing
/// through a slash just delete the digit before it, which is what someone
/// deleting through a date expects.
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
      buffer.write(limited[i]);
      if (i == 1 || i == 3) buffer.write('/');
    }

    final text = buffer.toString();
    return TextEditingValue(
      text: text,
      selection: TextSelection.collapsed(offset: text.length),
    );
  }
}
