import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';
import 'package:finskool/src/domain/model/community/subscription_invoice.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Transaction Details — the receipt, then Download Invoice (a 32px teal bar).
///
/// The button is real: it downloads the invoice PDF inside the app
/// (`GET /payments/receipts/{id}/download` for a **fresh** signed link, then the
/// file itself, via [InvoiceDownloadBloc]) and opens the device's own save
/// dialog — Files on iPhone, the Downloads picker on Android — so it ends up on
/// the phone rather than in a browser tab. It is always drawn, as in Figma;
/// when [invoice] is null — a member an admin added never paid through the app,
/// or the server has none for this purchase — it is dimmed and a tap says so,
/// rather than vanishing and leaving the member wondering where it went.
class SubscriptionTransactionSection extends StatelessWidget {
  const SubscriptionTransactionSection({
    super.key,
    required this.info,
    this.invoice,
  });

  final SubscriptionInfo info;
  final SubscriptionInvoice? invoice;

  @override
  Widget build(BuildContext context) {
    return TealSectionCard(
      title: 'Transaction Details',
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 57),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 92,
                    child: DetailCell(
                      glyph: 'assets/icons/sub_copy.svg',
                      label: 'ID',
                      value: info.transactionId,
                    ),
                  ),
                  const GridVRule(),
                  Expanded(
                    flex: 100,
                    child: DetailCell(
                      glyph: 'assets/icons/sub_calendar_add.svg',
                      label: 'Paid on',
                      value: DateFormat('d MMM yyyy,\nh:mm a')
                          .format(info.paidOn),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          if (invoice != null)
            _InvoiceButton(invoice: invoice!)
          else
            const _NoInvoiceButton(),
        ],
      ),
    );
  }
}

/// Download Invoice when the server has no invoice for this subscription.
class _NoInvoiceButton extends StatelessWidget {
  const _NoInvoiceButton();

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Semantics(
      button: true,
      enabled: false,
      label: 'Download invoice, not available',
      child: GestureDetector(
        onTap: () =>
            AppSnack.show('No invoice is available for this subscription yet.'),
        child: Opacity(
          opacity: 0.45,
          child: Container(
            height: 32,
            width: double.infinity,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppPalette.badgeTeal,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Download Invoice', style: type.buttonLabel),
                const SizedBox(width: 4),
                SvgPicture.asset('assets/icons/sub_download.svg'),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _InvoiceButton extends StatelessWidget {
  const _InvoiceButton({required this.invoice});

  final SubscriptionInvoice invoice;

  /// Hands the downloaded PDF to the device's save dialog. `null` back means
  /// the member dismissed it, which needs no message. Either way the bytes are
  /// dropped from the bloc afterwards.
  Future<void> _save(BuildContext context, InvoiceFile file) async {
    final bloc = context.read<InvoiceDownloadBloc>();
    try {
      final saved = await FilePicker.saveFile(
        dialogTitle: 'Save invoice',
        fileName: file.fileName,
        bytes: file.bytes,
        mimeType: 'application/pdf',
        type: FileType.custom,
        allowedExtensions: const ['pdf'],
      );
      if (saved != null) AppSnack.show('Invoice saved.');
    } catch (_) {
      AppSnack.show('Could not save the invoice.');
    }
    bloc.add(const InvoiceDownloadEvent.reset());
  }

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return BlocConsumer<InvoiceDownloadBloc, InvoiceDownloadState>(
      listenWhen: (p, c) => p.state != c.state,
      listener: (context, state) {
        final file = state.file;
        if (state.state.isLoaded && file != null) {
          _save(context, file);
        } else if (state.state.isError) {
          AppSnack.show(state.message);
          context.read<InvoiceDownloadBloc>().add(
            const InvoiceDownloadEvent.reset(),
          );
        }
      },
      builder: (context, state) {
        final busy = state.state.isLoading;
        return Semantics(
          button: true,
          enabled: !busy,
          label: 'Download invoice ${invoice.number}',
          child: GestureDetector(
            // A second tap while the first is fetching asks for nothing.
            onTap: busy
                ? null
                : () => context.read<InvoiceDownloadBloc>().add(
                    InvoiceDownloadEvent.requested(invoice.id),
                  ),
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
                        Text('Download Invoice', style: type.buttonLabel),
                        const SizedBox(width: 4),
                        SvgPicture.asset('assets/icons/sub_download.svg'),
                      ],
                    ),
            ),
          ),
        );
      },
    );
  }
}
