import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'transaction_status_pill.dart';
import 'transaction_tile.dart';

/// Figma's `Main`: the tile, the title over "plan · date", and the amount over
/// the status pill on the right. 12 between the three columns; the title may
/// wrap to two lines (the academy's does), and the row is as tall as the
/// tallest column. Shared by the list card and the detail screen.
class TransactionSummaryRow extends StatelessWidget {
  const TransactionSummaryRow({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final ticket = context.ticketType;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TransactionTile(kind: t.kind, faded: t.isFailed),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(t.title, style: ticket.cardSubject),
              const SizedBox(height: 4),
              Text(t.subtitle, style: ticket.meta),
            ],
          ),
        ),
        const SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              t.amountLabel,
              style: t.isFailed
                  ? context.transactionType.amountFailed
                  : context.transactionType.amount,
            ),
            const SizedBox(height: 6),
            TransactionStatusPill(status: t.status),
          ],
        ),
      ],
    );
  }
}
