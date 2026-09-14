import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/filter/community_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'widgets/community_card.dart';

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
  @override
  void initState() {
    super.initState();
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
        context.push('/community/${community.id}', extra: community.name);
      case CommunityAccess.pricingOnRequest:
        bloc.add(CommunitiesEvent.requestPricing(community.id));
      case CommunityAccess.locked:
        if (plan == null) return;
        context.read<CommunityPurchaseBloc>().add(
              CommunityPurchaseEvent.started(community: community, plan: plan),
            );
        context.read<ComplianceBloc>().add(const ComplianceEvent.initial());
        context.push(AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_PATH);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      body: BlocListener<CommunitiesBloc, CommunitiesState>(
        listenWhen: (p, c) => p.message != c.message && c.message.isNotEmpty,
        listener: (context, state) => ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text(state.message))),
        child: BlocBuilder<CommunityFilterBloc, CommunityFilterState>(
          builder: (context, filterState) {
            return BlocBuilder<CommunitiesBloc, CommunitiesState>(
              builder: (context, state) {
                final communities = _visible(state, filterState.query);
                return CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      floating: true,
                      snap: true,
                      toolbarHeight: 92,
                      automaticallyImplyLeading: false,
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      flexibleSpace: SearchTopBar(
                        hintText: 'Search Communities.........',
                        notificationCount: state.totalNewAnnouncements,
                        onQueryChanged: (v) => context
                            .read<CommunityFilterBloc>()
                            .add(CommunityFilterEvent.queryChanged(v)),
                      ),
                    ),
                    if (state.state.isLoading || state.state.isEmpty)
                      const SliverFillRemaining(
                        child: Center(child: CircularProgressIndicator()),
                      )
                    else if (communities.isEmpty)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: Center(
                          child: Text('No communities match that search.',
                              style: context.communityType.description),
                        ),
                      )
                    else
                      SliverList.builder(
                        itemCount: communities.length,
                        itemBuilder: (context, i) => CommunityCard(
                          community: communities[i],
                          onCta: (plan) => _onCta(communities[i], plan),
                        ),
                      ),
                    const SliverToBoxAdapter(
                        child: SizedBox(height: AppSpacing.lg)),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }

  List<CommunityModel> _visible(CommunitiesState state, String rawQuery) {
    final query = rawQuery.trim().toLowerCase();
    // `pinnedFirst` keeps subscribed communities at the top, per the
    // designer's note on the canvas.
    final all = state.pinnedFirst;
    if (query.isEmpty) return all;
    return all
        .where((c) =>
            c.name.toLowerCase().contains(query) ||
            (c.category?.toLowerCase().contains(query) ?? false) ||
            (c.description?.toLowerCase().contains(query) ?? false) ||
            c.tags.any((t) => t.toLowerCase().contains(query)))
        .toList();
  }
}
