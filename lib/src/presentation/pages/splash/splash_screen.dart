import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    context
        .read<AuthenticatorWatcherBloc>()
        .add(const AuthenticatorWatcherEvent.authCheckRequest());
  }

  @override
  Widget build(BuildContext context) {
    // The check itself is a local prefs read, so hold the splash briefly
    // rather than flashing it for a single frame.
    return BlocListener<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listener: (context, state) async {
        final destination = state.maybeMap(
          authenticated: (_) => AppRoutes.DASHBOARD_ROUTE_PATH,
          unauthenticated: (_) => AppRoutes.LOGIN_ROUTE_PATH,
          orElse: () => null,
        );
        if (destination == null) return;
        await Future<void>.delayed(const Duration(milliseconds: 800));
        if (context.mounted) context.go(destination);
      },
      child: Scaffold(
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
      ),
    );
  }
}
