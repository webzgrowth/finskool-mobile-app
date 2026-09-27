import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The 1px rule between two cells in a details grid. Full-height, so it
/// needs an `IntrinsicHeight` above the `Row` that holds it.
class GridVRule extends StatelessWidget {
  const GridVRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
        width: 1,
        margin: const EdgeInsets.symmetric(horizontal: 6),
        color: AppPalette.subscriptionDivider,
      );
}

/// The 1px rule between two rows of a details grid.
class GridHRule extends StatelessWidget {
  const GridHRule({super.key});

  @override
  Widget build(BuildContext context) => Container(
        height: 1,
        margin: const EdgeInsets.symmetric(vertical: 10),
        color: AppPalette.subscriptionDivider,
      );
}
