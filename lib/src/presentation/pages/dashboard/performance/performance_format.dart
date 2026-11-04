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

/// "-3.39%".
String formatPct(num value) => '${value.toStringAsFixed(2)}%';

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
