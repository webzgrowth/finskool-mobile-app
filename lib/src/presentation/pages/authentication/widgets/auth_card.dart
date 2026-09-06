import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The white rounded sheet holding the tab switch and form, with an
/// entrance fade + slide-up animation to satisfy the "good animation" ask.
class AuthCard extends StatefulWidget {
  const AuthCard({super.key, this.tabs, required this.child});

  /// The Login/Sign up segmented control. Screens without a tab switch
  /// (e.g. the password-reset flow) omit it.
  final Widget? tabs;
  final Widget child;

  @override
  State<AuthCard> createState() => _AuthCardState();
}

class _AuthCardState extends State<AuthCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 420),
  )..forward();
  late final Animation<double> _fade =
      CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  late final Animation<Offset> _slide = Tween(
    begin: const Offset(0, 0.06),
    end: Offset.zero,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    // Keep content clear of the home indicator / gesture bar on devices
    // that have one (differs between iOS and Android, and by device).
    final bottomInset = MediaQuery.paddingOf(context).bottom;
    return FadeTransition(
      opacity: _fade,
      child: SlideTransition(
        position: _slide,
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xxl + bottomInset,
          ),
          decoration: BoxDecoration(
            color: cs.surface,
            borderRadius: const BorderRadius.vertical(
              top: Radius.circular(AppRadii.lg),
            ),
          ),
          transform: Matrix4.translationValues(0, -20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (widget.tabs != null) ...[
                widget.tabs!,
                const SizedBox(height: AppSpacing.xl),
              ],
              widget.child,
            ],
          ),
        ),
      ),
    );
  }
}
