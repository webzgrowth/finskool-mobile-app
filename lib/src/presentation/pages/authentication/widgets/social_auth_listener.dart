import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';

/// The one place a social sign-in turns into navigation and snackbars, so the
/// screens it pushes stay free of both (and never show an error twice).
///
/// Wraps the login / sign-up screen, which stays mounted underneath the link,
/// phone and code screens and so hears every step. Pushes are keyed on the
/// *transition*, not the new step alone: going back from the code screen to
/// the phone screen and sending again must push the code screen once more,
/// and must not push the phone screen a second time (the bloc steps back to
/// `phoneRequired` when sending, so the next `codeSent` is a real change).
class SocialAuthListener extends StatelessWidget {
  const SocialAuthListener({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocListener<SocialAuthBloc, SocialAuthState>(
      listener: (context, state) {
        if (state.state.isError && state.message.isNotEmpty) {
          AppSnack.show(state.message);
        }
      },
      listenWhen: (p, c) => p.state != c.state || p.message != c.message,
      child: BlocListener<SocialAuthBloc, SocialAuthState>(
        // "Send again" from the code screen steps back to phoneRequired while
        // the phone screen is still underneath — that is not a new push.
        listenWhen: (p, c) =>
            p.step != c.step &&
            !(p.step == SocialStep.codeSent &&
                c.step == SocialStep.phoneRequired),
        listener: _onStep,
        child: child,
      ),
    );
  }

  void _onStep(BuildContext context, SocialAuthState state) {
    final bloc = context.read<SocialAuthBloc>();
    switch (state.step) {
      case SocialStep.linkRequired:
        context.push(AppRoutes.SOCIAL_LINK_ROUTE_PATH);
      case SocialStep.phoneRequired:
        context.push(AppRoutes.GOOGLE_LAST_STEP_ROUTE_PATH);
      case SocialStep.codeSent:
        context.push(AppRoutes.SOCIAL_VERIFY_ROUTE_PATH);
      case SocialStep.done:
        context.go(AppRoutes.DASHBOARD_ROUTE_PATH);
        bloc.add(const SocialAuthEvent.reset());
      case SocialStep.restart:
        context.go(AppRoutes.LOGIN_ROUTE_PATH);
        bloc.add(const SocialAuthEvent.reset());
      case SocialStep.idle:
        break;
    }
  }
}
