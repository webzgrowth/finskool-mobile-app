import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One cell of a details grid: a 17.5px `#108B8B` disc holding Figma's white
/// glyph, to the **left** of a bold label, with the value beneath the label —
/// indented past the disc (24px from its left edge), not under it.
///
/// This inverts the usual emphasis: the label is the bold near-black one and
/// the value beneath it is the quiet one.
class DetailCell extends StatelessWidget {
  const DetailCell({
    super.key,
    required this.glyph,
    required this.label,
    this.value,
    this.trailing,
  }) : assert(value != null || trailing != null);

  /// An asset path (`assets/icons/sub_*.svg`), already white.
  final String glyph;
  final String label;
  final String? value;

  /// Replaces the value line — the auto-renew toggle is the only user.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Stack(
      children: [
        Positioned(top: 2, left: 0, child: _Disc(glyph)),
        Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(label, style: type.label),
              const SizedBox(height: 2),
              trailing ?? Text(value!, style: type.value),
            ],
          ),
        ),
      ],
    );
  }
}

class _Disc extends StatelessWidget {
  const _Disc(this.glyph);

  final String glyph;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 17.5,
      width: 17.5,
      alignment: Alignment.center,
      decoration: const BoxDecoration(
        color: AppPalette.badgeTeal,
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(glyph),
    );
  }
}

/// The hairline between two cells in a details grid: `#888780`, 0.3 wide.
/// Full-height, so it needs an `IntrinsicHeight` above the `Row` holding it.
class GridVRule extends StatelessWidget {
  const GridVRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
    width: 0.3,
    margin: const EdgeInsets.symmetric(horizontal: 6),
    color: AppPalette.ticketHint,
  );
}

/// The hairline between two rows of a details grid.
class GridHRule extends StatelessWidget {
  const GridHRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
    height: 0.3,
    margin: const EdgeInsets.symmetric(vertical: 11),
    color: AppPalette.ticketHint,
  );
}
