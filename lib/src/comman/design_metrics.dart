import 'dart:math' as math;

import 'package:flutter/material.dart';

/// Figma's frames assume an iPhone's status bar: 44pt (the Final page draws
/// every hero under it). An Android phone reports far less — often 24dp — so a
/// hero sized as `inset + <design height>` came out visibly short there, with
/// the status-bar band about 20dp thinner than the design.
///
/// This is the design's own 44 as a **floor**: a taller real inset (a notch or
/// Dynamic Island) still wins, and the content under it never moves, so the
/// hero keeps Figma's proportions on every device. It is a floor, not a
/// replacement for `MediaQuery` — never hardcode the inset itself.
const double kDesignStatusBar = 44;

/// The top inset to size heroes and bars with: the real status-bar inset, but
/// never less than [kDesignStatusBar].
double designTopInset(BuildContext context) =>
    math.max(MediaQuery.paddingOf(context).top, kDesignStatusBar);

/// How far short of the design's status bar this device falls (0 on iOS). A
/// `SliverAppBar` adds the *real* inset to its `toolbarHeight` by itself, so a
/// bar that wants [designTopInset] has to pay this difference explicitly.
double statusBarShortfall(BuildContext context) =>
    designTopInset(context) - MediaQuery.paddingOf(context).top;

/// Figma's small glyphs (a 12px search mark, a 13px bell, a 16px tab icon) are
/// drawn for a 393pt iPhone at ~460ppi; on an Android phone they read about a
/// fifth smaller. Scale them up there so they look as intended.
double iconScaleOf(BuildContext context) =>
    Theme.of(context).platform == TargetPlatform.android ? 1.2 : 1.0;
