import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_form_bloc.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_section_card.dart';

import 'ticket_dropdown_field.dart';
import 'ticket_text_input.dart';

/// "Ticket details": Category, Related subscription, Subject,
/// Description — 12 between fields (Figma's 66 pitch minus the 54 a field
/// takes).
///
/// No Type field, as in Figma: the ticket is sent as an `issue`. "Related
/// subscription" is optional, as drawn; see `_communityForSubmit`.
class TicketFormCard extends StatelessWidget {
  const TicketFormCard({
    super.key,
    required this.state,
    required this.subject,
    required this.description,
    required this.onEvent,
  });

  final TicketFormState state;
  final TextEditingController subject;
  final TextEditingController description;
  final ValueChanged<TicketFormEvent> onEvent;

  static const _gap = SizedBox(height: 12);

  @override
  Widget build(BuildContext context) {
    return TicketSectionCard(
      title: 'Ticket details',
      padding: const EdgeInsets.fromLTRB(12, 11, 12, 12),
      child: Column(
        children: [
          TicketDropdownField<TicketCategory>(
            label: 'Category',
            placeholder: 'Select a category',
            options: TicketCategory.values,
            labelOf: (c) => c.label,
            value: state.category,
            error: state.categoryError,
            onSelected: (c) => onEvent(TicketFormEvent.categoryChanged(c)),
          ),
          _gap,
          TicketDropdownField(
            label: 'Related subscription',
            hint: '(optional)',
            required: false,
            placeholder: state.communities.isLoading
                ? 'Loading…'
                : 'Select a community',
            options: state.communityOptions,
            labelOf: (c) => c.name,
            value: state.community,
            error: state.communityError,
            onSelected: (c) => onEvent(TicketFormEvent.communityChanged(c)),
          ),
          _gap,
          TicketTextInput(
            label: 'Subject',
            hint: 'Short summary of the issue',
            controller: subject,
            height: 32,
            maxLength: 150,
            error: state.subjectError,
            onChanged: (v) => onEvent(TicketFormEvent.subjectChanged(v)),
          ),
          _gap,
          TicketTextInput(
            label: 'Description',
            hint:
                'Describe what happened. Add dates, amounts or '
                'transaction IDs if relevant.',
            controller: description,
            height: 96,
            maxLength: 500,
            showCounter: true,
            error: state.descriptionError,
            onChanged: (v) => onEvent(TicketFormEvent.descriptionChanged(v)),
          ),
        ],
      ),
    );
  }
}
