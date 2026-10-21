import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Category *" / "Related subscription (optional)" — Manrope Bold 12, then
/// either a red asterisk or a muted hint.
class TicketFieldLabel extends StatelessWidget {
  const TicketFieldLabel(
    this.text, {
    super.key,
    this.required = false,
    this.hint,
  });

  final String text;
  final bool required;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(text: text, style: type.fieldLabel),
            if (required)
              TextSpan(
                text: ' *',
                style: type.fieldLabel.copyWith(color: AppPalette.ticketRed),
              ),
            if (hint != null) TextSpan(text: ' $hint', style: type.fieldHint),
          ],
        ),
      ),
    );
  }
}
