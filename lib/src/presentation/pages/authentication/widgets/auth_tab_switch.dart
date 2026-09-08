import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'auth_tab_segment.dart';

enum AuthTab { login, signUp }

/// Animated segmented control switching between the Login and Sign up
/// screens. The sliding indicator follows [selected] via [AnimatedAlign].
class AuthTabSwitch extends StatelessWidget {
  const AuthTabSwitch({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  final AuthTab selected;
  final ValueChanged<AuthTab> onChanged;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      height: 36,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: const Color(0xFFEBEBEB),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: cs.outlineVariant),
      ),
      child: Stack(
        children: [
          AnimatedAlign(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOutCubic,
            alignment: selected == AuthTab.login
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: FractionallySizedBox(
              widthFactor: 0.5,
              child: Container(
                decoration: BoxDecoration(
                  color: cs.surface,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                  boxShadow: [
                    BoxShadow(
                      color: cs.shadow.withValues(alpha: 0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Row(
            children: [
              AuthTabSegment(
                label: 'Log In',
                active: selected == AuthTab.login,
                style: tt.titleSmall,
                onTap: () => onChanged(AuthTab.login),
              ),
              AuthTabSegment(
                label: 'Sign Up',
                active: selected == AuthTab.signUp,
                style: tt.titleSmall,
                onTap: () => onChanged(AuthTab.signUp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
