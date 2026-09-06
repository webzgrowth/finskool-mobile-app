import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One run of the [AuthHeader] subtitle line. Bold can land anywhere in the
/// sentence (start, middle, or end, even multiple times), matching how the
/// Figma copy actually emphasizes text — not just a trailing bold clause.
///
/// Built through `inter()` rather than a raw `fontWeight` override: a raw
/// override does nothing on this variable font without the matching
/// `fontVariations`.
TextSpan authSpan(String text, {bool bold = false, int? weight}) => TextSpan(
      text: text,
      style: inter(
        size: 12,
        weight: (weight ?? (bold ? 700 : 400)).toDouble(),
        height: 1.4,
        color: Colors.white,
      ),
    );

/// Renders the full subtitle line under the [AuthHeader] title from
/// pre-built [authSpan] runs.
class AuthHeaderSubtitle extends StatelessWidget {
  const AuthHeaderSubtitle({super.key, required this.spans});

  final List<TextSpan> spans;

  @override
  Widget build(BuildContext context) {
    return Text.rich(TextSpan(children: spans));
  }
}
