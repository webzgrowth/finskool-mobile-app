import 'dart:math' as math;
import 'dart:ui' show ImageFilter;

import 'package:flutter/material.dart';
import 'package:finskool/src/comman/design_metrics.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The gradient-grid search bar shared by the Feed and Communities tabs —
/// Final page `iPhone 16 - 12` (`605:15302`).
///
/// Measured: the hero is 62px of content under the status bar; the glass
/// search field is 36 tall at 16px below the inset (r10.55, white at 12% with
/// a white-18% hairline), its search glyph 17px in and the filter button a
/// 23px chip 9px from the right edge; the bell is a 29px white disc, 25px off
/// the field. Each tab supplies its own copy and callbacks.
class SearchTopBar extends StatelessWidget {
  const SearchTopBar({
    super.key,
    required this.hintText,
    required this.onQueryChanged,
    this.onFilterTap,
    this.notificationCount,
    this.onBack,
    this.title,
    this.showNotifications = true,
  });

  final String hintText;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback? onFilterTap;

  /// Shown as a red count on the bell. Null or 0 draws the bell bare.
  final int? notificationCount;

  /// A back arrow and screen title above the search field, for a *pushed*
  /// feed (a single community). The two tabs pass neither.
  final VoidCallback? onBack;
  final String? title;

  /// The bell belongs to the two **tabs**; a pushed community feed drops it.
  final bool showNotifications;

  /// Content height **without** the title row, excluding the status-bar inset
  /// (`SliverAppBar` adds that itself): 12 above the field, 36 for it, 14
  /// below. `SliverAppBar` needs its `toolbarHeight` up front, so this is
  /// published rather than hardcoded at the call sites.
  static const double baseHeight = 62;

  static const double _titleFontSize = 16;
  static const double _backIconSize = 22;

  /// The toolbar height a bar with these options needs. The title row is
  /// **measured, not a constant**: at a large system font a fixed 30px would
  /// clip the title inside the fixed-height `SliverAppBar`.
  ///
  /// It also pays [statusBarShortfall]: the bar is sized under Figma's 44pt
  /// status bar, and the `SliverAppBar` only adds the device's own inset (24dp
  /// on many Androids), which left the bar visibly short there.
  static double heightFor(BuildContext context, {bool hasTitle = false}) {
    final shortfall = statusBarShortfall(context);
    if (!hasTitle) return baseHeight + shortfall;
    final titleHeight =
        MediaQuery.textScalerOf(context).scale(_titleFontSize) * 1.3;
    return baseHeight +
        shortfall +
        math.max(_backIconSize, titleHeight) +
        AppSpacing.sm;
  }

