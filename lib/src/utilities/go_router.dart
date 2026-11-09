import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/utilities/page_transitions.dart';
import 'package:finskool/src/presentation/pages/splash/splash_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/auth_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/auth_tab_switch.dart';
import 'package:finskool/src/presentation/pages/authentication/reset_password/reset_password_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/verify_reset_code/verify_reset_code_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/new_password/new_password_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/password_reset_success/password_reset_success_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/verify_phone/verify_phone_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/google_last_step/google_last_step_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/social_link/social_link_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/social_verify/social_verify_screen.dart';
import 'package:finskool/src/presentation/pages/authentication/signup_success/signup_success_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/dashboard_shell_screen.dart';
import 'package:finskool/src/presentation/pages/communities/detail/community_detail_screen.dart';
import 'package:finskool/src/presentation/pages/communities/checkout/checkout_webview_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_screen.dart';
import 'package:finskool/src/presentation/pages/notifications/notifications_screen.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/about_sebi_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/help_support_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/delete_account_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/policy_document_screen.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/info/terms_privacy_screen.dart';
import 'package:finskool/src/presentation/pages/services/chat/service_chat_screen.dart';
import 'package:finskool/src/presentation/pages/services/requests/service_requests_screen.dart';
import 'package:finskool/src/presentation/pages/communities/payment_success/payment_success_screen.dart';
import 'package:finskool/src/presentation/pages/communities/compliance/compliance_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/profile_placeholder_screen.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/edit_profile/edit_profile_screen.dart';
import 'package:finskool/src/presentation/pages/communities/subscription_detail/subscription_detail_screen.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/presentation/pages/tickets/detail/ticket_detail_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/form/raise_ticket_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/list/tickets_screen.dart';
import 'package:finskool/src/presentation/pages/tickets/submitted/ticket_submitted_screen.dart';

