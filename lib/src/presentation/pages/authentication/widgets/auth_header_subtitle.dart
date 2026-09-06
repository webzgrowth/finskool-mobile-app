import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The two-part "Good to see you again. **Let's get started.**" line under
/// the [AuthHeader] title, with the emphasis rendered at the real bold
/// weight via `inter()` (a raw `fontWeight` override does nothing on a
/// variable font without the matching `fontVariations`).
class AuthHeaderSubtitle extends StatelessWidget {
  const AuthHeaderSubtitle({
    super.key,
    required this.subtitle,
    required this.emphasis,
  });

  final String subtitle;
  final String emphasis;

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      TextSpan(
        children: [
          TextSpan(
            text: '$subtitle ',
            style: inter(size: 12, weight: 400, height: 1.4, color: Colors.white),
          ),
          TextSpan(
            text: emphasis,
            style: inter(size: 12, weight: 700, height: 1.4, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