  @override
  Widget build(BuildContext context) {
    final topInset = designTopInset(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          14,
          topInset + (title != null || onBack != null ? AppSpacing.sm : 12),
          showNotifications ? 25 : 14,
          14,
        ),
        decoration: const BoxDecoration(
          // The hero art is 393 wide at 1:1 with Figma's frame, so it is fitted
          // to the **width** and pinned to the top: `BoxFit.cover` would scale
          // it up to the taller (inset-inclusive) bar and stretch the grid's
          // 41.9px pitch. Below the art, on a tall status bar, the bar's own
          // gradient continues in the art's last colours.
          gradient: LinearGradient(
            colors: [AppPalette.topBarBaseLeft, AppPalette.topBarBaseRight],
          ),
          // The source PNG has its own rounded bottom corners baked in, but
          // fitting to width crops nothing there; round it here regardless.
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(10)),
          image: DecorationImage(
            image: AssetImage('assets/images/feed_top_bar_bg.png'),
            fit: BoxFit.fitWidth,
            alignment: Alignment.topCenter,
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (onBack != null || title != null) ...[
              Row(
                children: [
                  if (onBack != null)
                    GestureDetector(
                      onTap: onBack,
                      behavior: HitTestBehavior.opaque,
                      child: const Padding(
                        padding: EdgeInsets.only(right: AppSpacing.sm),
                        child: Icon(
                          Icons.arrow_back,
                          color: AppPalette.white,
                          size: _backIconSize,
                        ),
                      ),
                    ),
                  if (title != null)
                    Expanded(
                      child: Text(
                        title!,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.topBarType.title,
                      ),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
            ],
            Row(
              children: [
                Expanded(
                  child: _SearchField(
                    hintText: hintText,
                    onChanged: onQueryChanged,
                    onFilterTap: onFilterTap,
                  ),
                ),
                if (showNotifications) ...[
                  const SizedBox(width: 25),
                  _NotificationBell(count: notificationCount),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _SearchField extends StatelessWidget {
  const _SearchField({
    required this.hintText,
    required this.onChanged,
    required this.onFilterTap,
  });

  final String hintText;
  final ValueChanged<String> onChanged;
  final VoidCallback? onFilterTap;

  @override
  Widget build(BuildContext context) {
    final type = context.topBarType;
    return _Glass(
      radius: 10.55,
      blur: 8,
      child: SizedBox(
        height: 36,
        child: Padding(
          padding: const EdgeInsets.only(left: 17, right: 7),
          child: Row(
            children: [
              _Scaled(SvgPicture.asset('assets/icons/topbar_search.svg')),
              const SizedBox(width: 3.2),
              Expanded(
                // Pin the line box (`height: 1.0` plus a matching strut): left
                // to inherit the theme's `titleMedium` (14sp, 1.4) the
                // field's line-box is taller than the glyph and the text sits
                // high.
                child: TextField(
                  style: type.input,
                  strutStyle: StrutStyle(
                    fontSize: type.input.fontSize,
                    height: 1.0,
                  ),
                  cursorColor: AppPalette.white,
                  textAlignVertical: TextAlignVertical.center,
                  onChanged: onChanged,
                  // `InputDecoration.collapsed` only nulls the base `border`;
                  // the global InputDecorationTheme still supplies per-state
                  // borders (and a 16px `contentPadding`) that leak through.
                  decoration: InputDecoration(
                    isCollapsed: true,
                    filled: false,
                    contentPadding: EdgeInsets.zero,
                    hintText: hintText,
                    hintStyle: type.hint,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    errorBorder: InputBorder.none,
                    focusedErrorBorder: InputBorder.none,
                    disabledBorder: InputBorder.none,
                  ),
                ),
              ),
              if (onFilterTap != null)
                GestureDetector(
                  onTap: onFilterTap,
                  behavior: HitTestBehavior.opaque,
                  child: _Glass(
                    radius: 6.76,
                    blur: 6,
                    lift: 0.05,
                    rim: false,
                    child: SizedBox(
                      height: 23,
                      width: 23,
                      child: Center(
                        child: _Scaled(
                          SvgPicture.asset('assets/icons/topbar_filter.svg'),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Figma's "glass" fill: the backdrop blurred behind a translucent white, lit
/// from the top-left (the file sets light angle -45°, intensity 0.8) — a
/// brighter wash and rim on the lit corner that falls off toward the opposite
/// one. [lift] adds extra white for the small filter chip, which Figma fills
/// with white at 14% on top of the glass.
class _Glass extends StatelessWidget {
  const _Glass({
    required this.child,
    required this.radius,
    required this.blur,
    this.lift = 0,
    this.rim = true,
  });

  final Widget child;
  final double radius;
  final double blur;
  final double lift;

  /// Figma draws a rim on the field but not on the filter chip inside it.
  final bool rim;

  @override
  Widget build(BuildContext context) {
    final shape = BorderRadius.circular(radius);
    return ClipRRect(
      borderRadius: shape,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: shape,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppPalette.white.withValues(alpha: 0.15 + lift),
                AppPalette.white.withValues(alpha: 0.09 + lift),
              ],
            ),
            // Figma's stroke: white at 18%, 1px, uniform.
            border: rim ? Border.all(color: AppPalette.topBarStroke) : null,
          ),
          child: child,
        ),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({this.count});

  final int? count;

  @override
  Widget build(BuildContext context) {
    final showCount = count != null && count! > 0;
    return Container(
      height: 29.17,
      width: 29.17,
      decoration: const BoxDecoration(
        color: AppPalette.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Figma's own bell (13.08x14.5), centred on the disc. Its export
          // baked in a red dot and a literal "3"; both are drawn separately so
          // the count is real.
          Center(
            child: _Scaled(SvgPicture.asset('assets/icons/topbar_bell.svg')),
          ),
          if (showCount)
            Positioned(
              top: 5,
              left: 14.6,
              child: Container(
                height: 6.52,
                constraints: const BoxConstraints(minWidth: 6.52),
                padding: EdgeInsets.symmetric(horizontal: count! > 9 ? 1.5 : 0),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppPalette.topBarBellDot,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text(
                  count! > 99 ? '99+' : '$count',
                  style: context.topBarType.badge,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Grows one of Figma's small glyphs on Android — see [iconScaleOf]. A
/// transform, so the glyph's layout box (and everything around it) is
/// untouched.
class _Scaled extends StatelessWidget {
  const _Scaled(this.child);

  final Widget child;

  @override
  Widget build(BuildContext context) =>
      Transform.scale(scale: iconScaleOf(context), child: child);
}
