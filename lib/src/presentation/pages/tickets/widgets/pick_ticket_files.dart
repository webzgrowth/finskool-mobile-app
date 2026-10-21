import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finskool/src/presentation/bloc/tickets/form/ticket_attachment_draft.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

enum _Source { photos, files }

/// Asks where to pick from — **Photos** or **Files** — then opens that picker.
///
/// Photos goes through the gallery picker (what people expect for a
/// screenshot); Files goes through the system document picker, filtered to the
/// four extensions the API accepts. The filter is only a convenience — the
/// bloc re-checks type, size and count (`UploadRules`) and the server reads
/// the file's first bytes, so a renamed file is still caught.
/// A picked file with the name the member knows it by.
typedef PickedFile = ({File file, String name});

Future<List<PickedFile>> pickTicketFiles(BuildContext context) async {
  final source = await showModalBottomSheet<_Source>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (_) => const _SourceSheet(),
  );
  if (source == null) return const [];

  if (source == _Source.photos) {
    final images = await ImagePicker().pickMultiImage();
    return [
      for (final x in images)
        (file: File(x.path), name: _photoName(x.name, File(x.path))),
    ];
  }
  final picked = await FilePicker.pickFiles(
    type: FileType.custom,
    allowedExtensions: UploadRules.allowedExtensions,
  );
  return [
    for (final f in picked)
      if (f.path != null) (file: File(f.path!), name: f.name),
  ];
}

/// image_picker hands back its cache copy, `image_picker_<UUID>.jpg`, and on
/// iOS the gallery withholds the original name, so it can't be recovered. A
/// UUID means nothing to the member, so name it by when the photo was taken
/// ("Photo 2026-10-21 16.18.jpg"). A name the picker did supply is kept.
String _photoName(String name, File file) {
  if (!name.startsWith('image_picker')) return name;
  final dot = name.lastIndexOf('.');
  final ext = dot == -1 ? 'jpg' : name.substring(dot + 1).toLowerCase();
  final t = file.lastModifiedSync();
  String two(int n) => n.toString().padLeft(2, '0');
  return 'Photo ${t.year}-${two(t.month)}-${two(t.day)} '
      '${two(t.hour)}.${two(t.minute)}.${two(t.second)}.$ext';
}

class _SourceSheet extends StatelessWidget {
  const _SourceSheet();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 8),
            Container(
              height: 5,
              width: 82,
              decoration: BoxDecoration(
                color: AppPalette.sheetHandle,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            const SizedBox(height: 8),
            const _Option(
              icon: Icons.photo_library_outlined,
              label: 'Photos',
              source: _Source.photos,
            ),
            const _Option(
              icon: Icons.folder_outlined,
              label: 'Files',
              source: _Source.files,
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }
}

class _Option extends StatelessWidget {
  const _Option({
    required this.icon,
    required this.label,
    required this.source,
  });

  final IconData icon;
  final String label;
  final _Source source;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Navigator.of(context).pop(source),
      child: Container(
        height: 52,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppPalette.badgeTeal),
            const SizedBox(width: 14),
            Text(label, style: context.ticketType.fieldValue),
          ],
        ),
      ),
    );
  }
}
