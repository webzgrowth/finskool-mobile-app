import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';

import 'photo_source_sheet.dart';

/// Runs the whole "change photo" interaction: choose a source, pick, hand the
/// path to [EditProfileBloc]. Lives in the widget layer because the picker and
/// the OS permission prompt are UI.
Future<void> changeProfilePhoto(
  BuildContext context, {
  required bool hasPhoto,
}) async {
  final bloc = context.read<EditProfileBloc>();
  final messenger = ScaffoldMessenger.of(context);
  final choice = await showPhotoSourceSheet(context, hasPhoto: hasPhoto);
  switch (choice) {
    case null:
      return;
    case RemovePhoto():
      bloc.add(const EditProfileEvent.avatarRemoved());
    case PickPhoto(:final source):
      try {
        final file = await ImagePicker().pickImage(
          source: source,
          maxWidth: 1024,
          maxHeight: 1024,
          imageQuality: 85,
        );
        if (file != null) bloc.add(EditProfileEvent.avatarPicked(file.path));
      } catch (_) {
        // image_picker throws on a denied camera/photo permission.
        messenger.showSnackBar(
          SnackBar(
            content: Text(
              source == ImageSource.camera
                  ? 'Camera access is off. Enable it in Settings.'
                  : 'Photo access is off. Enable it in Settings.',
            ),
            action: SnackBarAction(
              label: 'Settings',
              onPressed: openAppSettings,
            ),
          ),
        );
      }
  }
}
