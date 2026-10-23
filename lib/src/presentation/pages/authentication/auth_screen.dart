import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/login_form/login_form_bloc.dart';
import 'package:finskool/src/presentation/bloc/authentication/sing_up_form/sign_up_form_bloc.dart';

import 'widgets/auth_header_for_tab.dart';
import 'widgets/auth_tab_switch.dart';
import 'widgets/auth_card.dart';
import 'widgets/google_signin_listener.dart';
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

  @override
  void initState() {
    super.initState();
    // Reset both forms on arrival so a previous failed attempt's errors
    // and typed values (these blocs are singletons that outlive the
    // screen) never resurface before the user has touched anything.
    _resetTab(_tab);
  }

  void _resetTab(AuthTab tab) {
    if (tab == AuthTab.login) {
      context.read<LoginFormBloc>().add(const LoginFormEvent.initial());
    } else {
      context.read<SignUpFormBloc>().add(const SignUpFormEvent.initial());
    }
  }

  // Deliberately **not** `context.go`/`context.replace`: `/login` and
  // `/signup` each build a fresh `AuthScreen` through `fadeThroughPage`
  // (420ms), so routing here stacked that whole-screen transition on top of
  // the in-place crossfade below — the double animation read as a flash, and
  // a tap during the route's own transition could land on a widget already
  // mid-dispose, which is why it sometimes took two taps. `AuthTabScope`'s
  // own doc comment already says the point of this path is to switch
  // "instead of navigating"; this was the one place still doing both.
  void _select(AuthTab tab) {
    if (tab == _tab) return;
    setState(() => _tab = tab);
    _resetTab(tab);
  }

  @override
  Widget build(BuildContext context) {
    final isLogin = _tab == AuthTab.login;
    return GoogleSigninListener(
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
                        transitionBuilder: (child, animation) => FadeTransition(
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
