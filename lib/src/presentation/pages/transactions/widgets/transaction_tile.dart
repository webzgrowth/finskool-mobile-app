import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_glyphs.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Icon tile`: 36px, r11, `#108B8B`, holding a white glyph — one per
/// product. A **failed** payment's tile is the same teal at 45% (measured from
/// Figma's render: `#8EC6C6` over the card's `#F6F6F6`); the glyph stays white.
///
/// Three glyphs are the Profile's own exports (the academy cap, the investor
/// pointer, the intraday chart); the pie and the briefcase are new
/// (`assets/icons/txn_*.svg`).
class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.glyph, this.faded = false});

  final TransactionGlyph glyph;
  final bool faded;

  static String asset(TransactionGlyph glyph) => switch (glyph) {
    TransactionGlyph.pie => 'assets/icons/txn_pie.svg',
    TransactionGlyph.briefcase => 'assets/icons/txn_briefcase.svg',
    TransactionGlyph.education => ProfileGlyphs.education,
    TransactionGlyph.investor => ProfileGlyphs.investor,
    TransactionGlyph.chart => ProfileGlyphs.chart,
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 36,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppPalette.badgeTeal.withValues(alpha: faded ? 0.45 : 1),
        borderRadius: BorderRadius.circular(11),
      ),
      child: SvgPicture.asset(asset(glyph)),
    );
  }
}
