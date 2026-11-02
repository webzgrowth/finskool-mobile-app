import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:finskool/src/presentation/bloc/profile/edit_profile/edit_profile_bloc.dart';

import 'photo_source_sheet.dart';

/// Runs the whole "change photo" interaction: choose a source, pick, hand the
/// path to [EditProfileBloc], which uploads it. Lives in the widget layer
/// because the picker and the OS permission prompt are UI.
///
/// The picker resizes to 512px (the guide's size: it uploads and loads faster
/// everywhere); the repository still checks type and size before any request.
Future<void> changeProfilePhoto(BuildContext context) async {
  final bloc = context.read<EditProfileBloc>();
  final messenger = ScaffoldMessenger.of(context);
  final source = await showPhotoSourceSheet(context);
  if (source == null) return;
  try {
    final file = await ImagePicker().pickImage(
      source: source,
      maxWidth: 512,
      maxHeight: 512,
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
        action: SnackBarAction(label: 'Settings', onPressed: openAppSettings),
      ),
    );
  }
}
