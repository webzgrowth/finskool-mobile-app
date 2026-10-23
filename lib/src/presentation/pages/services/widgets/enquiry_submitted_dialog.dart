import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// What the member chose in [EnquirySubmittedDialog].
enum EnquiryChoice { view, done }

/// Figma's "Enquiry submitted" modal: a teal tick on a mint ring, the copy,
/// the ticket pill, then **View** and **Done**.
///
/// Two deliberate departures from the drawn copy:
/// * Figma says "view it in My Tickets" — a service request is **not** a
///   support ticket and lives in its own list, so the button reads "View
///   request" and the copy says "in My requests".
/// * When [existing] the member already had this enquiry open (409), so it
///   says so rather than claiming a new one was submitted.
class EnquirySubmittedDialog extends StatelessWidget {
  const EnquirySubmittedDialog({
    super.key,
    required this.serviceTitle,
    required this.label,
    required this.existing,
  });

  final String serviceTitle;
  final String label;
  final bool existing;

  static Future<EnquiryChoice?> show(
    BuildContext context, {
    required String serviceTitle,
    required String label,
    required bool existing,
  }) => showDialog<EnquiryChoice>(
    context: context,
    builder: (_) => EnquirySubmittedDialog(
      serviceTitle: serviceTitle,
      label: label,
      existing: existing,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final body = tt.bodyMedium!.copyWith(height: 1.5, color: cs.onSurface);
    return Dialog(
      backgroundColor: cs.surface,
      insetPadding: const EdgeInsets.symmetric(horizontal: 30),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(24, 28, 24, 12),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppPalette.badgeTeal.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Container(
                height: 56,
                width: 56,
                decoration: const BoxDecoration(
                  color: AppPalette.badgeTeal,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  color: AppPalette.white,
                  size: 32,
                ),
              ),
            ),
            const SizedBox(height: 18),
            Text(
              existing ? 'Already enquired' : 'Enquiry submitted',
              style: tt.headlineSmall!.copyWith(color: AppPalette.reactionRing),
            ),
            const SizedBox(height: 12),
            Text.rich(
              TextSpan(
                style: body,
                children: [
                  TextSpan(
                    text: existing
                        ? 'You already have an open request for '
                        : 'We have received your enquiry for ',
                  ),
                  TextSpan(
                    text: serviceTitle,
                    style: body.copyWith(fontWeight: FontWeight.w700),
                  ),
                  const TextSpan(
                    text:
                        '. Our team will reply in the chat — you can open '
                        'it anytime in My requests.',
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
              decoration: BoxDecoration(
                color: AppPalette.badgeTeal.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Text.rich(
                TextSpan(
                  style: tt.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Request ID  ',
                      style: tt.bodyMedium!.copyWith(
                        color: cs.onSurfaceVariant,
                      ),
                    ),
                    TextSpan(
                      text: '#$label',
                      style: tt.bodyMedium!.copyWith(
                        color: AppPalette.badgeTeal,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 22),
            SizedBox(
              height: 46,
              width: double.infinity,
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppPalette.badgeTeal,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadii.md),
                  ),
                ),
                onPressed: () => Navigator.pop(context, EnquiryChoice.view),
                child: const Text('View request  →'),
              ),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, EnquiryChoice.done),
              child: Text(
                'Done',
                style: tt.titleSmall!.copyWith(color: AppPalette.reactionRing),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
