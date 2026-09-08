import 'package:flutter/widgets.dart';
import 'widgets/auth_tab_switch.dart';

/// Lets a form deep in the tree (e.g. the "Sign up" footer link) trigger
/// the same in-place tab switch as [AuthTabSwitch], instead of navigating.
class AuthTabScope extends InheritedWidget {
  const AuthTabScope({
    super.key,
    required this.onSwitchTab,
    required super.child,
  });

  final ValueChanged<AuthTab> onSwitchTab;

  static AuthTabScope of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AuthTabScope>();
    assert(scope != null, 'AuthTabScope not found in context');
    return scope!;
  }

  @override
  bool updateShouldNotify(AuthTabScope oldWidget) =>
      onSwitchTab != oldWidget.onSwitchTab;
}
