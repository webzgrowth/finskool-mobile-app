import 'package:flutter/material.dart';
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
    return CircleAvatar(
      radius: radius,
      backgroundColor: cs.primary,
      foregroundColor: cs.onPrimary,
      backgroundImage:
          user?.avatarUrl == null ? null : NetworkImage(user!.avatarUrl!),
      child: user?.avatarUrl != null
          ? null
          : Text(
              _initials,
              style: TextStyle(
                fontSize: radius * 0.7,
                fontWeight: FontWeight.w600,
                color: cs.onPrimary,
              ),
            ),
    );
  }

  String get _initials {
    final name = user?.name.trim() ?? '';
    if (name.isEmpty) return '?';
    final parts = name.split(RegExp(r'\s+'));
    if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
    return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
        .toUpperCase();
  }
}
