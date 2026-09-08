import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart';

/// Routes to the dashboard on a successful Google sign-in, or shows the
/// error as a snackbar — shared by any screen offering a Google button.
class GoogleSigninListener extends StatelessWidget {
  const GoogleSigninListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<GoogleSigninBloc, GoogleSigninState>(
      listenWhen: (p, c) => p.requestState != c.requestState,
      listener: (context, state) {
        if (state.requestState.isLoaded) {
          context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
        } else if (state.requestState.isError) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      child: child,
    );
  }
}
