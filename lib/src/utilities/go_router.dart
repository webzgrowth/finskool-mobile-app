import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/pages/splash/splash_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/auth_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_tab_switch.dart';
import 'package:finskool/src/presentation/pages/authentication/reset_password/reset_password_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/verify_reset_code/verify_reset_code_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/new_password/new_password_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/password_reset_success/password_reset_success_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/verify_phone/verify_phone_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/verify_email/verify_email_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/google_last_step/google_last_step_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/signup_success/signup_success_screen.dart';

GoRouter routerinit = GoRouter(
  routes: <RouteBase>[
    ///  =================================================================
    ///  ********************** Splash Route *****************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.SPLASH_ROUTE_NAME,
      path: AppRoutes.SPLASH_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SplashScreen();
      },
    ),

    ///  =================================================================
    ///  ******************** Authentication Routes ***********************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.LOGIN_ROUTE_NAME,
      path: AppRoutes.LOGIN_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen(initialTab: AuthTab.login);
      },
    ),
    GoRoute(
      name: AppRoutes.SIGNUP_ROUTE_NAME,
      path: AppRoutes.SIGNUP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const AuthScreen(initialTab: AuthTab.signUp);
      },
    ),

    ///  =================================================================
    ///  ******************** Password Reset Routes ************************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.RESET_PASSWORD_ROUTE_NAME,
      path: AppRoutes.RESET_PASSWORD_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ResetPasswordScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.VERIFY_RESET_CODE_ROUTE_NAME,
      path: AppRoutes.VERIFY_RESET_CODE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyResetCodeScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.NEW_PASSWORD_ROUTE_NAME,
      path: AppRoutes.NEW_PASSWORD_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const NewPasswordScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.PASSWORD_RESET_SUCCESS_ROUTE_NAME,
      path: AppRoutes.PASSWORD_RESET_SUCCESS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const PasswordResetSuccessScreen();
      },
    ),

    ///  =================================================================
    ///  ****************** Signup Verification Routes ********************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.VERIFY_PHONE_ROUTE_NAME,
      path: AppRoutes.VERIFY_PHONE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyPhoneScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.VERIFY_EMAIL_ROUTE_NAME,
      path: AppRoutes.VERIFY_EMAIL_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const VerifyEmailScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.GOOGLE_LAST_STEP_ROUTE_NAME,
      path: AppRoutes.GOOGLE_LAST_STEP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const GoogleLastStepScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.SIGNUP_SUCCESS_ROUTE_NAME,
      path: AppRoutes.SIGNUP_SUCCESS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SignupSuccessScreen();
      },
    ),
  ],
);