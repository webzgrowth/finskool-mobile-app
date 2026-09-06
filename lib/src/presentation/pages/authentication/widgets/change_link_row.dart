import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Wrong E-mail? Change it" / "Wrong number? Change it" style link row
/// used at the bottom of the signup verification screens.
class ChangeLinkRow extends StatelessWidget {
  const ChangeLinkRow({
    super.key,
    required this.question,
    required this.actionLabel,
    required this.onTap,
  });

  final String question;
  final String actionLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('$question ', style: tt.bodySmall),
        GestureDetector(
          onTap: onTap,
          child: Text(
            actionLabel,
            style: inter(
              size: 10,
              weight: 700,
              height: 1.6,
              color: AppPalette.headerGradientEnd,
            ).copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
