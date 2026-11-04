import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/presentation/bloc/performance/board/performance_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'performance_body.dart';
import 'widgets/performance_header.dart';

/// A community's performance — Final page `1554:6103` for the intraday board;
/// swing and investor boards are built from the same blocks (not in Figma).
/// Pushed from the community card's "Performance" button.
///
/// Data is `GET /mobile/performance/communities/:id` through
/// [PerformanceBloc], which is route-scoped: this screen owns it.
class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({
    super.key,
    required this.communityId,
    this.communityName,
  });

  final String communityId;
  final String? communityName;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          locator<PerformanceBloc>()
            ..add(PerformanceEvent.load(communityId: communityId)),
      child: PerformanceView(
        communityId: communityId,
        communityName: communityName,
      ),
    );
  }
}

/// The screen minus its bloc, public so a test can supply a ready one.
class PerformanceView extends StatefulWidget {
  const PerformanceView({
    super.key,
    required this.communityId,
    this.communityName,
  });

  final String communityId;
  final String? communityName;

  @override
  State<PerformanceView> createState() => _PerformanceViewState();
}

class _PerformanceViewState extends State<PerformanceView> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  /// Infinite scroll. Both guards are load-bearing, as in the feed: return when
  /// there is nothing to scroll, and clamp the trigger distance to half the
  /// list — a flat `maxScrollExtent - 600` goes negative on a short list and
  /// would fire on every notification. The bloc repeats its own guards.
  void _onScroll() {
    final position = _scroll.position;
    final max = position.maxScrollExtent;
    if (max <= 0) return;
    final trigger = max < 1200 ? max / 2 : 600.0;
    if (position.pixels >= max - trigger) {
      context.read<PerformanceBloc>().add(const PerformanceEvent.loadMore());
    }
  }

  @override
  Widget build(BuildContext context) {
    final bottom = MediaQuery.paddingOf(context).bottom;
    return BlocListener<PerformanceBloc, PerformanceState>(
      listenWhen: (p, c) => p.message != c.message && c.message.isNotEmpty,
      listener: (context, state) => AppSnack.show(state.message),
      child: Scaffold(
        backgroundColor: AppPalette.feedBase,
        body: Column(
          children: [
            BlocBuilder<PerformanceBloc, PerformanceState>(
              buildWhen: (p, c) =>
                  p.board?.communityName != c.board?.communityName,
              builder: (context, state) => PerformanceHeader(
                communityName:
                    state.board?.communityName ??
                    widget.communityName ??
                    'Performance',
              ),
            ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 480),
                  child: PerformanceBody(
                    communityId: widget.communityId,
                    controller: _scroll,
                    bottomInset: bottom,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
