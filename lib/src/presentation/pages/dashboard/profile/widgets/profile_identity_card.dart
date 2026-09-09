import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';

/// Shows who is currently signed in, read from the profile cached at login.
///
/// A null [user] means we hold a valid session cookie but no readable cache —
/// the session still works, we just can't name the user without a round-trip.
class ProfileIdentityCard extends StatelessWidget {
  const ProfileIdentityCard({super.key, required this.user});

  final UserModel? user;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadii.medium,
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: cs.primary,
            foregroundColor: cs.onPrimary,
            backgroundImage: user?.avatarUrl == null
                ? null
                : NetworkImage(user!.avatarUrl!),
            child: user?.avatarUrl != null
                ? null
                : Text(_initials, style: tt.titleMedium?.copyWith(
                    color: cs.onPrimary)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  user?.name ?? 'Signed in',
                  style: tt.titleMedium?.copyWith(color: cs.secondary),
                ),
                if (user != null) ...[
                  const SizedBox(height: 2),
                  Text(user!.email, style: tt.bodySmall),
                  Text(user!.phone, style: tt.bodySmall),
                ],
              ],
            ),
          ),
        ],
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
