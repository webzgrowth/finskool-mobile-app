import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/comman/widgets/teal_sheet_scaffold.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';

import '../widgets/transaction_invoice.dart';
import '../widgets/transaction_status_note.dart';
import '../widgets/transaction_summary_row.dart';
import 'transaction_invoice_button.dart';

/// One payment's receipt. **Not in Figma** — the design draws only the list —
/// so it is built from the Subscription Detail chrome (the teal hero and sheet,
/// a `TealSectionCard` of `DetailCell`s, a teal Download bar) and the list
/// card's own summary row. Flag it for the designer.
class TransactionDetailScreen extends StatelessWidget {
  const TransactionDetailScreen({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      // Route-scoped: it briefly holds an invoice's bytes.
      create: (_) => locator<InvoiceDownloadBloc>(),
      child: TransactionDetailView(transaction: transaction),
    );
  }
}

/// The screen minus its bloc, public so a test can supply a ready one.
class TransactionDetailView extends StatelessWidget {
  const TransactionDetailView({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    return InvoiceSaveListener(
      child: TealSheetScaffold(
        sheetOffset: 56,
        children: [
          _Back(onTap: () => context.pop()),
          const SizedBox(height: 7),
          TicketCard(child: TransactionSummaryRow(transaction: t)),
          const SizedBox(height: 14),
          if (!t.isPaid) ...[
            TransactionStatusNote(transaction: t, plate: true),
            const SizedBox(height: 16),
          ],
          _Details(transaction: t),
          const SizedBox(height: 14),
          if (t.isPaid) TransactionInvoiceButton(transaction: t),
        ],
      ),
    );
  }
}

class _Back extends StatelessWidget {
  const _Back({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) =>
      SheetBackArrow(onTap: onTap, filled: true);
}

/// "Payment details": two cells per row, divided by the grid's hairlines.
class _Details extends StatelessWidget {
  const _Details({required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final t = transaction;
    // Only what the API sent, paired two to a row: a failed payment has no
    // invoice number, a card-less one no method, and the grid shows no dashes.
    final cells = <_Cell>[
      if (t.invoiceNumber != null)
        _Cell('sub_copy', 'Invoice', t.invoiceNumber!),
      _Cell('sub_calendar_check', switch (t.status) {
        TransactionStatus.paid => 'Paid on',
        TransactionStatus.failed => 'Attempted on',
        TransactionStatus.flagged => 'Received on',
      }, formatIst(t.occurredAt, 'd MMM yyyy,\nh:mm a')),
      if (t.kind == TransactionKind.service && t.reference != null)
        _Cell('sub_plan', 'Request', t.reference!),
      if (t.planName != null) _Cell('sub_plan', 'Plan', t.planName!),
      if (t.planDuration != null)
        _Cell('sub_calendar_add', 'Duration', t.planDuration!),
      _Cell('sub_dollar', 'Amount', t.amountLabel),
      if (t.methodLabel != null)
        _Cell('sub_card', 'Payment method', t.methodLabel!),
      if (t.paymentId != null) _Cell('sub_copy', 'Payment ID', t.paymentId!),
    ];
    final rows = <(_Cell, _Cell?)>[
      for (var i = 0; i < cells.length; i += 2)
        (cells[i], i + 1 < cells.length ? cells[i + 1] : null),
    ];
    return TealSectionCard(
      title: 'Payment details',
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            if (i > 0) const GridHRule(),
            _CellRow(left: rows[i].$1, right: rows[i].$2),
          ],
        ],
      ),
    );
  }
}

class _Cell {
  const _Cell(this.glyph, this.label, this.value);

  final String glyph;
  final String label;
  final String value;

  Widget build() =>
      DetailCell(glyph: 'assets/icons/$glyph.svg', label: label, value: value);
}

class _CellRow extends StatelessWidget {
  const _CellRow({required this.left, required this.right});

  final _Cell left;
  final _Cell? right;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(child: left.build()),
            // A lone last cell has nothing to divide from.
            if (right != null) ...[
              const GridVRule(),
              Expanded(child: right!.build()),
            ] else
              const Spacer(),
          ],
        ),
      ),
    );
  }
}
