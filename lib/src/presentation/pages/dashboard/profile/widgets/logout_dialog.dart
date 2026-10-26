import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Log out?" confirmation. Resolves **true only on an explicit confirm** —
/// tapping outside, the Cancel button or the system back all resolve false, so
/// the account is never signed out by a stray tap.
Future<bool> showLogoutDialog(BuildContext context) async {
  HapticFeedback.lightImpact();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => const _LogoutDialog(),
  );
  return confirmed ?? false;
}

class _LogoutDialog extends StatelessWidget {
  const _LogoutDialog();

  @override
  Widget build(BuildContext context) {
    final info = context.infoType;
    final ticket = context.ticketType;
    return Dialog(
      backgroundColor: AppPalette.white,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(22, 26, 22, 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 56,
              width: 56,
              decoration: const BoxDecoration(
                color: AppPalette.ticketOpenSurface,
                shape: BoxShape.circle,
              ),
              child: Center(
                child: SvgPicture.asset(
                  'assets/icons/profile_logout.svg',
                  height: 24,
                  width: 24,
                  colorFilter: const ColorFilter.mode(
                    AppPalette.ticketRequired,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Log out?', style: info.articleTitle.copyWith(fontSize: 18)),
            const SizedBox(height: 8),
            Text(
              'You will need to sign in again to see your communities, '
              'subscriptions and tickets.',
              textAlign: TextAlign.center,
              style: info.rowSub.copyWith(height: 1.5),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _DialogButton(
                    label: 'Cancel',
                    style: ticket.buttonGhost.copyWith(
                      color: AppPalette.infoInk,
                    ),
                    outlined: true,
                    onTap: () => Navigator.pop(context, false),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _DialogButton(
                    label: 'Log out',
                    style: ticket.button,
                    fill: AppPalette.ticketRequired,
                    onTap: () => Navigator.pop(context, true),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _DialogButton extends StatelessWidget {
  const _DialogButton({
    required this.label,
    required this.style,
    required this.onTap,
    this.fill,
    this.outlined = false,
  });

  final String label;
  final TextStyle style;
  final VoidCallback onTap;
  final Color? fill;
  final bool outlined;

  @override
  Widget build(BuildContext context) => Material(
    color: fill ?? Colors.transparent,
    borderRadius: BorderRadius.circular(AppRadii.sm),
    clipBehavior: Clip.antiAlias,
    child: InkWell(
      onTap: onTap,
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          border: outlined ? Border.all(color: AppPalette.ticketHint) : null,
        ),
        child: Text(label, style: style),
      ),
    ),
  );
}
