import 'dart:async';

import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Expires in 4d 3h" → "Expires in 2h 10m" → "Expires in 12:05" for the last
/// hour, ticking each second only when the seconds are shown.
///
/// The payment guide asks for a countdown on a payable quote. The *status* is
/// still the server's (`expired` arrives over the socket) — this only tells the
/// member how long they have, and never decides payability itself.
class QuoteCountdown extends StatefulWidget {
  const QuoteCountdown({super.key, required this.expiresAt});

  final DateTime expiresAt;

  /// Static so the format is testable without a clock.
  static String label(Duration left) {
    if (left <= Duration.zero) return 'Expiring now';
    if (left.inDays >= 1) {
      return 'Expires in ${left.inDays}d ${left.inHours % 24}h';
    }
    if (left.inHours >= 1) {
      return 'Expires in ${left.inHours}h ${left.inMinutes % 60}m';
    }
    final m = left.inMinutes.toString().padLeft(2, '0');
    final s = (left.inSeconds % 60).toString().padLeft(2, '0');
    return 'Expires in $m:$s';
  }

  @override
  State<QuoteCountdown> createState() => _QuoteCountdownState();
}

class _QuoteCountdownState extends State<QuoteCountdown> {
  Timer? _timer;

  Duration get _left => widget.expiresAt.difference(DateTime.now());

  @override
  void initState() {
    super.initState();
    _schedule();
  }

  void _schedule() {
    _timer?.cancel();
    // Seconds only matter in the last hour; before that, once a minute.
    final period = _left < const Duration(hours: 1)
        ? const Duration(seconds: 1)
        : const Duration(minutes: 1);
    _timer = Timer.periodic(period, (_) {
      if (!mounted) return;
      setState(() {});
      if (_left < const Duration(hours: 1) && period.inSeconds > 1) _schedule();
    });
  }

  @override
  void didUpdateWidget(QuoteCountdown old) {
    super.didUpdateWidget(old);
    if (old.expiresAt != widget.expiresAt) _schedule();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      QuoteCountdown.label(_left),
      style: context.ticketType.bubbleCaption,
    );
  }
}
