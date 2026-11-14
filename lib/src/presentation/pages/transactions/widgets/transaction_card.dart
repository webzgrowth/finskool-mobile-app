import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'download_chip.dart';
import 'transaction_status_note.dart';
import 'transaction_summary_row.dart';

/// One payment in the list — Figma's `Transaction / INV-…` frame.
///
/// The ticket card's chrome (`#F6F6F6`, r16, a hairline border, a 14px shadow;
/// the border sits inside, so Figma's 14 padding + 1 stroke is the 15 the
/// children are measured at): the summary row, 12, a 1px rule, 12, then either
/// the invoice number with Download, or — for a payment that failed or is under
/// review — what happened, in words.
class TransactionCard extends StatelessWidget {
  const TransactionCard({
    super.key,
    required this.transaction,
    required this.onTap,
    required this.onDownload,
    this.downloading = false,
  });

  final TransactionModel transaction;
  final VoidCallback onTap;
  final VoidCallback onDownload;
  final bool downloading;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    return TicketCard(
      onTap: onTap,
      child: Column(
        children: [
          TransactionSummaryRow(transaction: t),
          const SizedBox(height: 12),
          Container(height: 1, color: AppPalette.ticketDivider),
          const SizedBox(height: 12),
          !t.isPaid
              ? TransactionStatusNote(transaction: t)
              : _InvoiceRow(
                  number: t.invoiceNumber,
                  onDownload: onDownload,
                  downloading: downloading,
                ),
        ],
      ),
    );
  }
}

class _InvoiceRow extends StatelessWidget {
  const _InvoiceRow({
    required this.number,
    required this.onDownload,
    required this.downloading,
  });

  final String? number;
  final VoidCallback onDownload;
  final bool downloading;

  @override
  Widget build(BuildContext context) {
    final type = context.transactionType;
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Invoice', style: type.invoiceLabel),
              const SizedBox(height: 1),
              Text(number ?? '—', style: type.invoiceNumber),
            ],
          ),
        ),
        DownloadChip(onTap: onDownload, busy: downloading),
      ],
    );
  }
}
