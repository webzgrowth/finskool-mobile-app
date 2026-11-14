import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Status / Paid` and `Status / Failed`: a 21px pill, a 6px dot and a
/// label in one colour, padded 8 left (where the dot is) and 10 right. The same
/// shape as the ticket status pill, in the green and red the transaction frames
/// use.
class TransactionStatusPill extends StatelessWidget {
  const TransactionStatusPill({super.key, required this.status});

  final TransactionStatus status;

  @override
  Widget build(BuildContext context) {
    final paid = status == TransactionStatus.paid;
    final ink = paid ? AppPalette.ticketResolvedInk : AppPalette.ticketRed;
    final style = context.ticketType.statusPill.copyWith(color: ink);
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 10, 4),
      decoration: BoxDecoration(
        color: paid
            ? AppPalette.ticketResolvedSurface
            : AppPalette.ticketOpenSurface,
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
          Text(paid ? 'Paid' : 'Failed', style: style),
        ],
      ),
    );
  }
}
