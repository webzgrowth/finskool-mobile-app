import 'dart:io';

import 'package:flutter/material.dart';
import 'package:finskool/src/comman/initials.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';

/// A user's avatar photo, with an initials fallback when there's no
/// [UserModel.avatarUrl] (or no user at all).
///
/// Extracted from what was inline logic in `ProfileIdentityCard` — now
/// needed in three places: the Profile header, that same identity card, and
/// the bottom nav's Profile tab, which shows the real photo rather than an
/// icon (Figma's nav bar has no glyph for that tab, just a filled circle —
/// see CLAUDE.md "Profile").
class UserAvatar extends StatelessWidget {
  const UserAvatar({super.key, required this.user, required this.radius});

  final UserModel? user;
  final double radius;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // The photo picked on this device wins over the server's: it's what the
    // member just chose, and the API can't be told about it.
    final local = user?.avatarLocalPath;
    final ImageProvider? image = local != null
        ? FileImage(File(local))
        : user?.avatarUrl == null
        ? null
        : NetworkImage(user!.avatarUrl!);
    return CircleAvatar(
      radius: radius,
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      backgroundImage: image,
      child: image != null
          ? null
          : Text(
              initialsFor(user?.name),
              style: TextStyle(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.w600,
                color: cs.onPrimary,
              ),
            ),
    );
  }
}
