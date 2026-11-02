import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/user_avatar.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../../widgets/profile_icons.dart';
import 'profile_photo_picker.dart';

/// The centred avatar + camera badge + name at the top of Edit Profile.
///
/// Unlike `ProfileHeroBanner`'s avatar this one sits on the white sheet
/// rather than straddling the teal hero, so it's plain centred content
/// instead of a `Positioned` overlap.
///
/// The camera badge opens the photo chooser; [busy] shows a spinner while the
/// chosen file is being saved.
class EditProfileAvatar extends StatelessWidget {
  const EditProfileAvatar({
    super.key,
    required this.user,
    required this.name,
    this.busy = false,
  });

  final UserModel? user;
  final bool busy;

  /// Taken from the form rather than [user] so the heading tracks what's
  /// being typed.
  final String name;

  static const double _radius = 55;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.profileType;

    return Column(
      children: [
        Stack(
          clipBehavior: Clip.none,
          children: [
            UserAvatar(user: user, radius: _radius),
            if (busy)
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: cs.scrim.withValues(alpha: 0.35),
                  ),
                  child: const Center(child: CircularProgressIndicator()),
                ),
              ),
            Positioned(
              right: 2,
              bottom: 4,
              child: GestureDetector(
                onTap: busy ? null : () => changeProfilePhoto(context),
                child: Container(
                  height: 32,
                  width: 32,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppPalette.secondary,
                    shape: BoxShape.circle,
                    border: Border.all(color: cs.surface, width: 2),
                  ),
                  child: Icon(
                    ProfileIcons.camera,
                    size: 15,
                    color: cs.onPrimary,
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        Text(
          name.isEmpty ? 'Your profile' : name,
          style: type.name.copyWith(fontSize: 22),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
