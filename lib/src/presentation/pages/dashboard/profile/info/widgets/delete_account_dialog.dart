import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Delete your account?" confirmation. Resolves **true only on the explicit
/// button** — a tap outside, Cancel and system back all resolve false, like
/// the logout dialog, so a stray tap never starts a deletion request.
Future<bool> showDeleteAccountDialog(BuildContext context) async {
  HapticFeedback.mediumImpact();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (_) => const _DeleteAccountDialog(),
  );
  return confirmed ?? false;
}

class _DeleteAccountDialog extends StatelessWidget {
  const _DeleteAccountDialog();

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
            Text(
              'Delete your account?',
              textAlign: TextAlign.center,
              style: info.articleTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'We will open an email to support asking them to delete your '
              'account and personal information. Records we must keep by law '
              'are not deleted.',
              textAlign: TextAlign.center,
              style: info.rowSub.copyWith(height: 1.5),
            ),
            const SizedBox(height: 22),
            Row(
              children: [
                Expanded(
                  child: _Button(
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
                  child: _Button(
                    label: 'Continue',
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

class _Button extends StatelessWidget {
  const _Button({
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
