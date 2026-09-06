import 'package:flutter/widgets.dart';
import 'auth_header.dart';
import 'auth_header_subtitle.dart';
import 'auth_tab_switch.dart';

/// Picks the right copy for [AuthHeader] given the active tab, keyed so
/// [AnimatedSwitcher] can crossfade between them.
Widget authHeaderForTab(AuthTab tab) {
  return tab == AuthTab.login
      ? AuthHeader(
          key: const ValueKey('login-header'),
          title: 'Welcome Back!',
          subtitleSpans: [
            authSpan('Good to see you again. '),
            authSpan("Let's get started.", bold: true),
          ],
        )
      : AuthHeader(
          key: const ValueKey('signup-header'),
          title: 'Start Your Journey!',
          subtitleSpans: [
            authSpan('Create your account and '),
            authSpan('get started.', bold: true),
          ],
        );
}
