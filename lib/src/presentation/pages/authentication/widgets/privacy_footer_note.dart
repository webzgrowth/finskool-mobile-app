import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'auth_field_icons.dart';

/// The small "Your details are never shared..." reassurance line used on
/// the password-reset screens.
class PrivacyFooterNote extends StatelessWidget {
  const PrivacyFooterNote({super.key, this.text});

  final String? text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset(
          AuthFieldIcons.lockSmall,
          height: 10,
          width: 10,
          colorFilter: ColorFilter.mode(cs.onSurfaceVariant, BlendMode.srcIn),
        ),
        const SizedBox(width: AppSpacing.xs),
        Flexible(
          child: Text(
            text ?? 'Your details are never shared with other members',
            style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
