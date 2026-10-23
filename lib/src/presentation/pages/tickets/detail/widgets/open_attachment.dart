import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/presentation/bloc/tickets/chat/ticket_chat_bloc.dart';

/// Opens a file from the conversation in the system viewer.
///
/// Always asks the bloc for a **fresh signed link first**: they last about 5
/// minutes, so in a conversation left open the one in hand is probably dead.
/// An attachment the member has only just sent is still a local placeholder
/// with nothing to open.
Future<void> openTicketAttachment(
  BuildContext context,
  TicketAttachmentModel attachment,
) => openAttachment(
  context,
  attachment,
  (id, result) => context.read<TicketChatBloc>().add(
    TicketChatEvent.attachmentOpened(id, result),
  ),
);

/// The shared body: [request] asks whichever bloc owns the conversation for
/// a fresh link and completes the handed-in completer with it.
Future<void> openAttachment(
  BuildContext context,
  TicketAttachmentModel attachment,
  void Function(String id, Completer<String?> result) request,
) async {
  if (attachment.id.startsWith('local-')) return;

  final messenger = ScaffoldMessenger.of(context);
  final fresh = Completer<String?>();
  request(attachment.id, fresh);

  final url = await fresh.future;
  if (url == null) return; // the bloc already surfaced why
  final opened = await launchUrl(
    Uri.parse(url),
    mode: LaunchMode.externalApplication,
  );
  if (!opened) {
    messenger.showSnackBar(
      const SnackBar(content: Text('Could not open that file.')),
    );
  }
}
