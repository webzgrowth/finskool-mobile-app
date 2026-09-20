import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The gradient-grid search bar shared by the Feed and Communities tabs.
///
/// Extracted from `FeedTopBar`, which was hardcoded to `FeedFilterBloc` and
/// the feed's hint text. Both tabs use the identical chrome in Figma, so
/// this owns the layout and each tab supplies its own copy and callbacks.
class SearchTopBar extends StatelessWidget {
  const SearchTopBar({
    super.key,
    required this.hintText,
    required this.onQueryChanged,
    this.onFilterTap,
    this.notificationCount,
  });

  final String hintText;
  final ValueChanged<String> onQueryChanged;
  final VoidCallback? onFilterTap;

  /// Shown as a red count bubble on the bell. Null or 0 renders the plain
  /// dot instead.
  final int? notificationCount;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.fromLTRB(
          AppSpacing.lg,
          topInset + AppSpacing.sm,
          AppSpacing.lg,
          AppSpacing.md,
        ),
        decoration: const BoxDecoration(
          // The source PNG has its own rounded bottom corners baked in, but
          // `BoxFit.cover` crops the excess width from the sides — exactly
          // where those corners live. Round it here instead.
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(AppRadii.lg),
          ),
          image: DecorationImage(
            image: AssetImage('assets/images/feed_top_bar_bg.png'),
            fit: BoxFit.cover,
            alignment: Alignment.center,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Container(
                alignment: Alignment.center,
                height: 44,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.18),
                  borderRadius: AppRadii.medium,
                ),
                child: Row(
                  children: [
                    Icon(Icons.search,
                        color: Colors.white.withValues(alpha: 0.85)),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      // Without an explicit `fontSize`/`height` this field
                      // inherits the theme's `titleMedium` (14sp, height
                      // 1.40), giving it a much taller line-box than the
                      // 24px icons beside it — the hint then sits visibly
                      // high. `textAlignVertical` can't fix an oversized
                      // line-box and a SizedBox only clips it. Pin the box
                      // with `height: 1.0` plus a matching `strutStyle`.
                      child: TextField(
                        style: const TextStyle(
                            color: Colors.white, fontSize: 14, height: 1.0),
                        strutStyle:
                            const StrutStyle(fontSize: 14, height: 1.0),
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: onQueryChanged,
                        // `InputDecoration.collapsed` only nulls the base
                        // `border`; the global InputDecorationTheme still
                        // supplies a `focusedBorder` that leaks through on
                        // tap. Null every state explicitly.
                        decoration: InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          hintText: hintText,
                          hintStyle: const TextStyle(
                              color: Colors.white70,
                              fontSize: 14,
                              height: 1.0),
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
                        child: Icon(Icons.tune,
                            color: Colors.white.withValues(alpha: 0.85)),
                      ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            _NotificationBell(count: notificationCount),
          ],
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
      height: 44,
      width: 44,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        clipBehavior: Clip.none,
        children: [
          // The exact teal-outlined bell from Figma (`750:1626`). Its
          // export baked in a red dot and a literal "3"; both were stripped
          // so the count below can be real.
          SvgPicture.asset('assets/icons/bell.svg', height: 19, width: 15),
          if (showCount)
            Positioned(
              top: 5,
              right: 4,
              child: Container(
                height: 15,
                constraints: const BoxConstraints(minWidth: 15),
                padding: const EdgeInsets.symmetric(horizontal: 3),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppPalette.notificationDot,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  border: Border.all(color: Colors.white, width: 1.2),
                ),
                child: Text(
                  count! > 99 ? '99+' : '$count',
                  style: const TextStyle(
                    inherit: false,
                    color: Colors.white,
                    fontSize: 8,
                    height: 1.0,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
