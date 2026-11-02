import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';

/// Tap on Buy / Renew. Only starts the purchase; the screens it leads to are
/// opened by [PurchaseNavigationListener] as the bloc's status moves, so a
/// checkout is never opened before the backend has actually made one.
///
/// Shared by the Communities tab and Profile → Renew, which previously each
/// carried their own copy of the (mocked) kickoff.
void startPurchase(
  BuildContext context,
  CommunityModel community,
  CommunityPlanModel plan,
) {
  context.read<ComplianceBloc>().add(const ComplianceEvent.initial());
  context.read<CommunityPurchaseBloc>().add(
    CommunityPurchaseEvent.started(community: community, plan: plan),
  );
}

/// Turns [CommunityPurchaseBloc]'s status into navigation and snackbars:
///
/// * `checkout`        → open the web checkout.
/// * `failed`          → show the server's message (429, bad plan, network…).
/// * `checking → confirmed` → the member closed the page after paying; take
///   them to the success screen. (When the page itself reports `paid` the
///   webview screen swaps itself for the success screen, so this is only the
///   dismissed-but-paid path.)
///
/// Stateful only to remember the previous status: a `BlocListener`'s callback
/// sees just the new one, and `confirmed` means two different things
/// depending on how it was reached.
class PurchaseNavigationListener extends StatefulWidget {
  const PurchaseNavigationListener({super.key, required this.child});

  final Widget child;

  @override
  State<PurchaseNavigationListener> createState() =>
      _PurchaseNavigationListenerState();
}

class _PurchaseNavigationListenerState
    extends State<PurchaseNavigationListener> {
  PurchaseStatus _previous = PurchaseStatus.idle;

  @override
  Widget build(BuildContext context) {
    return BlocListener<CommunityPurchaseBloc, CommunityPurchaseState>(
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        final before = _previous;
        _previous = state.status;
        switch (state.status) {
          case PurchaseStatus.checkout:
            context.push(AppRoutes.COMMUNITY_CHECKOUT_ROUTE_PATH);
          case PurchaseStatus.failed:
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(SnackBar(content: Text(state.message)));
          case PurchaseStatus.confirmed:
            context.read<CommunitiesBloc>().add(
              const CommunitiesEvent.refresh(),
            );
            if (before == PurchaseStatus.checking) {
              context.push(AppRoutes.COMMUNITY_PAYMENT_SUCCESS_ROUTE_PATH);
            }
          case _:
            break;
        }
      },
      child: widget.child,
    );
  }
}
