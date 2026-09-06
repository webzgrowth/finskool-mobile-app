import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    // context.read<NetworkBloc>().add(NetworkObserve());
    // context.read<LocationBloc>().add(const LocationEvent.getpermission(false));

    Future.delayed(const Duration(seconds: 1), () {
      // Future.microtask(
      //   () => context.read<AuthenticatorWatcherBloc>().add(
      //         const AuthenticatorWatcherEvent.authCheckRequest(),
      //       ),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticatorWatcherBloc, AuthenticatorWatcherState>(
      listener: (context, state) {
        state.maybeMap(
          orElse: () {},
          authenticating: (_) {},
          authenticated: (_) async {
            // update fcm token
            // context.read<UpdateTokenCubit>().updateFcm();

            // context.replaceNamed(AppRoutes.DASHBOARD_ROUTE_NAME);
          },
          isFirstTime: (_) {
            // context.replaceNamed(AppRoutes.ONBOARDING_ROUTE_NAME);
          },
          unauthenticated: (_) {
            // context.replaceNamed(AppRoutes.LOGIN_ROUTE_NAME);
          },
        );
      },
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              // Expanded(
              //   child: Center(
              //     child: Image.asset(
              //       Assets.logo.logo.path,
              //       // AppImagesConstant.appLogo,
              //       height: 130,
              //       width: 130,
              //     ),
              //   ),
              // ),
              // Assets.images.splashImg.image(
              //   fit: BoxFit.cover,
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
