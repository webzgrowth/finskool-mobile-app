import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/comman/widgets/success_animation.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'quote_card.dart';

/// Asks the chat bloc for the invoice PDF (it fetches the **short-lived** link
/// and downloads the file at once) and hands it to the device's save dialog —
/// Files on iPhone, the Downloads picker on Android — rather than a browser.
/// Requested on the tap, never cached; the first call after payment can take a
/// moment because the PDF is made on demand.
Future<void> downloadInvoice(BuildContext context, ServiceChatBloc chat) async {
  final result = Completer<InvoiceFile?>();
  chat.add(ServiceChatEvent.invoiceRequested(result));
  AppSnack.show('Preparing your invoice…');
  final file = await result.future;
  if (file == null) return; // the bloc already said why
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
}

/// The success screen: "Payment received", the amount, the invoice number and
/// a Download invoice button — shown from the **verify response**, not from
/// Checkout's callback.
Future<void> showPaymentReceivedSheet(
  BuildContext context, {
  required ServiceRequestModel paid,
  required ServiceChatBloc chat,
}) {
  final invoice = paid.invoice;
  return showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (sheet) {
      final type = sheet.ticketType;
      return Container(
        padding: EdgeInsets.fromLTRB(
          24,
          20,
          24,
          20 + MediaQuery.paddingOf(sheet).bottom,
        ),
        decoration: const BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SuccessAnimation(size: 110),
            Text('Payment received', style: type.headerTitle),
            const SizedBox(height: 6),
            if (invoice != null) ...[
              Text(
                rupees(invoice.total),
                style: type.headerTitle.copyWith(fontSize: 26),
              ),
              const SizedBox(height: 4),
              Text('Invoice ${invoice.number}', style: type.headerSubtitle),
            ],
            const SizedBox(height: 20),
            if (invoice != null)
              TicketButton(
                label: 'Download invoice',
                onTap: () => downloadInvoice(sheet, chat),
              ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () => Navigator.pop(sheet),
              child: const Text('Done'),
            ),
          ],
        ),
      );
    },
  );
}

/// The money arrived but the server could not apply it (the quote was replaced
/// or expired while the member paid). A system message is also posted in the
/// chat. **Never** offers to pay again.
Future<void> showUnderReviewDialog(BuildContext context) => showDialog<void>(
  context: context,
  builder: (dialog) => AlertDialog(
    title: const Text('Payment under review'),
    content: const Text(
      'We received your payment and our team will review it. '
      'You do not need to pay again.',
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(dialog),
        child: const Text('OK'),
      ),
    ],
  ),
);

/// "Confirming your payment…" — shown the moment Checkout reports success and
/// until the server has answered, so the member never sees a quote that still
/// says Pay while their money is in flight.
class ConfirmingPaymentOverlay extends StatelessWidget {
  const ConfirmingPaymentOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: const Color(0xB3FFFFFF),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const CircularProgressIndicator(),
            const SizedBox(height: 16),
            Text(
              'Confirming your payment…',
              style: context.ticketType.headerSubtitle,
            ),
          ],
        ),
      ),
    );
  }
}
