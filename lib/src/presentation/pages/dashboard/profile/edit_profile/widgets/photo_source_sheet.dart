import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// What the member chose in [showPhotoSourceSheet]: a new photo from a
/// source, or to drop the current one.
sealed class PhotoChoice {
  const PhotoChoice();
}

class PickPhoto extends PhotoChoice {
  const PickPhoto(this.source);
  final ImageSource source;
}

class RemovePhoto extends PhotoChoice {
  const RemovePhoto();
}

/// Camera / gallery / remove chooser. Same bottom-sheet chrome as
/// `country_picker_sheet.dart`.
Future<PhotoChoice?> showPhotoSourceSheet(
  BuildContext context, {
  required bool hasPhoto,
}) {
  return showModalBottomSheet<PhotoChoice>(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (ctx) {
      final cs = Theme.of(ctx).colorScheme;
      final text = Theme.of(ctx).textTheme;
      Widget tile(IconData icon, String label, PhotoChoice choice) => ListTile(
        leading: Icon(icon, color: cs.primary),
        title: Text(label, style: text.titleMedium),
        onTap: () => Navigator.of(ctx).pop(choice),
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
                  const PickPhoto(ImageSource.camera),
                ),
                tile(
                  Icons.photo_library_outlined,
                  'Choose from gallery',
                  const PickPhoto(ImageSource.gallery),
                ),
                if (hasPhoto)
                  tile(
                    Icons.delete_outline,
                    'Remove photo',
                    const RemovePhoto(),
                  ),
              ],
            ),
          ),
        ),
      );
    },
  );
}
