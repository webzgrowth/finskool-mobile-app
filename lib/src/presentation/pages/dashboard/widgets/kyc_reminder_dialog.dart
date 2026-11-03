import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Please complete your KYC". Resolves **true only on "Complete KYC"**; Later,
/// a tap outside and system back all resolve false.
Future<bool> showKycReminderDialog(BuildContext context) async {
  HapticFeedback.lightImpact();
  final go = await showDialog<bool>(
    context: context,
    builder: (_) => const _KycReminderDialog(),
  );
  return go ?? false;
}

class _KycReminderDialog extends StatelessWidget {
  const _KycReminderDialog();

  @override
  Widget build(BuildContext context) {
    final info = context.infoType;
    final cs = Theme.of(context).colorScheme;
    return Dialog(
      backgroundColor: cs.surface,
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
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(Icons.verified_user_outlined, color: cs.primary),
            ),
            const SizedBox(height: 16),
            Text(
              'Complete your KYC',
              style: info.articleTitle.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 8),
            Text(
              'SEBI requires your date of birth and PAN for your paid '
              'community. It only takes a minute.',
              textAlign: TextAlign.center,
              style: info.rowSub.copyWith(height: 1.5),
            ),
            const SizedBox(height: 22),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Complete KYC'),
              ),
            ),
            const SizedBox(height: 6),
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Later'),
            ),
          ],
        ),
      ),
    );
  }
}
