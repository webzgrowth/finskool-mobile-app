import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/presentation/bloc/services/chat/service_chat_bloc.dart';
import 'package:finskool/src/presentation/pages/services/widgets/service_status_pill.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The strip above the conversation: the request's status, plus the two
/// actions a member has outside the chat — **Cancel** (only before paying)
/// and **Invoice** (once paid).
class ServiceActions extends StatelessWidget {
  const ServiceActions({super.key, required this.request, this.cancelling});

  final ServiceRequestModel request;
  final bool? cancelling;

  Future<void> _cancel(BuildContext context) async {
    final bloc = context.read<ServiceChatBloc>();
    final ok = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Cancel this request?'),
        content: const Text(
          'The team will stop working on it and any open quote is withdrawn. '
          'You can enquire again later.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Keep it'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Cancel request'),
          ),
        ],
      ),
    );
    if (ok == true) bloc.add(const ServiceChatEvent.cancelled());
  }

  Future<void> _invoice(BuildContext context) async {
    final messenger = ScaffoldMessenger.of(context);
    final result = Completer<InvoiceLink?>();
    context.read<ServiceChatBloc>().add(
      ServiceChatEvent.invoiceRequested(result),
    );
    final link = await result.future;
    if (link == null) return; // the bloc already said why
    final opened = await launchUrl(
      Uri.parse(link.url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) {
      messenger.showSnackBar(
        const SnackBar(content: Text('Could not open the invoice.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 14),
      child: Wrap(
        spacing: 10,
        runSpacing: 6,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          ServiceStatusPill(request: request),
          if (request.canCancel)
            TextButton(
              onPressed: cancelling == true ? null : () => _cancel(context),
              child: Text(
                'Cancel request',
                style: type.buttonGhost.copyWith(color: AppPalette.ticketRed),
              ),
            ),
          if (request.invoice != null)
            TextButton(
              onPressed: () => _invoice(context),
              child: Text(
                'Invoice ${request.invoice!.number}',
                style: type.buttonGhost.copyWith(color: AppPalette.badgeTeal),
              ),
            ),
        ],
      ),
    );
  }
}
