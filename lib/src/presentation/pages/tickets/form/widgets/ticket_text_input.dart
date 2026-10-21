import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'ticket_field_label.dart';
import 'ticket_field_shell.dart';

/// A labelled field. Subject is a 32px single line; Description is 96px and
/// carries a "0 / 500" counter pinned to its bottom-right.
class TicketTextInput extends StatefulWidget {
  const TicketTextInput({
    super.key,
    required this.label,
    required this.controller,
    required this.onChanged,
    required this.height,
    required this.maxLength,
    this.hint,
    this.error,
    this.showCounter = false,
    this.padding = const EdgeInsets.symmetric(horizontal: 10),
  });

  final String label;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final double height;
  final int maxLength;
  final String? hint;
  final String? error;
  final bool showCounter;
  final EdgeInsetsGeometry padding;

  @override
  State<TicketTextInput> createState() => _TicketTextInputState();
}

class _TicketTextInputState extends State<TicketTextInput> {
  final _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // Rebuilds only the border and the counter — the field itself keeps its
    // own state.
    _focus.addListener(() => setState(() {}));
    widget.controller.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TicketFieldLabel(widget.label, required: true),
        TicketFieldShell(
          height: widget.height,
          focused: _focus.hasFocus,
          hasError: widget.error != null,
          padding: widget.padding,
          child: Column(
            children: [
              if (widget.height > 40) const SizedBox(height: 8),
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  focusNode: _focus,
                  expands: true,
                  maxLines: null,
                  minLines: null,
                  textAlignVertical: widget.height > 40
                      ? TextAlignVertical.top
                      : TextAlignVertical.center,
                  style: type.fieldValue,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(widget.maxLength),
                  ],
                  onChanged: widget.onChanged,
                  decoration: ticketBareDecoration(
                    widget.hint,
                    type.fieldPlaceholder,
                  ),
                ),
              ),
              if (widget.showCounter)
                Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${widget.controller.text.length} / ${widget.maxLength}',
                      style: type.fieldCounter,
                    ),
                  ),
                ),
            ],
          ),
        ),
        TicketFieldError(widget.error),
      ],
    );
  }
}
