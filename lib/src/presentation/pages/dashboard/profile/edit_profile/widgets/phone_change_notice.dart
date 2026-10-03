import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The amber "Changing your phone number" notice shown while editing.
///
/// Always visible in edit mode rather than only once the number is dirty:
/// it's telling the user what *would* happen if they change it, which is
/// only useful before they do. That matches Figma, which shows it with the
/// number untouched.
class PhoneChangeNotice extends StatelessWidget {
  const PhoneChangeNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final type = context.profileType;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppPalette.noticeAmberSurface,
        borderRadius: BorderRadius.circular(AppRadii.md),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 20,
            width: 20,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: AppPalette.noticeAmber,
              shape: BoxShape.circle,
            ),
            child: const Icon(Icons.info_outline,
                size: 12, color: AppPalette.white),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Changing your phone number', style: type.noticeTitle),
                const SizedBox(height: 3),
                Text(
                  'Your new number must be verified before your community '
                  'access moves across. Access stays on the old number '
                  'until then.',
                  style: type.noticeBody,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
