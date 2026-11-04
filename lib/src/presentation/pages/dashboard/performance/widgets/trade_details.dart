import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One label/value pair in a trade's expanded panel.
class DetailCell {
  const DetailCell(this.label, this.value, [this.color = AppPalette.cardTitle]);

  final String label;
  final String value;
  final Color color;
}

/// A trade's expanded panel: rows of equally wide cells with a hairline
/// between rows. Shared by the intraday and swing rows, which differ only in
/// which cells they pass.
class TradeDetailsGrid extends StatelessWidget {
  const TradeDetailsGrid({super.key, required this.rows});

  final List<List<DetailCell>> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppPalette.perfDetail,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Divider(
                  height: 1,
                  thickness: 1,
                  color: AppPalette.perfDetailRule,
                ),
              ),
            Row(
              children: [
                for (final cell in rows[i]) Expanded(child: _Cell(cell)),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  const _Cell(this.cell);

  final DetailCell cell;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(cell.label, style: type.detailLabel),
        const SizedBox(height: 3),
        Text(cell.value, style: type.detailValue.copyWith(color: cell.color)),
      ],
    );
  }
}
