import 'package:flutter/widgets.dart';
import 'auth_header.dart';
import 'auth_tab_switch.dart';

/// Picks the right copy for [AuthHeader] given the active tab, keyed so
/// [AnimatedSwitcher] can crossfade between them.
Widget authHeaderForTab(AuthTab tab) {
  return tab == AuthTab.login
      ? const AuthHeader(
          key: ValueKey('login-header'),
          title: 'Welcome Back!',
          subtitle: 'Good to see you again.',
          emphasis: "Let's get started.",
        )
      : const AuthHeader(
          key: ValueKey('signup-header'),
          title: 'Start Your Journey!',
          subtitle: 'Create your account and',
          emphasis: 'get started.',
        );
}
