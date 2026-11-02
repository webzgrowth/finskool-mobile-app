import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/relative_time.dart';
import 'package:finskool/src/comman/widgets/notification_card.dart';
import 'package:finskool/src/data/push/push_route.dart';
import 'package:finskool/src/data/push/push_service.dart';
import 'package:finskool/src/data/socket/notifications_socket.dart';
import 'package:finskool/src/domain/model/notification/app_notification.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';
import 'package:finskool/src/utilities/go_router.dart';

/// Figma's "While using the app": the card **drops in from the top and hides
/// itself after 4 s**. Wraps the whole app, above the navigator, so it floats
/// over any screen.
///
/// Why this instead of an OS banner: while the app is open FCM draws none (and
/// iOS is told not to), and the push guide §9 says the app must show **one**
/// notification, not the socket's and the push's. So the banner is fed by the
/// socket — which also updates the bell — and a push that arrives while the
/// socket is down is shown as a fallback. A socket row and its push never both
/// reach here.
///
/// Tapping routes through [routeForPush], the same function as a tapped OS
/// banner or inbox row.
class InAppBannerHost extends StatefulWidget {
  const InAppBannerHost({super.key, required this.child});

  final Widget child;

  @override
  State<InAppBannerHost> createState() => _InAppBannerHostState();
}

class _InAppBannerHostState extends State<InAppBannerHost> {
  static const _visibleFor = Duration(seconds: 4);

  StreamSubscription<ForegroundPush>? _pushSub;
  Timer? _hide;
  AppNotification? _shown;
  bool _visible = false;

  @override
  void initState() {
    super.initState();
    _pushSub = locator<PushService>().foreground.listen(_onPush);
  }

  @override
  void dispose() {
    _hide?.cancel();
    _pushSub?.cancel();
    super.dispose();
  }

  /// A push while the app is open: the socket normally has it already, so only
  /// show it ourselves if the socket is down — and either way refresh the
  /// count, which is all the socket would have done.
  void _onPush(ForegroundPush push) {
    context.read<NotificationsUnreadBloc>().add(
      const NotificationsUnreadEvent.refresh(),
    );
    if (locator<NotificationsSocket>().isLive) return;
    _show(
      AppNotification(
        id: 'push-${DateTime.now().microsecondsSinceEpoch}',
        type: '',
        title: push.title,
        message: push.body,
        data: push.data,
        isRead: false,
        createdAt: DateTime.now(),
      ),
    );
  }

  void _show(AppNotification n) {
    setState(() {
      _shown = n;
      _visible = true;
    });
    _hide?.cancel();
    _hide = Timer(_visibleFor, _dismiss);
  }

  void _dismiss() {
    _hide?.cancel();
    if (mounted) setState(() => _visible = false);
  }

  void _open(AppNotification n) {
    _dismiss();
    routerinit.push(routeForPush(n.data));
  }

  @override
  Widget build(BuildContext context) {
    final top = MediaQuery.paddingOf(context).top;
    final n = _shown;
    return BlocListener<NotificationsUnreadBloc, NotificationsUnreadState>(
      listenWhen: (p, c) => c.incoming != null && p.incoming != c.incoming,
      listener: (_, state) => _show(state.incoming!),
      child: Stack(
        children: [
          widget.child,
          Positioned(
            top: top + 8,
            left: 12,
            right: 12,
            child: IgnorePointer(
              ignoring: !_visible,
              child: AnimatedSlide(
                offset: _visible ? Offset.zero : const Offset(0, -1.6),
                duration: const Duration(milliseconds: 320),
                curve: Curves.easeOutCubic,
                child: AnimatedOpacity(
                  opacity: _visible ? 1 : 0,
                  duration: const Duration(milliseconds: 220),
                  child: n == null
                      ? const SizedBox.shrink()
                      : GestureDetector(
                          // Swipe up to dismiss, as on the OS banner.
                          onVerticalDragEnd: (d) {
                            if ((d.primaryVelocity ?? 0) < 0) _dismiss();
                          },
                          child: Center(
                            child: ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 480),
                              child: NotificationCard(
                                title: n.title,
                                body: n.message,
                                time: relativeTime(n.createdAt),
                                onTap: () => _open(n),
                              ),
                            ),
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
