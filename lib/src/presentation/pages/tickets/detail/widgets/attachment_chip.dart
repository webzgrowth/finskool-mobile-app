import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "PNG  payment-receipt.png" — the file chip inside a bubble.
///
/// Figma draws it only in the member's own (teal) bubble: white at 12%, white
/// text. The support bubble is `#F6F6F6`, where that would vanish, so
/// [onDark] false uses the pale-teal tag surface instead — derived from
/// existing tokens, not drawn in the design.
class AttachmentChip extends StatelessWidget {
  const AttachmentChip({
    super.key,
    required this.attachment,
    required this.onDark,
    required this.onTap,
  });

  final TicketAttachmentModel attachment;
  final bool onDark;
  final VoidCallback onTap;

  Widget _tag(TicketTypography type) => Text(
    attachment.typeTag,
    style: onDark
        ? type.attachmentTag
        : type.attachmentTag.copyWith(color: AppPalette.badgeTeal),
  );

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.fromLTRB(8, 6, 10, 6),
        decoration: BoxDecoration(
          color: onDark
              ? AppPalette.ticketChipOnDark
              : AppPalette.ticketTagSurface,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (attachment.isImage && attachment.url != null)
              ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: Image.network(
                  attachment.url!,
                  height: 32,
                  width: 32,
                  fit: BoxFit.cover,
                  cacheWidth: 96,
                  // The signed link lasts ~5 minutes; a dead one falls back
                  // to the type tag, and tapping refreshes it.
                  errorBuilder: (_, _, _) => _tag(type),
                ),
              )
            else
              _tag(type),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                attachment.fileName,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: onDark
                    ? type.attachmentName
                    : type.attachmentName.copyWith(
                        color: AppPalette.ticketInkSoft,
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
