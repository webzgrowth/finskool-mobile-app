import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "I confirm these details are correct and match my official documents."
///
/// A legal confirmation rather than a form field, so a failure surfaces as
/// the form's message instead of an inline error under an input.
class ConfirmationCheck extends StatelessWidget {
  const ConfirmationCheck({
    super.key,
    required this.checked,
    required this.onTap,
  });

  final bool checked;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 18,
            width: 18,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: checked ? cs.primary : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadii.xs),
              border: Border.all(
                color: checked ? cs.primary : cs.outlineVariant,
                width: 1.2,
              ),
            ),
            child: checked
                ? Icon(Icons.check, size: 13, color: cs.onPrimary)
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              'I confirm these details are correct and match my official '
              'documents.',
              style: context.communityType.description,
            ),
          ),
        ],
      ),
    );
  }
}
