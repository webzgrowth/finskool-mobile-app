import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

/// Push/pop for every ordinary route on Android and other non-Apple
/// platforms: the incoming page slides in 10% of the width while fading up,
/// and the page it covers drifts the other way and dims a touch — a parallax
/// that reads as depth rather than a hard cut.
///
/// iOS and macOS keep the native Cupertino transition (see [pageTransitions]):
/// it is already the right motion there, and replacing it would lose the
/// interactive swipe-back gesture, which only that builder provides.
class PremiumPageTransitionsBuilder extends PageTransitionsBuilder {
  const PremiumPageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    final enter = CurvedAnimation(
      parent: animation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    final cover = CurvedAnimation(
      parent: secondaryAnimation,
      curve: Curves.easeOutCubic,
      reverseCurve: Curves.easeInCubic,
    );
    return SlideTransition(
      position: Tween(
        begin: Offset.zero,
        end: const Offset(-0.06, 0),
      ).animate(cover),
      child: FadeTransition(
        opacity: Tween(begin: 1.0, end: 0.86).animate(cover),
        child: SlideTransition(
          position: Tween(
            begin: const Offset(0.1, 0),
            end: Offset.zero,
          ).animate(enter),
          child: FadeTransition(
            opacity: CurvedAnimation(
              parent: animation,
              curve: const Interval(0, 0.7, curve: Curves.easeOut),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

/// The theme's page transitions: Cupertino on Apple platforms (with its
/// swipe-back), [PremiumPageTransitionsBuilder] everywhere else.
const PageTransitionsTheme pageTransitions = PageTransitionsTheme(
  builders: {
    TargetPlatform.android: PremiumPageTransitionsBuilder(),
    TargetPlatform.fuchsia: PremiumPageTransitionsBuilder(),
    TargetPlatform.linux: PremiumPageTransitionsBuilder(),
    TargetPlatform.windows: PremiumPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    TargetPlatform.macOS: CupertinoPageTransitionsBuilder(),
  },
);

/// A fade-through for **replacing** the whole screen — splash to login, login
/// to the dashboard, sign-out back to login. A directional slide would imply
/// "forward" where there is no stack to go back to; a soft cross-fade with a
/// 2% settle reads as arriving somewhere new.
CustomTransitionPage<void> fadeThroughPage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 420),
    reverseTransitionDuration: const Duration(milliseconds: 300),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      final curved = CurvedAnimation(
        parent: animation,
        curve: Curves.easeOutCubic,
      );
      return FadeTransition(
        opacity: curved,
        child: ScaleTransition(
          scale: Tween(begin: 0.98, end: 1.0).animate(curved),
          child: child,
        ),
      );
    },
  );
}
