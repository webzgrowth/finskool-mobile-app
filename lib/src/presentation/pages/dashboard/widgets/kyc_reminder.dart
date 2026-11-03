import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/purchase/community_purchase_bloc.dart';
import 'package:finskool/src/presentation/bloc/kyc/status/kyc_bloc.dart';

import 'kyc_reminder_dialog.dart';

/// Asks a member who **paid for a community but has not given their KYC** to
/// complete it. The server's answer (`GET /auth/mobile/me/kyc`) and the
/// member's communities arrive separately, in either order, so it listens to
/// both and shows the prompt as soon as both say so.
///
/// Once per visit to the dashboard ("Later" is respected until the next
/// launch/login), and never on top of something else:
/// * not while a purchase is in flight — the success screen asks for the same
///   details itself, at the right moment;
/// * not while another screen is covering the dashboard.
class KycReminder extends StatefulWidget {
  const KycReminder({super.key, required this.child});

  final Widget child;

  /// True when the member owes KYC: the server has answered "not completed"
  /// and they hold a paid membership.
  static bool owed(KycState kyc, CommunitiesState communities) =>
      kyc.status != null &&
      !kyc.status!.completed &&
      communities.communities.any((c) => c.isPaidMembership);

  @override
  State<KycReminder> createState() => _KycReminderState();
}

class _KycReminderState extends State<KycReminder> {
  bool _asked = false;

  void _maybeAsk() {
    if (_asked || !mounted) return;
    final owed = KycReminder.owed(
      context.read<KycBloc>().state,
      context.read<CommunitiesBloc>().state,
    );
    if (!owed) return;
    if (context.read<CommunityPurchaseBloc>().state.status !=
        PurchaseStatus.idle) {
      return;
    }
    if (ModalRoute.of(context)?.isCurrent != true) return;
    _asked = true;
    showKycReminderDialog(context).then((go) {
      if (!go || !mounted) return;
      context.read<ComplianceBloc>().add(const ComplianceEvent.initial());
      context.push(AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<KycBloc, KycState>(listener: (_, _) => _maybeAsk()),
        BlocListener<CommunitiesBloc, CommunitiesState>(
          listener: (_, _) => _maybeAsk(),
        ),
      ],
      child: widget.child,
    );
  }
}
