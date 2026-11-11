import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/widgets/app_snack.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/presentation/bloc/communities/filter/community_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/performance/boards/performance_boards_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/notifications/unread/notifications_unread_bloc.dart';

import 'package:finskool/src/comman/widgets/skeleton.dart';

import 'checkout/purchase_flow.dart';
import 'widgets/community_card.dart';
import 'widgets/community_card_skeleton.dart';

/// The Communities tab: a searchable catalog of communities, subscribed
/// ones pinned to the top.
///
/// Same scroll skeleton as `FeedScreen` — a floating/snap `SliverAppBar`
/// over a `SliverList` — and the same widget-layer composition of two
/// blocs (the catalog and the search text).
class CommunitiesScreen extends StatefulWidget {
  const CommunitiesScreen({super.key});

  @override
  State<CommunitiesScreen> createState() => _CommunitiesScreenState();
}

class _CommunitiesScreenState extends State<CommunitiesScreen> {
  final _scroll = ScrollController();

  /// Where the member had scrolled to, kept **outside this State**: whatever
  /// rebuilds or remounts the tab (a reload that swaps the list for its
  /// skeleton and back, the shell being rebuilt on the way back from
  /// Performance) can no longer send the list to the top. Cleared on sign-out.
  static double _remembered = 0;

  /// The list was replaced by a skeleton (or this State is new), so the next
  /// time it is shown the remembered offset is put back.
  bool _needsRestore = true;

  @override
  void dispose() {
    _scroll.dispose();
    super.dispose();
  }

  void _remember() {
    // Only while the real list is on screen: a skeleton is short, and the
    // scroll view clamps its offset to 0 — recording that would forget it.
    if (!_needsRestore && _scroll.hasClients) _remembered = _scroll.offset;
  }

  /// Called from build with whether the list (not a skeleton) is showing.
  void _syncScroll({required bool listShown, required bool signedOut}) {
    if (signedOut) _remembered = 0;
    if (!listShown) {
      _needsRestore = true;
      return;
    }
    if (!_needsRestore) return;
    _needsRestore = false;
    if (_remembered <= 0) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || !_scroll.hasClients) return;
      final max = _scroll.position.maxScrollExtent;
      _scroll.jumpTo(_remembered.clamp(0, max));
    });
  }

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_remember);
    context.read<CommunitiesBloc>().add(
      const CommunitiesEvent.loadCommunities(),
    );
  }

  /// Subscribed → open it. Priced → start a purchase. No public price →
  /// send the enquiry to an admin.
  void _onCta(CommunityModel community, CommunityPlanModel? plan) {
    final bloc = context.read<CommunitiesBloc>();
    switch (community.access) {
      case CommunityAccess.subscribed:
        context.push('/community/${community.id}', extra: community);
      case CommunityAccess.pricingOnRequest:
        bloc.add(CommunitiesEvent.requestPricing(community.id));
      case CommunityAccess.locked:
        if (plan == null) return;
        startPurchase(context, community, plan);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      body: PurchaseNavigationListener(
        child: BlocListener<CommunitiesBloc, CommunitiesState>(
          listenWhen: (p, c) => p.message != c.message && c.message.isNotEmpty,
          listener: (context, state) => AppSnack.show(state.message),
          child: BlocBuilder<CommunityFilterBloc, CommunityFilterState>(
            builder: (context, filterState) {
              return BlocBuilder<CommunitiesBloc, CommunitiesState>(
                builder: (context, state) {
                  final communities = _visible(state, filterState.query);
                  final boards = context.watch<PerformanceBoardsBloc>().state;
                  _syncScroll(
                    listShown:
                        !(state.state.isLoading || state.state.isEmpty) &&
                        communities.isNotEmpty,
                    signedOut: state.state.isEmpty,
                  );
                  return CustomScrollView(
                    controller: _scroll,
                    slivers: [
                      SliverAppBar(
                        floating: true,
                        snap: true,
                        toolbarHeight: SearchTopBar.heightFor(context),
                        automaticallyImplyLeading: false,
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        flexibleSpace: SearchTopBar(
                          hintText: 'Search Communities.........',
                          notificationCount: context
                              .watch<NotificationsUnreadBloc>()
                              .state
                              .count,
                          onNotificationsTap: () =>
                              context.push(AppRoutes.NOTIFICATIONS_ROUTE_PATH),
                          onQueryChanged: (v) => context
                              .read<CommunityFilterBloc>()
                              .add(CommunityFilterEvent.queryChanged(v)),
                        ),
                      ),
                      // Figma: the first card sits 20 under the bar.
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                      if (state.state.isLoading || state.state.isEmpty)
                        const SliverToBoxAdapter(
                          child: Shimmer(
                            child: Column(
                              children: [
                                CommunityCardSkeleton(),
                                CommunityCardSkeleton(),
                              ],
                            ),
                          ),
                        )
                      else if (communities.isEmpty)
                        SliverFillRemaining(
                          hasScrollBody: false,
                          child: Center(
                            child: Text(
                              'No communities match that search.',
                              style: context.communityType.description,
                            ),
                          ),
                        )
                      else
                        SliverList.builder(
                          itemCount: communities.length,
                          itemBuilder: (context, i) => CommunityCard(
                            community: communities[i],
                            onCta: (plan) => _onCta(communities[i], plan),
                            // Only a community the server says has a board —
                            // subscribed or not: a free member opens the preview.
                            onPerformance: boards.hasBoard(communities[i].id)
                                ? () => context.push(
                                    '/community/${communities[i].id}/performance',
                                    extra: communities[i].name,
                                  )
                                : null,
                          ),
                        ),
                      const SliverToBoxAdapter(child: SizedBox(height: 20)),
                    ],
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  List<CommunityModel> _visible(CommunitiesState state, String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    // `pinnedFirst` keeps subscribed communities at the top, per the
    // designer's note on the canvas.
    // Communities that only offer "request pricing" are handled in the
    // Services tab, so they don't appear here.
    final all = state.pinnedFirst
        .where((c) => c.access != CommunityAccess.pricingOnRequest)
        .toList();
    if (query.isEmpty) return all;
    return all
        .where(
          (c) =>
              c.name.toLowerCase().contains(query) ||
              (c.category?.toLowerCase().contains(query) ?? false) ||
              (c.description?.toLowerCase().contains(query) ?? false) ||
              c.tags.any((t) => t.toLowerCase().contains(query)),
        )
        .toList();
  }
}
