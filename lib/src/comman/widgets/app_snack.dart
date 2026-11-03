import 'dart:async';

import 'package:flutter/foundation.dart' show visibleForTesting;
import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/go_router.dart';

/// The app's snackbar — **at the top**, under the status bar.
///
/// Flutter's `SnackBar` is bottom-only, and at the bottom it sat over the
/// reply bars, the CTAs and the bottom navigation. This draws the same message
/// in the root navigator's overlay instead, so it floats above every screen,
/// sheet and dialog, and **needs no `BuildContext`** — a bloc listener, an
/// async gap or a plugin callback can all call it.
///
/// One at a time: a new one replaces the current. Swipe up to dismiss.
class AppSnack {
  AppSnack._();

  static OverlayEntry? _entry;
  static Timer? _timer;

  /// Where the snack is drawn. The app's root navigator; a test points it at
  /// its own so it needn't boot the whole router.
  @visibleForTesting
  static OverlayState? Function() overlayProvider = () =>
      routerinit.routerDelegate.navigatorKey.currentState?.overlay;

  static void show(
    String message, {
    String? actionLabel,
    VoidCallback? onAction,
    Duration? duration,
  }) {
    if (message.trim().isEmpty) return;
    final overlay = overlayProvider();
    if (overlay == null) return;
    dismiss();
    late final OverlayEntry entry;
    entry = OverlayEntry(
      builder: (_) => _TopSnack(
        message: message,
        actionLabel: actionLabel,
        onAction: onAction,
        onDismiss: () => _remove(entry),
      ),
    );
    _entry = entry;
    overlay.insert(entry);
    // Longer with an action, so there is time to reach it.
    _timer = Timer(
      duration ?? Duration(seconds: actionLabel == null ? 3 : 6),
      dismiss,
    );
  }

  static void dismiss() {
    _timer?.cancel();
    _timer = null;
    final e = _entry;
    _entry = null;
    e?.remove();
  }

  static void _remove(OverlayEntry entry) {
    if (_entry == entry) dismiss();
  }
}

class _TopSnack extends StatefulWidget {
  const _TopSnack({
    required this.message,
    required this.onDismiss,
    this.actionLabel,
    this.onAction,
  });

  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;
  final VoidCallback onDismiss;

  @override
  State<_TopSnack> createState() => _TopSnackState();
}

class _TopSnackState extends State<_TopSnack>
    with SingleTickerProviderStateMixin {
  late final AnimationController _in = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 260),
  )..forward();

  @override
  void dispose() {
    _in.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).snackBarTheme;
    final cs = Theme.of(context).colorScheme;
    return Positioned(
      top: MediaQuery.paddingOf(context).top + 8,
      left: 16,
      right: 16,
      child: SlideTransition(
        position: Tween(
          begin: const Offset(0, -1.4),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: _in, curve: Curves.easeOutCubic)),
        child: GestureDetector(
          onVerticalDragEnd: (d) {
            if ((d.primaryVelocity ?? 0) < 0) widget.onDismiss();
          },
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Material(
                color: theme.backgroundColor ?? cs.inverseSurface,
                elevation: 6,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 12, 8, 12),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          widget.message,
                          style:
                              theme.contentTextStyle ??
                              TextStyle(color: cs.onInverseSurface),
                        ),
                      ),
                      if (widget.actionLabel != null)
                        TextButton(
                          onPressed: () {
                            widget.onAction?.call();
                            widget.onDismiss();
                          },
                          child: Text(
                            widget.actionLabel!,
                            style: TextStyle(
                              color: theme.actionTextColor ?? cs.inversePrimary,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
