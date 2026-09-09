import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/presentation/bloc/authentication/authenticator_watcher/authenticator_watcher_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/signup_verification/signup_verification_bloc.dart';
import 'package:finskool/src/presentation/bloc/dashboard/bottom_nav/bottom_nav_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/utilities/app_bloc_observer.dart';
import 'package:finskool/src/utilities/go_router.dart';
import 'package:finskool/src/utilities/logger.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';
import 'package:finskool/src/utilities/theme/theme.dart';


void main() async{
  logger.runLogging(
    () => runZonedGuarded(
      () async {
        WidgetsFlutterBinding.ensureInitialized();

        // Bloc.transformer = bloc_concurrency.sequential();
        Bloc.observer = const AppBlocObserver();

        // await ErrorStack.init();
        configureDependencies();
        await SharedPreferenceHelper().init();
        runApp(const MyApp());
      },
      logger.logZoneError,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        // auth
        BlocProvider(create: (_) => locator<AuthenticatorWatcherBloc>()),
        BlocProvider(create: (_) => locator<LoginFormBloc>()),
        BlocProvider(create: (_) => locator<SignUpFormBloc>()),
        BlocProvider(create: (_) => locator<GoogleSigninBloc>()),
        BlocProvider(create: (_) => locator<PasswordResetBloc>()),
        BlocProvider(create: (_) => locator<SignupVerificationBloc>()),
        // dashboard / feed
        BlocProvider(create: (_) => locator<BottomNavBloc>()),
        BlocProvider(create: (_) => locator<FeedBloc>()),
        BlocProvider(create: (_) => locator<FeedFilterBloc>()),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: "Finskool",
        theme: AppTheme.light,
        darkTheme: AppTheme.dark,
        themeMode: ThemeMode.light,
        routerConfig: routerinit,
      ),
    );
  }
}
