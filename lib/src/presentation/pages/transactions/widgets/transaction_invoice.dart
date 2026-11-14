import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';

/// The Download tap, shared by the list and the detail screen.
///
/// It uses the app's one invoice machinery — [InvoiceDownloadBloc] calls the
/// row's own `invoice.downloadPath` for a fresh link on every tap, fetches the
/// PDF and hands it to the device's save dialog. A payment with no invoice (a
/// failed or under-review one) says so instead of calling the API with nothing.
void requestInvoice(BuildContext context, TransactionModel t) {
  final path = t.invoicePath;
  if (path == null) {
    AppSnack.show('No invoice is available for this payment yet.');
    return;
  }
  context.read<InvoiceDownloadBloc>().add(InvoiceDownloadEvent.requestedPath(path));
}

/// Wraps a screen so a finished download is saved and a failure is shown.
class InvoiceSaveListener extends StatelessWidget {
  const InvoiceSaveListener({super.key, required this.child});

  final Widget child;

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
    // The bytes are never held past their use.
    bloc.add(const InvoiceDownloadEvent.reset());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InvoiceDownloadBloc, InvoiceDownloadState>(
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
      child: child,
    );
  }
}
