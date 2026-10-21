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
) async {
  if (attachment.id.startsWith('local-')) return;

  final bloc = context.read<TicketChatBloc>();
  final messenger = ScaffoldMessenger.of(context);
  final fresh = Completer<String?>();
  bloc.add(TicketChatEvent.attachmentOpened(attachment.id, fresh));

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
