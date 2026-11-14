import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_glyphs.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Icon tile`: 36px, r11, `#108B8B`, holding a white glyph. The API
/// names no product, so the glyph follows what the payment bought — the chart
/// for a community plan, the briefcase for a service quote. A **failed**
/// payment's tile is the same teal at 45% (measured from Figma's render:
/// `#8EC6C6` over the card's `#F6F6F6`); the glyph stays white.
class TransactionTile extends StatelessWidget {
  const TransactionTile({super.key, required this.kind, this.faded = false});

  final TransactionKind kind;
  final bool faded;

  static String asset(TransactionKind kind) => switch (kind) {
    TransactionKind.community => ProfileGlyphs.chart,
    TransactionKind.service => 'assets/icons/txn_briefcase.svg',
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
      child: SvgPicture.asset(asset(kind)),
    );
  }
}
