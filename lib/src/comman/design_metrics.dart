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

/// The frame width every Figma screen in this app is drawn for.
const double kDesignScreenWidth = 393;

/// Every pixel size in the app — font sizes, icon dimensions, paddings — is
/// pinned to [kDesignScreenWidth]. A 6.1" iPhone matches that almost exactly,
/// but a 6.6"+ Android phone commonly reports 410–430 logical px of width at
/// the same density, so the identical text/icon sizes occupy a visibly
/// smaller share of a bigger panel and read as "too small" even though
/// nothing is actually wrong per-widget. [UiScaler] is the fix: rather than
/// hunting down every hardcoded size in the app, it renders the whole app as
/// if the screen were still [kDesignScreenWidth] wide and then uniformly
/// scales that up to fill the real one, so every size grows together in the
/// same proportion Figma drew — **icons included**, since `UiScaler` scales
/// the whole rendered canvas, SVGs and all, not just text.
///
/// Two parts: [_deviceRatio] (device width vs. the design frame, clamped so a
/// tablet — which already caps its *content* width, see
/// `TicketSheetPage.maxContentWidth` — only gets a mild bump) **times** a flat
/// 12% lift applied to every device, [kFlatUiBoost]. Figma's own type scale
/// reads small as rendered — even on an iPhone matching the design frame
/// exactly, the app still wanted to look bigger than a 1:1 trace of it — so
/// the boost isn't only about screens wider than the design.
const double kFlatUiBoost = 1.12;

double _deviceRatio(Size screenSize) {
  final shortestSide = math.min(screenSize.width, screenSize.height);
  return (shortestSide / kDesignScreenWidth).clamp(1.0, 1.25);
}

double uiScaleFor(Size screenSize) =>
    (_deviceRatio(screenSize) * kFlatUiBoost).clamp(1.12, 1.4);
