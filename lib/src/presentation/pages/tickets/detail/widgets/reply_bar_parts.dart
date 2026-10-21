import 'package:flutter/material.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The pieces of [ReplyBar], split out to keep each file small.

class ReplyRoundButton extends StatelessWidget {
  const ReplyRoundButton({
    super.key,
    required this.fill,
    required this.glyph,
    required this.style,
    required this.label,
    required this.onTap,
  });

  final Color fill;
  final String glyph;
  final TextStyle style;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: label,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 40,
          width: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(color: fill, shape: BoxShape.circle),
          child: Text(glyph, style: style),
        ),
      ),
    );
  }
}

/// Files queued for the next message, shown above the input.
class ReplyDrafts extends StatelessWidget {
  const ReplyDrafts({super.key, required this.drafts, required this.onRemove});

  final List<TicketAttachmentDraft> drafts;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final d in drafts)
              Container(
                padding: const EdgeInsets.fromLTRB(10, 6, 8, 6),
                decoration: BoxDecoration(
                  color: AppPalette.ticketCard,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(d.typeTag, style: type.fileTag),
                    const SizedBox(width: 6),
                    Flexible(
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 140),
                        child: Text(
                          d.fileName,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: type.chip,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    if (d.isUploading)
                      const SizedBox(
                        height: 12,
                        width: 12,
                        child: CircularProgressIndicator(strokeWidth: 1.5),
                      )
                    else
                      GestureDetector(
                        onTap: () => onRemove(d.id),
                        behavior: HitTestBehavior.opaque,
                        child: Text(
                          '✕',
                          style: d.status == DraftStatus.failed
                              ? type.fieldError
                              : type.fieldHint,
                        ),
                      ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

/// The spec requires a visible "reconnecting" state (§1): with the socket
/// down the member can neither send nor load. Figma doesn't draw one, so it
/// borrows the In-progress amber.
class ReplyReconnectingNotice extends StatelessWidget {
  const ReplyReconnectingNotice({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      decoration: BoxDecoration(
        color: AppPalette.ticketProgressSurface,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        'Reconnecting… you can send once you’re back online.',
        style: context.ticketType.statusPill.copyWith(
          color: AppPalette.ticketProgressInk,
        ),
      ),
    );
  }
}
