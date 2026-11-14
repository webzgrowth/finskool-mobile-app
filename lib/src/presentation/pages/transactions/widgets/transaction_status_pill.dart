import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Status / Paid` and `Status / Failed`: a 21px pill, a 6px dot and a
/// label in one colour, padded 8 left (where the dot is) and 10 right. The same
/// shape as the ticket status pill, in the green and red the transaction frames
/// use. **Under review** (money received but not yet applied) is not drawn in
/// Figma; it takes the ticket "in progress" amber.
class TransactionStatusPill extends StatelessWidget {
  const TransactionStatusPill({super.key, required this.status});

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final (label, ink, surface) = switch (status) {
      TransactionStatus.paid => (
        'Paid',
        AppPalette.ticketResolvedInk,
        AppPalette.ticketResolvedSurface,
      ),
      TransactionStatus.failed => (
        'Failed',
        AppPalette.ticketRed,
        AppPalette.ticketOpenSurface,
      ),
      TransactionStatus.flagged => (
        'Under review',
        AppPalette.ticketProgressInk,
        AppPalette.ticketProgressSurface,
      ),
    };
    final style = context.ticketType.statusPill.copyWith(color: ink);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
      decoration: BoxDecoration(
        color: surface,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 6,
            width: 6,
            decoration: BoxDecoration(color: ink, shape: BoxShape.circle),
          ),
          const SizedBox(width: 6),
          Text(label, style: style),
        ],
      ),
    );
  }
}
