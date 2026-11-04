import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'profile_glyphs.dart';
import 'profile_menu_row.dart';

/// Account → "Google" / "Apple": whether that sign-in is linked to this
/// account, and a **Connect** pill when it isn't (`POST /me/social/link`).
///
/// A member whose phone already had a password account is told to log in with
/// the password and then connect from here (`409 ALREADY_REGISTERED`), so this
/// is that second half. **Not in Figma**: built from the Profile's own row,
/// with the existing privacy glyph — flag it for the designer.
class ConnectAccountRow extends StatelessWidget {
  const ConnectAccountRow({
    super.key,
    required this.provider,
    required this.connected,
    required this.busy,
    required this.onConnect,
  });

  final SocialProvider provider;
  final bool connected;

  /// This provider's connect is in flight.
  final bool busy;
  final VoidCallback onConnect;

  String get _name => provider == SocialProvider.apple ? 'Apple' : 'Google';

  @override
  Widget build(BuildContext context) {
    final label = Theme.of(context).textTheme.labelMedium;
    return ProfileMenuRow(
      glyph: ProfileGlyphs.privacy,
      title: '$_name account',
      subtitle: connected
          ? 'Connected — log in with one tap'
          : 'Connect to log in with one tap',
      // The row itself never taps; only the pill does, so a stray tap on the
      // text can't open a provider sheet.
      showChevron: false,
      trailing: connected
          ? Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_circle_rounded,
                  size: 16,
                  color: AppPalette.badgeTeal,
                ),
                const SizedBox(width: 4),
                Text(
                  'Connected',
                  style: label?.copyWith(color: AppPalette.badgeTeal),
                ),
              ],
            )
          : busy
          ? const SizedBox(
              height: 18,
              width: 18,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : OutlinedButton(
              onPressed: onConnect,
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(0, 30),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                side: const BorderSide(color: AppPalette.badgeTeal),
              ),
              child: Text(
                'Connect',
                style: label?.copyWith(color: AppPalette.badgeTeal),
              ),
            ),
    );
  }
}
