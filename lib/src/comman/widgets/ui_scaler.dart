import 'package:flutter/material.dart';
import 'package:finskool/src/comman/design_metrics.dart';

/// Wraps the whole app so every screen renders as if the device were
/// [kDesignScreenWidth] wide, then scales that render up to the device's
/// real size — see [uiScaleFor] for why. This is the one place that fixes
/// "icons and text look small on a big phone"; it deliberately does **not**
/// touch individual widgets, which stay exactly as measured from Figma.
///
/// Mechanics: the app is told (via the [MediaQuery] it reads) that the
/// screen is smaller than it really is, laid out normally at that smaller
/// size, then [Transform.scale] blows the whole rendered result back up to
/// fill the real screen. `OverflowBox` is what lets a widget subtree believe
/// it has the smaller size while actually occupying the larger box the
/// transform expects to fill.
class UiScaler extends StatelessWidget {
  const UiScaler({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context);
    final scale = uiScaleFor(mq.size);
    if (scale == 1.0) return child;

    final scaledSize = mq.size / scale;
    return MediaQuery(
      data: mq.copyWith(
        size: scaledSize,
        // These are physical/dp insets on the *real* screen (status bar,
        // keyboard, gesture areas). Shrinking them along with everything
        // else is what makes them land back at their true size once the
        // outer Transform.scale re-expands the whole tree.
        padding: mq.padding / scale,
        viewPadding: mq.viewPadding / scale,
        viewInsets: mq.viewInsets / scale,
        systemGestureInsets: mq.systemGestureInsets / scale,
      ),
      child: Transform.scale(
        scale: scale,
        alignment: Alignment.topLeft,
        child: OverflowBox(
          minWidth: scaledSize.width,
          maxWidth: scaledSize.width,
          minHeight: scaledSize.height,
          maxHeight: scaledSize.height,
          alignment: Alignment.topLeft,
          child: child,
        ),
      ),
    );
  }
}
