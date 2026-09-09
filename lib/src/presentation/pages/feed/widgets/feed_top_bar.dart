import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';

import 'feed_filter_sheet.dart';

/// The gradient-grid search bar — uses the exact background asset
/// exported from Figma for this bar specifically (wider/shorter than the
/// auth screens' `auth_header_bg.png`, so it isn't reused here).
class FeedTopBar extends StatelessWidget {
  const FeedTopBar({super.key});

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
          // The source PNG has its own rounded bottom corners baked in,
          // but `BoxFit.cover` scales it up to match this bar's height
          // (proportionally taller/narrower than the 1572x424 source),
          // which crops the excess width from the sides — exactly where
          // those corners live. Round it here instead, independent of
          // whatever the source image's own corners survive.
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
                    Icon(
                      Icons.search,
                      color: Colors.white.withValues(alpha: 0.85),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      // Root cause of the vertical misalignment: with no
                      // explicit `fontSize`/`height`, this field's style
                      // merges with the theme's `titleMedium` (14sp,
                      // height: 1.40 — see app_text_theme.dart), giving it
                      // a much taller line-box than the 24px icons beside
                      // it. `textAlignVertical.center` only repositions
                      // content within *extra* space — it can't fix an
                      // oversized line-box, and clamping the height via a
                      // SizedBox just clips that oversized box from the
                      // bottom instead of shrinking it, which is why that
                      // was tried and still looked top-anchored. Pin the
                      // line-box itself to the glyph size with `height:
                      // 1.0` + a matching `strutStyle` instead.
                      child: TextField(
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          height: 1.0,
                        ),
                        strutStyle: const StrutStyle(fontSize: 14, height: 1.0),
                        textAlignVertical: TextAlignVertical.center,
                        onChanged: (v) => context.read<FeedFilterBloc>().add(
                          FeedFilterEvent.queryChanged(v),
                        ),
                        // `InputDecoration.collapsed` only nulls the base
                        // `border` field — the global InputDecorationTheme
                        // still supplies its own `focusedBorder` (a visible
                        // pill), which leaks through once this field is
                        // tapped. Null every border state explicitly, same
                        // fix as OtpBoxes/PhoneField elsewhere in this app.
                        decoration: const InputDecoration(
                          isCollapsed: true,
                          filled: false,
                          hintText: 'Search posts, stocks or tags...',
                          hintStyle: TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                            height: 1.0,
                          ),
                          border: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          errorBorder: InputBorder.none,
                          focusedErrorBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () => showFeedFilterSheet(context),
                      child: Icon(
                        Icons.tune,
                        color: Colors.white.withValues(alpha: 0.85),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const _NotificationBell(),
          ],
        ),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 44,
      width: 44,
      decoration: const BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          const Icon(Icons.notifications_outlined),
          Positioned(
            top: 10,
            right: 10,
            child: Container(
              height: 8,
              width: 8,
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
