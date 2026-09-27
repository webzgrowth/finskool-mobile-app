import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Verified with SEBI" — the read-only DOB + PAN pair, same cell shape as
/// the Subscription Detail grid.
///
/// **Both values are nullable because the app cannot currently read them
/// back.** `submitCompliance` persists only `StorageKeys.complianceCompleted`
/// and discards its `ComplianceDetailsModel` — storing the PAN is a
/// deliberate decision recorded in CLAUDE.md, and nothing writes the date
/// of birth either. So these render [_missing] until either a backend
/// compliance endpoint exists or a decision is taken to persist them
/// locally; the widget takes them as parameters so that's a one-line
/// change at the call site rather than a rewrite here.
class SebiDetailsSection extends StatelessWidget {
  const SebiDetailsSection({super.key, this.dateOfBirth, this.pan});

  final String? dateOfBirth;
  final String? pan;

  static const String _missing = '—';

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
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
                    icon: Icons.calendar_today_outlined,
                    label: 'Date of birth',
                    value: dateOfBirth ?? _missing,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: DetailCell(
                    icon: Icons.credit_card_outlined,
                    label: 'PAN number',
                    value: pan ?? _missing,
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(
          "These can't be edited here. Contact support to update them.",
          style: type.value,
        ),
      ],
    );
  }
}
