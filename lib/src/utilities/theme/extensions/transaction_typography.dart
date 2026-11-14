import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

TextStyle _i(double size, double weight, double height, Color color) => inter(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

TextStyle _m(double size, double weight, double height, Color color) => manrope(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

/// Transaction history's type scale, read from Figma's **Final** page
/// (`Profile / Transaction History – V1`, `1809:5414`). The title, subtitle and
/// status pill reuse [TicketTypography] — the design uses the same styles —
/// so only what is new to this screen lives here. `letterSpacing` is pinned to
/// 0 for the reason given there.
@immutable
class TransactionTypography extends ThemeExtension<TransactionTypography> {
  const TransactionTypography({
    required this.amount,
    required this.amountFailed,
    required this.invoiceLabel,
    required this.invoiceNumber,
    required this.download,
    required this.failedNote,
    required this.footnote,
    required this.detailTitle,
  });

  /// Manrope 700 · 15, `#12201F`.
  final TextStyle amount;

  /// The same, in the muted grey a failed payment's amount is drawn in.
  final TextStyle amountFailed;

  /// Inter 400 · 10.
  final TextStyle invoiceLabel;

  /// Inter 600 · 11.
  final TextStyle invoiceNumber;

  /// Inter 600 · 11, teal.
  final TextStyle download;

  /// Inter 500 · 11, red.
  final TextStyle failedNote;

  /// Inter 400 · 11, muted, centred under the list.
  final TextStyle footnote;

  /// The detail screen's headline amount (not in Figma).
  final TextStyle detailTitle;

  static final TransactionTypography light = TransactionTypography(
    amount: _m(15, 700, 20 / 15, AppPalette.ticketInk),
    amountFailed: _m(15, 700, 20 / 15, AppPalette.ticketMuted),
    invoiceLabel: _i(10, 400, 12 / 10, AppPalette.ticketMuted),
    invoiceNumber: _i(11, 600, 13 / 11, AppPalette.ticketInk),
    download: _i(11, 600, 13 / 11, AppPalette.badgeTeal),
    failedNote: _i(11, 500, 13 / 11, AppPalette.ticketRed),
    footnote: _i(11, 400, 13 / 11, AppPalette.ticketMuted),
    detailTitle: _m(22, 700, 1.3, AppPalette.ticketInk),
  );

  static TransactionTypography of(Brightness brightness) => light;

  @override
  TransactionTypography copyWith() => this;

  @override
  TransactionTypography lerp(
    ThemeExtension<TransactionTypography>? other,
    double t,
  ) => this;
}

extension TransactionTypographyX on BuildContext {
  TransactionTypography get transactionType =>
      Theme.of(this).extension<TransactionTypography>()!;
}
