import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:finskool/src/utilities/theme/theme.dart';

/// Every ticket screen: a short teal hero, and a white sheet with rounded top
/// corners riding up over it — Figma's `Content` frame.
///
/// Figma draws the sheet at y=105 under a 44pt status bar, i.e. **61pt below
/// the status bar**. The real inset is read from `MediaQuery`, never hardcoded
/// (CLAUDE.md), so a Dynamic Island, a notch and a thin Android bar all keep
/// the hero 61pt tall beneath the system UI.
///
/// The hero is `ticket_hero_bg.png`, **built from Figma's own render** — its
/// gradient and glow are fills this server doesn't serialise, and the app's
/// `auth_header_bg.png` is a brighter teal that doesn't match. See CLAUDE.md.
class TicketSheetPage extends StatelessWidget {
  const TicketSheetPage({
    super.key,
    required this.header,
    required this.body,
    this.bottomBar,
    this.overlays = const [],
  });

  final Widget header;
  final Widget body;

  /// Pinned under the scroll area — the chat's reply bar.
  final Widget? bottomBar;

  /// Floating layers above the sheet (the status popover, the rating card),
  /// laid out in the same box as the page so they can anchor to its edges.
  final List<Widget> overlays;

  /// Figma: sheet at y=105, status bar 44.
  static const double _heroBelowStatusBar = 61;
  static const double _sheetRadius = 16;

  /// Wide screens: the sheet and hero span the screen, the content doesn't.
  static const double maxContentWidth = 480;

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.paddingOf(context).top;
    final sheetTop = inset + _heroBelowStatusBar;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        // Behind the hero, so an overscroll or a rubber-band shows the brand
        // teal rather than white.
        backgroundColor: AppPalette.secondary,
        resizeToAvoidBottomInset: true,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: sheetTop + _sheetRadius * 2,
              child: Image.asset(
                'assets/images/ticket_hero_bg.png',
                fit: BoxFit.cover,
                alignment: Alignment.topCenter,
              ),
            ),
            Positioned.fill(
              top: sheetTop,
              child: Container(
                clipBehavior: Clip.antiAlias,
                decoration: const BoxDecoration(
                  color: AppPalette.white,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(_sheetRadius),
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(
                      maxWidth: maxContentWidth,
                    ),
                    child: Column(
                      children: [
                        header,
                        Expanded(child: body),
                        ?bottomBar,
                      ],
                    ),
                  ),
                ),
              ),
            ),
            ...overlays,
          ],
        ),
      ),
    );
  }
}
