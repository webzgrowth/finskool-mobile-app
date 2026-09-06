import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Auth-state resolution (AuthenticatorWatcherBloc.authCheckRequest) is
    // not wired yet — see CLAUDE.md "Known gaps". Route straight to Login
    // so the auth screens are reachable until that lands.
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) context.go(AppRoutes.LOGIN_ROUTE_PATH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Text(
          'Finskool',
          style: Theme.of(context)
              .textTheme
              .headlineLarge
              ?.copyWith(color: Colors.white),
        ),
      ),
    );
  }
}
