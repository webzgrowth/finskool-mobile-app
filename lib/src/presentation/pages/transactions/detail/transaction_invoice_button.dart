import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../widgets/transaction_invoice.dart';

/// "Download Invoice" — the same 32px teal bar the Subscription Detail screen
/// ends its Transaction card with, so the two receipts read alike.
class TransactionInvoiceButton extends StatelessWidget {
  const TransactionInvoiceButton({super.key, required this.transaction});

  final TransactionModel transaction;

  @override
  Widget build(BuildContext context) {
    final busy = context.watch<InvoiceDownloadBloc>().state.state.isLoading;
    return Semantics(
      button: true,
      label: 'Download invoice ${transaction.invoiceNumber ?? ''}',
      child: GestureDetector(
        onTap: busy ? null : () => requestInvoice(context, transaction),
        child: Container(
          height: 32,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppPalette.badgeTeal,
            borderRadius: BorderRadius.circular(10),
          ),
          child: busy
              ? SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
                )
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Download Invoice',
                      style: context.subscriptionType.buttonLabel,
                    ),
                    const SizedBox(width: 4),
                    SvgPicture.asset('assets/icons/sub_download.svg'),
                  ],
                ),
        ),
      ),
    );
  }
}
