import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Wrong E-mail? Change it" link on the verify-code screen.
class WrongEmailRow extends StatelessWidget {
  const WrongEmailRow({super.key, required this.onChangeEmail});

  final VoidCallback onChangeEmail;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text('Wrong E-mail? ', style: tt.bodySmall),
        GestureDetector(
          onTap: onChangeEmail,
          child: Text(
            'Change it',
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
