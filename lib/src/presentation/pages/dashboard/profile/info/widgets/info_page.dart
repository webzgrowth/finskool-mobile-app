import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/design_metrics.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The chrome shared by About & SEBI info, Terms & privacy policy and Help &
/// support (Final page `1554:8149` / `1554:8682`): the teal hero with the
/// title *inside* it, and a white sheet riding up over its bottom.
///
/// Not [TealSheetScaffold]: that one puts a teal back arrow on the white
/// sheet, whereas these screens draw a translucent 34px back button and a
/// white title in the hero itself, with the sheet 84px under the status bar
/// (that one is 56–61). Same `ticket_hero_bg.png`, same rule that the status
/// bar inset is read from `MediaQuery`, never hardcoded.
class InfoPage extends StatelessWidget {
  const InfoPage({
    super.key,
    required this.title,
    required this.subtitle,
    required this.children,
    this.controller,
    this.action,
    this.onRefresh,
  });

  final String title;
  final String subtitle;
  final List<Widget> children;

  /// For a screen that pages as the list nears its end (the notification
  /// inbox). The static info screens leave it null.
  final ScrollController? controller;

  /// A text action in the hero's top-right corner ("Mark all read").
  final Widget? action;

  /// Pull-to-refresh, when the list is live data.
  final Future<void> Function()? onRefresh;

  static const double _sheetBelowStatusBar = 84;
  static const double _radius = 16;

  @override
  Widget build(BuildContext context) {
    final inset = designTopInset(context);
    final sheetTop = inset + _sheetBelowStatusBar;
    final type = context.infoType;

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
            Positioned(
              left: 20,
              top: inset + 16,
              child: _BackButton(onTap: () => context.pop()),
            ),
            Positioned(
              left: 66,
              right: 20,
              top: inset + 12,
              child: Text(title, style: type.heroTitle),
            ),
            Positioned(
              left: 66,
              right: 20,
              top: inset + 39,
              child: Text(subtitle, style: type.heroSubtitle),
            ),
            if (action != null)
              Positioned(right: 20, top: inset + 22, child: action!),
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
                    child: _list(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _list(BuildContext context) {
    final list = ListView(
      controller: controller,
      physics: onRefresh == null ? null : const AlwaysScrollableScrollPhysics(),
      padding: EdgeInsets.fromLTRB(
        20,
        20,
        20,
        24 + MediaQuery.paddingOf(context).bottom,
      ),
      children: children,
    );
    return onRefresh == null
        ? list
        : RefreshIndicator(onRefresh: onRefresh!, child: list);
  }
}

/// 34px, white at 18% — Figma's `Back` frame. The glyph is the exported
/// `arrow-right`, mirrored, like every other back arrow here.
class _BackButton extends StatelessWidget {
  const _BackButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Back',
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 34,
          width: 34,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: Color(0x2EFFFFFF),
            shape: BoxShape.circle,
          ),
          child: Transform.flip(
            flipX: true,
            child: SvgPicture.asset(
              'assets/icons/arrow_right.svg',
              height: 16,
              width: 16,
              colorFilter: const ColorFilter.mode(
                AppPalette.white,
                BlendMode.srcIn,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
