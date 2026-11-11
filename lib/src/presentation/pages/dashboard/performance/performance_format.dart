import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "1,231" / "-3,780" — whole rupees, Indian-style grouping is not used:
/// Figma groups by thousands ("50,000", "3,594").
String formatAmount(num value) {
  final negative = value < 0;
  final digits = value.abs().round().toString();
  final grouped = digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
  return negative ? '-$grouped' : grouped;
}

/// Green for a gain, red for a loss.
Color pnlColor(num value) =>
    value < 0 ? AppPalette.ticketRed : AppPalette.perfProfit;

const _months = [
  'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
  'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec', //
];

/// "24 Aug 2026".
String formatTradeDate(DateTime d) =>
    '${d.day} ${_months[d.month - 1]} ${d.year}';

/// "1,231.50"-style price, two decimals.
String formatPrice(num value) => value.toStringAsFixed(2);

/// "3.39%" / "-3.39%" — for a plain share (hit rate, a split), never a gain.
String formatPct(num value) => '${value.toStringAsFixed(2)}%';

/// A profit or loss percentage, signed both ways: "+1.23%", "-14.79%". Zero —
/// and anything that rounds to it — is a bare "0.00%", never "+0.00%" or
/// "-0.00%".
String formatSignedPct(num value) {
  final text = value.abs().toStringAsFixed(2);
  if (double.parse(text) == 0) return '0.00%';
  return '${value < 0 ? '-' : '+'}$text%';
}

/// The "#48 · " lead of a trade's meta line, or '' when there is no S.N.
String serialLead(int? number) =>
    number == null ? '' : '#${number.toString().padLeft(2, '0')}  ·  ';

/// "Oct 26" for `2026-10`.
String formatMonth(String yearMonth) {
  final parts = yearMonth.split('-');
  final month = int.tryParse(parts.length > 1 ? parts[1] : '');
  if (month == null || month < 1 || month > 12) return yearMonth;
  return '${_months[month - 1]} ${parts[0].substring(2)}';
}

const _longMonths = [
  'January', 'February', 'March', 'April', 'May', 'June',
  'July', 'August', 'September', 'October', 'November', 'December', //
];

/// "August 2026" for `2026-08` — how the month pickers name a month.
String formatMonthLong(String yearMonth) {
  final parts = yearMonth.split('-');
  final month = int.tryParse(parts.length > 1 ? parts[1] : '');
  if (month == null || month < 1 || month > 12) return yearMonth;
  return '${_longMonths[month - 1]} ${parts[0]}';
}
