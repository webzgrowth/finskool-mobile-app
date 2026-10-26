import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show SystemUiOverlayStyle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';

import 'widgets/splash_logo.dart';
import 'widgets/splash_ripple.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // Plays once: the logo's pop-in, and the light-sweep near its tail end.
  late final AnimationController _entrance = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 900),
  )..forward();

  // Loops for as long as the splash is on screen: the ripples and the
  // logo's breathing glow. Entirely separate from `_entrance` — these two
  // don't share a timeline, so the loop doesn't restart or stutter once
  // the entrance finishes.
  late final AnimationController _pulse = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1800),
  )..repeat();

  late final Animation<double> _fade = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0, 0.5, curve: Curves.easeOut),
  );

  // A slight overshoot past 1.0 before settling — reads as a soft "pop"
  // rather than a flat scale-up.
  late final Animation<double> _scale = TweenSequence([
    TweenSequenceItem(
      weight: 65,
      tween: Tween(
        begin: 0.5,
        end: 1.08,
      ).chain(CurveTween(curve: Curves.easeOutCubic)),
    ),
    TweenSequenceItem(
      weight: 35,
      tween: Tween(
        begin: 1.08,
        end: 1.0,
      ).chain(CurveTween(curve: Curves.easeOut)),
    ),
  ]).animate(_entrance);

  // Runs only across the entrance's last 40% — the sweep crosses the logo
  // right as it finishes settling, not while it's still popping in.
  late final Animation<double> _sweep = CurvedAnimation(
    parent: _entrance,
    curve: const Interval(0.6, 1.0, curve: Curves.easeInOut),
  );

  @override
  void initState() {
    super.initState();
    context.read<AuthenticatorWatcherBloc>().add(
      const AuthenticatorWatcherEvent.authCheckRequest(),
    );
  }

  @override
  void dispose() {
    _entrance.dispose();
    _pulse.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // The check itself is a local prefs read, so hold the splash briefly
    // rather than flashing it for a single frame — long enough here to let
    // the entrance animation actually finish playing before it's gone.
    return BlocListener<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listener: (context, state) async {
        final destination = state.maybeMap(
          authenticated: (_) => AppRoutes.DASHBOARD_ROUTE_PATH,
          unauthenticated: (_) => AppRoutes.LOGIN_ROUTE_PATH,
          orElse: () => null,
        );
        if (destination == null) return;
        await Future<void>.delayed(const Duration(milliseconds: 1500));
        if (context.mounted) context.go(destination);
      },
      child: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Scaffold(
          // Same brand gradient-plus-grid plate the auth header uses
          // (`auth_header_bg.png`) rather than a flat teal fill, so the
          // splash reads as the same visual family as what follows it.
          body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/auth_header_bg.png'),
                fit: BoxFit.cover,
                alignment: Alignment.center,
              ),
            ),
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SplashRipples(pulse: _pulse),
                  FadeTransition(
                    opacity: _fade,
                    child: ScaleTransition(
                      scale: _scale,
                      child: SplashLogo(glow: _pulse, sweep: _sweep),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
