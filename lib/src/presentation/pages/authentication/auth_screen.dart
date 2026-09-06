import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/authentication/google_signin/google_signin_bloc.dart';
import 'widgets/auth_header_for_tab.dart';
import 'widgets/auth_tab_switch.dart';
import 'widgets/auth_card.dart';
import 'login/login_form.dart';
import 'signup/signup_form.dart';
import 'auth_tab_scope.dart';

/// Hosts both the Login and Sign up forms behind one segmented tab, so
/// switching between them is an in-place crossfade rather than a page
/// navigation (which was replaying the entrance animation and feeling
/// janky). `/login` and `/signup` both route here, only differing in
/// which tab starts selected.
class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key, required this.initialTab});

  final AuthTab initialTab;

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  late AuthTab _tab = widget.initialTab;

  void _select(AuthTab tab) {
    if (tab == _tab) return;
    setState(() => _tab = tab);
    context.replace(
      tab == AuthTab.login
          ? AppRoutes.LOGIN_ROUTE_PATH
          : AppRoutes.SIGNUP_ROUTE_PATH,
    );
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _tab == AuthTab.login;
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
      child: AuthTabScope(
        onSwitchTab: _select,
        child: Scaffold(
          body: SingleChildScrollView(
            // Cap the content width so this stays comfortable on tablets
            // and wide Android devices instead of stretching edge-to-edge.
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: Column(
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 260),
                      child: authHeaderForTab(_tab),
                    ),
                    AuthCard(
                      tabs: AuthTabSwitch(selected: _tab, onChanged: _select),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 260),
                        switchInCurve: Curves.easeOut,
                        switchOutCurve: Curves.easeIn,
                        transitionBuilder: (child, animation) =>
                            FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween(
                              begin: const Offset(0, 0.03),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                        child: isLogin
                            ? const LoginForm(key: ValueKey('login-form'))
                            : const SignUpForm(key: ValueKey('signup-form')),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
