import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/pick_ticket_files.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_header.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_sheet_page.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/ticket_attachments_section.dart';
import 'widgets/ticket_form_card.dart';

/// Screen 03 — Raise a Ticket.
class RaiseTicketScreen extends StatelessWidget {
  const RaiseTicketScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<TicketFormBloc>()..add(const TicketFormEvent.started()),
      child: const _RaiseTicketView(),
    );
  }
}

class _RaiseTicketView extends StatefulWidget {
  const _RaiseTicketView();

  @override
  State<_RaiseTicketView> createState() => _RaiseTicketViewState();
}

class _RaiseTicketViewState extends State<_RaiseTicketView> {
  // The text lives in controllers and is *pushed* to the bloc on change — the
  // bloc never writes back, so there is no cursor to fight (the opposite of
  // Edit Profile's prefill, which has to flow the other way).
  final _subject = TextEditingController();
  final _description = TextEditingController();

  @override
  void dispose() {
    _subject.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _pickFiles(BuildContext context) async {
    final bloc = context.read<TicketFormBloc>();
    for (final file in await pickTicketFiles(context)) {
      bloc.add(TicketFormEvent.fileAdded(file.file, file.name));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TicketFormBloc, TicketFormState>(
      listenWhen: (a, b) => a.submit != b.submit || a.message != b.message,
      listener: (context, state) {
        if (state.submit.isLoaded && state.created != null) {
          // Pop *with the ticket*, and let My Tickets decide what comes
          // next. Not `pushReplacement`: go_router drops a replaced route's
          // completer without completing it, so the list's awaited push would
          // hang and the new ticket would never appear in it.
          context.pop(state.created);
        } else if (state.message.isNotEmpty) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        final bloc = context.read<TicketFormBloc>();
        return TicketSheetPage(
          header: TicketHeader(
            spec: TicketHeaderSpec.form,
            title: 'Raise a Ticket',
            subtitle:
                'Share the details and the support team will get back '
                'to you',
            onBack: () => context.pop(),
          ),
          body: ListView(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              24 + MediaQuery.paddingOf(context).bottom,
            ),
            children: [
              TicketFormCard(
                state: state,
                subject: _subject,
                description: _description,
                onEvent: bloc.add,
              ),
              const SizedBox(height: 14),
              TicketAttachmentsSection(
                files: state.files,
                error: state.attachmentError,
                onAdd: () => _pickFiles(context),
                onRemove: (id) => bloc.add(TicketFormEvent.fileRemoved(id)),
              ),
              const SizedBox(height: 14),
              TicketButton(
                label: 'Submit ticket',
                arrowGap: 7,
                loading: state.isSubmitting,
                onTap: state.canSubmit
                    ? () => bloc.add(const TicketFormEvent.submitted())
                    : null,
              ),
              const SizedBox(height: 12),
              // Figma: "Replies are sent to your registered email and shown
              // under My tickets." The API sends **no** email for replies
              // (§10), so only the true half is kept.
              Text(
                'Replies appear under My tickets.',
                textAlign: TextAlign.center,
                style: context.ticketType.footnote,
              ),
            ],
          ),
        );
      },
    );
  }
}
