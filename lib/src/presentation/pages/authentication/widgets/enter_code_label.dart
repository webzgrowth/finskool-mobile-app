import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'auth_field_icons.dart';

/// The small lock-badge + "Enter Code" heading shown above the OTP boxes.
class EnterCodeLabel extends StatelessWidget {
  const EnterCodeLabel({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 14,
          width: 14,
          decoration: BoxDecoration(color: cs.primary, shape: BoxShape.circle),
          padding: const EdgeInsets.all(3),
          child: SvgPicture.asset(
            AuthFieldIcons.lockSmall,
            colorFilter: ColorFilter.mode(cs.onPrimary, BlendMode.srcIn),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Text('Enter Code', style: tt.titleSmall),
      ],
    );
  }
}
