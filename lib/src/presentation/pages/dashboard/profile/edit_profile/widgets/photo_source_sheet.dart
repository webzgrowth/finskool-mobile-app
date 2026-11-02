import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Camera / gallery chooser. Same bottom-sheet chrome as
/// `country_picker_sheet.dart`. There is no "Remove photo": the API can only
/// replace a picture.
Future<ImageSource?> showPhotoSourceSheet(BuildContext context) {
  return showModalBottomSheet<ImageSource>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final text = Theme.of(ctx).textTheme;
      Widget tile(IconData icon, String label, ImageSource source) => ListTile(
        leading: Icon(icon, color: cs.primary),
        title: Text(label, style: text.titleMedium),
        onTap: () => Navigator.of(ctx).pop(source),
      );
      // `Material`, not a coloured `Container`: ListTile paints its ink on the
      // nearest Material, and a Container's fill would sit on top of it and
      // hide the splash.
      return Material(
        color: cs.surface,
        borderRadius: AppRadii.sheet,
        clipBehavior: Clip.antiAlias,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                tile(
                  Icons.photo_camera_outlined,
                  'Take a photo',
                  ImageSource.camera,
                ),
                tile(
                  Icons.photo_library_outlined,
                  'Choose from gallery',
                  ImageSource.gallery,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
