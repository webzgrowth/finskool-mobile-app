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
import 'package:finskool/src/presentation/pages/authentication/google_last_step/google_last_step_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/signup_success/signup_success_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/dashboard_shell_screen.dart';
import 'package:finskool/src/presentation/pages/communities/detail/community_detail_screen.dart';
import 'package:finskool/src/presentation/pages/communities/payment_success/payment_success_screen.dart';
import 'package:finskool/src/presentation/pages/communities/compliance/compliance_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_placeholder_screen.dart';

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
    // `verify_email/` is deliberately NOT routed. The backend has a single
    // signup OTP step (`/auth/mobile/verify-otp`, delivered by email as a
    // stand-in for WhatsApp), so `verify_phone/` is the only verification
    // screen in the flow. The screen's files and route constants stay put
    // for when a genuine second channel exists — see CLAUDE.md.
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

    ///  =================================================================
    ///  ********************* Community Routes ***************************
    ///  =================================================================
    // Ordered before `/community/:id` so the literal paths win — go_router
    // matches in declaration order, and `payment-success` would otherwise
    // be captured as an `:id`.
    GoRoute(
      name: AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_NAME,
      path: AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const PaymentSuccessScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_NAME,
      path: AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ComplianceScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.COMMUNITY_DETAIL_ROUTE_NAME,
      path: AppRoutes.COMMUNITY_DETAIL_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return CommunityDetailScreen(
          communityName: state.extra as String? ?? 'Community',
        );
      },
    ),

    ///  =================================================================
    ///  ********************** Profile Routes ******************************
    ///  =================================================================
    // Every one of these is a `ProfilePlaceholderScreen` — Figma draws the
    // menu row but not what's behind it. See CLAUDE.md "Profile".
    GoRoute(
      name: AppRoutes.EDIT_PROFILE_ROUTE_NAME,
      path: AppRoutes.EDIT_PROFILE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Edit Profile');
      },
    ),
    GoRoute(
      name: AppRoutes.ABOUT_SEBI_ROUTE_NAME,
      path: AppRoutes.ABOUT_SEBI_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'About & SEBI info');
      },
    ),
    GoRoute(
      name: AppRoutes.WELCOME_KITS_ROUTE_NAME,
      path: AppRoutes.WELCOME_KITS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Welcome kits');
      },
    ),
    GoRoute(
      name: AppRoutes.SUPPORT_TICKETS_ROUTE_NAME,
      path: AppRoutes.SUPPORT_TICKETS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'My tickets');
      },
    ),
    GoRoute(
      name: AppRoutes.HELP_SUPPORT_ROUTE_NAME,
      path: AppRoutes.HELP_SUPPORT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Help & support');
      },
    ),
    GoRoute(
      name: AppRoutes.GIVE_FEEDBACK_ROUTE_NAME,
      path: AppRoutes.GIVE_FEEDBACK_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Give feedback');
      },
    ),
    GoRoute(
      name: AppRoutes.SHARE_APP_ROUTE_NAME,
      path: AppRoutes.SHARE_APP_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        // Real sharing needs the `share_plus` package, not a dependency
        // yet — this stays a placeholder until that's added.
        return const ProfilePlaceholderScreen(title: 'Share the app');
      },
    ),
    GoRoute(
      name: AppRoutes.TERMS_PRIVACY_ROUTE_NAME,
      path: AppRoutes.TERMS_PRIVACY_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Terms & privacy policy');
      },
    ),

    ///  =================================================================
    ///  ********************** Dashboard Route ****************************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.DASHBOARD_ROUTE_NAME,
      path: AppRoutes.DASHBOARD_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const DashboardShellScreen();
      },
    ),
  ],
);