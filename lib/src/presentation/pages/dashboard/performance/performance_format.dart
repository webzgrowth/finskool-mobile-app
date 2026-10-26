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
