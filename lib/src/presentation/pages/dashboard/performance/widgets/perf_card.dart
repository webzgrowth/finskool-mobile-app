import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The white, r20 card with a `#E3ECEA` hairline and a soft teal shadow that
/// the summary cards and the trade list share (Figma `Summary / …`,
/// `Trades`).
class PerfCard extends StatelessWidget {
  const PerfCard({super.key, required this.padding, required this.child});

  final EdgeInsetsGeometry padding;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding,
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppPalette.perfBorder),
        boxShadow: const [
          BoxShadow(
            color: AppPalette.perfShadow,
            offset: Offset(0, 6),
            blurRadius: 18,
          ),
        ],
      ),
      child: child,
    );
  }
}
