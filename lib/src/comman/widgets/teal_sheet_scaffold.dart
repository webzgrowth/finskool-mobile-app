import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The dark-teal hero behind a white sheet with rounded top corners, shared
/// by Subscription Detail and Edit Profile — the Final design's chrome, the
/// same hero image the ticket screens use (`ticket_hero_bg.png`).
///
/// Deliberately not a Material `AppBar`: the hero bleeds behind the status bar
/// and the sheet rides over it, so each screen puts its own back arrow inside
/// [children]. The sheet starts [sheetOffset] below the status bar — read from
/// `MediaQuery`, never a hardcoded 44 — which Figma draws as 61 on Edit Profile
/// and 56 on Subscription Detail.
class TealSheetScaffold extends StatelessWidget {
  const TealSheetScaffold({
    super.key,
    required this.children,
    this.sheetOffset = 61,
  });

  final List<Widget> children;
  final double sheetOffset;

  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final inset = MediaQuery.paddingOf(context).top;
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    final sheetTop = inset + sheetOffset;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        backgroundColor: AppPalette.secondary,
        body: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: sheetTop + _radius * 2,
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
                    top: Radius.circular(_radius),
                  ),
                ),
                child: Center(
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 480),
                    child: ListView(
                      // The back arrow brings its own 4px, so 10 here puts a
                      // 20px disc 14 below the sheet's top edge, as drawn.
                      padding: EdgeInsets.fromLTRB(
                        21,
                        10,
                        21,
                        24 + bottomInset,
                      ),
                      children: children,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The back arrow both sheet screens put at the top of their content.
///
/// Edit Profile draws a bare teal arrow; Subscription Detail a 20px teal disc
/// with a white one ([filled]). Both are Figma's exported `arrow-right`,
/// mirrored.
class SheetBackArrow extends StatelessWidget {
  const SheetBackArrow({super.key, required this.onTap, this.filled = false});

  final VoidCallback onTap;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    // `ticket_arrow.svg` is Figma's right-pointing `arrow-right`, so it is
    // mirrored; the filled variant's export already points left.
    final glyph = SvgPicture.asset(
      filled
          ? 'assets/icons/sub_back_arrow.svg'
          : 'assets/icons/ticket_arrow.svg',
      height: filled ? 13 : 15.07,
      width: filled ? 13 : 15.07,
      colorFilter: filled
          ? null
          : const ColorFilter.mode(AppPalette.badgeTeal, BlendMode.srcIn),
    );
    final arrow = filled ? glyph : Transform.flip(flipX: true, child: glyph);
    return Align(
      alignment: Alignment.centerLeft,
      child: Semantics(
        button: true,
        label: 'Back',
        child: GestureDetector(
          onTap: onTap,
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: const EdgeInsets.all(4),
            child: filled
                ? Container(
                    height: 20,
                    width: 20,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                      color: AppPalette.badgeTeal,
                      shape: BoxShape.circle,
                    ),
                    child: arrow,
                  )
                : arrow,
          ),
        ),
      ),
    );
  }
}
