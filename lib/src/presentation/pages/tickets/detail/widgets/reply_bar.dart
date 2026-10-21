import 'package:flutter/material.dart';

import 'reply_bar_parts.dart';

import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The composer: a "+" for files, a pill input and a teal send button,
/// on a white sheet with rounded top corners.
///
/// Positions are Figma's: 40px controls at y=16, 10px apart, the bar 106 tall
/// at design size — which is 16 + 40 + 50, the 50 being 16 padding and the
/// 34px home indicator. The real bottom inset is read from `MediaQuery`, not
/// hardcoded.
class ReplyBar extends StatefulWidget {
  const ReplyBar({
    super.key,
    required this.drafts,
    required this.enabled,
    required this.reconnecting,
    required this.onSend,
    required this.onAttach,
    required this.onRemoveDraft,
  });

  final List<TicketAttachmentDraft> drafts;

  /// Whether a message can go out right now: the socket is live and nothing
  /// is still uploading.
  final bool enabled;
  final bool reconnecting;
  final ValueChanged<String> onSend;
  final VoidCallback onAttach;
  final ValueChanged<String> onRemoveDraft;

  @override
  State<ReplyBar> createState() => _ReplyBarState();
}

class _ReplyBarState extends State<ReplyBar> {
  final _text = TextEditingController();

  @override
  void initState() {
    super.initState();
    _text.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _text.dispose();
    super.dispose();
  }

  bool get _hasContent =>
      _text.text.trim().isNotEmpty || widget.drafts.any((d) => d.isReady);

  void _send() {
    if (!widget.enabled || !_hasContent) return;
    widget.onSend(_text.text);
    _text.clear();
  }

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final canSend = widget.enabled && _hasContent;
    return Container(
      padding: EdgeInsets.fromLTRB(
        16,
        16,
        16,
        16 + MediaQuery.paddingOf(context).bottom,
      ),
      decoration: const BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
        boxShadow: [
          BoxShadow(
            color: AppPalette.ticketShadow,
            blurRadius: 20,
            offset: Offset(0, -4),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.reconnecting) const ReplyReconnectingNotice(),
          if (widget.drafts.isNotEmpty)
            ReplyDrafts(drafts: widget.drafts, onRemove: widget.onRemoveDraft),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              ReplyRoundButton(
                fill: AppPalette.ticketCard,
                glyph: '+',
                style: type.plusGlyph,
                label: 'Attach a file',
                onTap: widget.onAttach,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Container(
                  constraints: const BoxConstraints(minHeight: 40),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: AppPalette.ticketCard,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  alignment: Alignment.centerLeft,
                  child: TextField(
                    controller: _text,
                    minLines: 1,
                    maxLines: 4,
                    style: type.fieldValue,
                    textInputAction: TextInputAction.newline,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      // See `ticketBareDecoration`: the theme's 16pt content
                      // padding survives `isCollapsed` unless zeroed here.
                      contentPadding: EdgeInsets.zero,
                      hintText: 'Write a reply',
                      hintStyle: type.replyPlaceholder,
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: false,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              // Solid at rest, as drawn. It dims only when sending is
              // impossible (offline, or a file still uploading) — not merely
              // because the box is empty, which would make the design's own
              // resting state look disabled.
              Opacity(
                opacity: widget.enabled ? 1 : 0.5,
                child: ReplyRoundButton(
                  fill: AppPalette.badgeTeal,
                  glyph: '↑',
                  style: type.sendGlyph,
                  label: 'Send',
                  onTap: canSend ? _send : null,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
