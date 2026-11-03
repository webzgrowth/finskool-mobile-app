import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/presentation/bloc/communities/compliance/compliance_bloc.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/pages/dashboard/widgets/kyc_reminder.dart';
import 'package:finskool/src/presentation/bloc/kyc/status/kyc_bloc.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Verified with SEBI" — the read-only DOB + PAN pair, same cell shape as
/// the Subscription Detail grid.
///
/// Both values come from the server (`GET /auth/mobile/me/kyc`) via `KycBloc`
/// — the date of birth and a **masked** PAN (`XXXXXX234F`); the full PAN is
/// never sent to the app. Until the member has submitted them (their first
/// paid community) or while the answer is loading, each reads [_missing].
class SebiDetailsSection extends StatelessWidget {
  const SebiDetailsSection({super.key});

  static const String _missing = '—';

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    final kycState = context.watch<KycBloc>().state;
    final kyc = kycState.status;
    final dob = kyc?.dateOfBirth;
    final dateOfBirth = dob == null
        ? null
        : DateFormat('d MMM yyyy').format(dob);
    final pan = kyc?.panMasked;
    final owed = KycReminder.owed(
      kycState,
      context.watch<CommunitiesBloc>().state,
    );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TealSectionCard(
          title: 'Verified with SEBI',
          child: IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DetailCell(
                    glyph: 'assets/icons/sub_calendar_check.svg',
                    label: 'Date of birth',
                    value: dateOfBirth ?? _missing,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: DetailCell(
                    glyph: 'assets/icons/sub_card.svg',
                    label: 'PAN number',
                    value: pan ?? _missing,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        if (owed) ...[
          // Paid, but the server has no DOB + PAN yet.
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                context.read<ComplianceBloc>().add(
                  const ComplianceEvent.initial(),
                );
                context.push(AppRoutes.COMMUNITY_COMPLIANCE_ROUTE_PATH);
              },
              child: const Text('Please complete KYC'),
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
        Text(
          "These can't be edited here. Contact support to update them.",
          style: type.value,
        ),
      ],
    );
  }
}