GoRouter routerinit = GoRouter(
  routes: <RouteBase>[
    ///  =================================================================
    ///  ********************** Splash Route *****************************
    /// ==================================================================
    GoRoute(
      name: AppRoutes.SPLASH_ROUTE_NAME,
      path: AppRoutes.SPLASH_ROUTE_PATH,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          fadeThroughPage(state, const SplashScreen()),
    ),

    ///  =================================================================
    ///  ******************** Authentication Routes ***********************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.LOGIN_ROUTE_NAME,
      path: AppRoutes.LOGIN_ROUTE_PATH,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          fadeThroughPage(state, const AuthScreen(initialTab: AuthTab.login)),
    ),
    GoRoute(
      name: AppRoutes.SIGNUP_ROUTE_NAME,
      path: AppRoutes.SIGNUP_ROUTE_PATH,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          fadeThroughPage(state, const AuthScreen(initialTab: AuthTab.signUp)),
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
      name: AppRoutes.SOCIAL_LINK_ROUTE_NAME,
      path: AppRoutes.SOCIAL_LINK_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SocialLinkScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.SOCIAL_VERIFY_ROUTE_NAME,
      path: AppRoutes.SOCIAL_VERIFY_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const SocialVerifyScreen();
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
      name: AppRoutes.COMMUNITY_PERFORMANCE_ROUTE_NAME,
      path: AppRoutes.COMMUNITY_PERFORMANCE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) => PerformanceScreen(
        communityId: state.pathParameters['id']!,
        communityName: state.extra as String?,
      ),
    ),
    GoRoute(
      name: AppRoutes.SUBSCRIPTION_DETAIL_ROUTE_NAME,
      path: AppRoutes.SUBSCRIPTION_DETAIL_ROUTE_PATH,
      // A tap on a payment/expiry notification has only a community id, not
      // the model the screen needs. Look it up in the loaded catalog; if it
      // isn't there (cold start, or not subscribed) fall back to the community
      // itself rather than a screen with nothing to show.
      redirect: (BuildContext context, GoRouterState state) {
        if (state.extra is CommunityModel) return null;
        final id = state.uri.queryParameters['id'];
        if (id == null || id.isEmpty) return AppRoutes.DASHBOARD_ROUTE_PATH;
        return _subscribedCommunity(context, id) == null
            ? '/community/$id'
            : null;
      },
      builder: (BuildContext context, GoRouterState state) {
        final community =
            state.extra as CommunityModel? ??
            _subscribedCommunity(context, state.uri.queryParameters['id']!)!;
        return SubscriptionDetailScreen(community: community);
      },
    ),
    GoRoute(
      name: AppRoutes.NOTIFICATIONS_ROUTE_NAME,
      path: AppRoutes.NOTIFICATIONS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const NotificationsScreen(),
    ),
    GoRoute(
      name: AppRoutes.COMMUNITY_CHECKOUT_ROUTE_NAME,
      path: AppRoutes.COMMUNITY_CHECKOUT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const CheckoutWebViewScreen(),
    ),
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
        // `extra` carries the whole model from the Communities tab; a cold
        // deep link to /community/:id has none, so fall back to the path
        // parameter and a generic title rather than failing to build.
        final community = state.extra as CommunityModel?;
        return CommunityDetailScreen(
          communityId: community?.id ?? state.pathParameters['id'] ?? '',
          communityName: community?.name ?? 'Community',
        );
      },
    ),

    ///  =================================================================
    ///  ********************** Profile Routes ******************************
    ///  =================================================================
    // About & SEBI, Terms & privacy and Help & support are real screens
    // (`profile/info/`); the rest are still a `ProfilePlaceholderScreen` —
    // Figma draws the menu row but not what's behind it. See CLAUDE.md "Profile".
    GoRoute(
      name: AppRoutes.EDIT_PROFILE_ROUTE_NAME,
      path: AppRoutes.EDIT_PROFILE_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const EditProfileScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.ABOUT_SEBI_ROUTE_NAME,
      path: AppRoutes.ABOUT_SEBI_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const AboutSebiScreen();
      },
    ),
    GoRoute(
      name: AppRoutes.SUPPORT_TICKETS_ROUTE_NAME,
      path: AppRoutes.SUPPORT_TICKETS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const TicketsScreen(),
    ),
    // `new` and `submitted` before `:id`, or go_router reads them as ids.
    GoRoute(
      name: AppRoutes.TICKET_NEW_ROUTE_NAME,
      path: AppRoutes.TICKET_NEW_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const RaiseTicketScreen(),
    ),
    GoRoute(
      name: AppRoutes.TICKET_SUBMITTED_ROUTE_NAME,
      path: AppRoutes.TICKET_SUBMITTED_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          TicketSubmittedScreen(ticket: state.extra! as TicketModel),
    ),
    GoRoute(
      name: AppRoutes.TICKET_DETAIL_ROUTE_NAME,
      path: AppRoutes.TICKET_DETAIL_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          TicketDetailScreen(ticketId: state.pathParameters['id']!),
    ),

    ///  ********************* Services Routes ****************************
    // `requests` is a literal, so it goes before the `:id` path.
    GoRoute(
      name: AppRoutes.SERVICE_REQUESTS_ROUTE_NAME,
      path: AppRoutes.SERVICE_REQUESTS_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const ServiceRequestsScreen(),
    ),
    GoRoute(
      name: AppRoutes.SERVICE_CHAT_ROUTE_NAME,
      path: AppRoutes.SERVICE_CHAT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          ServiceChatScreen(requestId: state.pathParameters['id']!),
    ),
    GoRoute(
      name: AppRoutes.HELP_SUPPORT_ROUTE_NAME,
      path: AppRoutes.HELP_SUPPORT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const HelpSupportScreen();
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
      name: AppRoutes.PRIVACY_SECURITY_ROUTE_NAME,
      path: AppRoutes.PRIVACY_SECURITY_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        return const ProfilePlaceholderScreen(title: 'Privacy & security');
      },
    ),
    GoRoute(
      name: AppRoutes.DELETE_ACCOUNT_ROUTE_NAME,
      path: AppRoutes.DELETE_ACCOUNT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) =>
          const DeleteAccountScreen(),
    ),
    GoRoute(
      name: AppRoutes.POLICY_DOCUMENT_ROUTE_NAME,
      path: AppRoutes.POLICY_DOCUMENT_ROUTE_PATH,
      builder: (BuildContext context, GoRouterState state) {
        final kind = PolicyKind.fromSlug(state.pathParameters['kind']);
        return kind == null
            ? const ProfilePlaceholderScreen(title: 'Document')
            : PolicyDocumentScreen(kind: kind);
      },
    ),
    GoRoute(
      name: AppRoutes.TERMS_PRIVACY_ROUTE_NAME,
      path: AppRoutes.TERMS_PRIVACY_ROUTE_PATH,
      // `?tab=privacy` opens on the Privacy policy tab — the About screen's
      // "Privacy policy" row uses it.
      builder: (BuildContext context, GoRouterState state) =>
          TermsPrivacyScreen(
            initialTab: state.uri.queryParameters['tab'] == 'privacy' ? 1 : 0,
          ),
    ),

    ///  =================================================================
    ///  ********************** Dashboard Route ****************************
    ///  =================================================================
    GoRoute(
      name: AppRoutes.DASHBOARD_ROUTE_NAME,
      path: AppRoutes.DASHBOARD_ROUTE_PATH,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          fadeThroughPage(state, const DashboardShellScreen()),
    ),
  ],
);

/// The member's own subscription to [id] from the already-loaded catalog, or
/// null. Used to open My subscription from a notification.
CommunityModel? _subscribedCommunity(BuildContext context, String id) {
  for (final c in context.read<CommunitiesBloc>().state.communities) {
    if (c.id == id && c.access == CommunityAccess.subscribed) return c;
  }
  return null;
}
