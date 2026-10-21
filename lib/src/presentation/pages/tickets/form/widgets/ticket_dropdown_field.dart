import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_chevron.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'ticket_field_label.dart';
import 'ticket_field_shell.dart';
import 'ticket_option_sheet.dart';

/// A labelled dropdown: a 32px field showing the value (or a placeholder) and
/// a small chevron, opening [showTicketOptionSheet] on tap.
class TicketDropdownField<T> extends StatelessWidget {
  const TicketDropdownField({
    super.key,
    required this.label,
    required this.placeholder,
    required this.options,
    required this.labelOf,
    required this.onSelected,
    this.value,
    this.error,
    this.required = true,
    this.hint,
    this.enabled = true,
  });

  final String label;
  final String placeholder;
  final List<T> options;
  final String Function(T) labelOf;
  final ValueChanged<T> onSelected;
  final T? value;
  final String? error;
  final bool required;
  final String? hint;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final text = value == null ? placeholder : labelOf(value as T);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TicketFieldLabel(label, required: required, hint: hint),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: !enabled || options.isEmpty
              ? null
              : () async {
                  final picked = await showTicketOptionSheet<T>(
                    context,
                    title: label,
                    options: options,
                    labelOf: labelOf,
                    selected: value,
                  );
                  if (picked != null) onSelected(picked);
                },
          child: TicketFieldShell(
            height: 32,
            hasError: error != null,
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    text,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: value == null
                        ? type.fieldPlaceholder
                        : type.fieldValue,
                  ),
                ),
                const TicketChevron(),
              ],
            ),
          ),
        ),
        TicketFieldError(error),
      ],
    );
  }
}
