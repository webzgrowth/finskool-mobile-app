import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// What a payment that is not simply "paid" needs to say.
///
/// * **Failed** — the backend's `failureReason`, verbatim, in red. Only when it
///   sent none is there local wording (the API guarantees nothing was deducted).
/// * **Under review** — the money arrived but could not be applied. The
///   backend sends no text for it, so this is ours, and it must not invite a
///   second payment.
///
/// [plate] gives it the red/amber tinted box the detail screen uses; without
/// it, it is the bare row at the foot of a list card.
class TransactionStatusNote extends StatelessWidget {
  const TransactionStatusNote({
    super.key,
    required this.transaction,
    this.plate = false,
  });

  final TransactionModel transaction;
  final bool plate;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    final type = context.transactionType;
    final review = t.isFlagged;
    final text = review
        ? 'We received your payment and our team is looking into it. '
              'You do not need to pay again.'
        : t.failureReason ?? 'The payment did not go through.';
    final row = Row(
      crossAxisAlignment: plate
          ? CrossAxisAlignment.start
          : CrossAxisAlignment.center,
      children: [
        review
            ? const Icon(
                Icons.schedule_rounded,
                size: 14,
                color: AppPalette.ticketProgressInk,
              )
            : SvgPicture.asset('assets/icons/txn_alert.svg'),
        SizedBox(width: plate ? 8 : 6),
        Expanded(
          child: Text(
            text,
            style: review
                ? type.failedNote.copyWith(color: AppPalette.ticketProgressInk)
                : type.failedNote,
          ),
        ),
      ],
    );
    if (!plate) return row;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: review
            ? AppPalette.ticketProgressSurface
            : AppPalette.ticketOpenSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: row,
    );
  }
}
