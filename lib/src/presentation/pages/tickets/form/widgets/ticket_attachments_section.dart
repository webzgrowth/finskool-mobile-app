import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/dashed_border.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'ticket_field_shell.dart';

/// "Attachments · Optional": a dashed teal upload box (60 tall), then one
/// 41px white row per picked file — type tag, name + size, red trash.
class TicketAttachmentsSection extends StatelessWidget {
  const TicketAttachmentsSection({
    super.key,
    required this.files,
    required this.onAdd,
    required this.onRemove,
    this.error,
  });

  final List<TicketAttachmentDraft> files;
  final String? error;
  final VoidCallback onAdd;
  final ValueChanged<String> onRemove;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return TealSectionCard(
      title: 'Attachments',
      trailing: Text('Optional', style: context.ticketType.cardHint),
      child: Column(
        children: [
          GestureDetector(
            onTap: onAdd,
            behavior: HitTestBehavior.opaque,
            child: DashedBorder(
              color: AppPalette.badgeTeal,
              child: Container(
                height: 60,
                width: double.infinity,
                alignment: Alignment.center,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('+ Add screenshot or file', style: type.uploadTitle),
                    const SizedBox(height: 4),
                    Text(
                      'PNG, JPG or PDF, up to 5 MB each',
                      style: type.uploadHint,
                    ),
                  ],
                ),
              ),
            ),
          ),
          for (final f in files) ...[
            const SizedBox(height: 10),
            _FileRow(file: f, onRemove: () => onRemove(f.id)),
          ],
          TicketFieldError(error),
        ],
      ),
    );
  }
}

class _FileRow extends StatelessWidget {
  const _FileRow({required this.file, required this.onRemove});

  final TicketAttachmentDraft file;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final failed = file.status == DraftStatus.failed;
    return Container(
      height: 41,
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: AppPalette.ticketFieldBorder),
      ),
      child: Row(
        children: [
          if (file.isImage)
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: Image.file(
                File(file.localPath!),
                height: 29,
                width: 29,
                fit: BoxFit.cover,
                // Cached at thumbnail size, not decoded at 12MP.
                cacheWidth: 96,
                errorBuilder: (_, _, _) => _Tag(file.typeTag),
              ),
            )
          else
            _Tag(file.typeTag),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  file.fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: type.fileName,
                ),
                Text(
                  failed
                      ? (file.error ?? 'Upload failed')
                      : file.isUploading
                      ? 'Uploading…'
                      : file.sizeLabel,
                  style: failed ? type.fieldError : type.fileSize,
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onRemove,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.all(6),
              child: SvgPicture.asset(
                'assets/icons/ticket_delete.svg',
                height: 14,
                width: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
      decoration: BoxDecoration(
        color: AppPalette.ticketTagSurface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(text, style: context.ticketType.fileTag),
    );
  }
}
