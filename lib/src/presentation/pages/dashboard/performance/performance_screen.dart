import 'package:flutter/material.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'performance_format.dart';
import 'widgets/overall_pl_card.dart';
import 'widgets/performance_header.dart';
import 'widgets/performance_note.dart';
import 'widgets/trade_list.dart';
import 'widgets/trades_summary_card.dart';

/// A community's performance — Final page `1554:6103`. Pushed from the
/// community card's "Performance" button.
///
/// Data is the placeholder in `PerformanceDemoDatasource`, read through the
/// repository: there is no performance endpoint yet.
class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key, this.communityName});

  final String? communityName;

  @override
  Widget build(BuildContext context) {
    final name = communityName ?? 'Intraday Community';
    final report = locator<PerformanceRepository>().reportFor(name);
    final bottom = MediaQuery.paddingOf(context).bottom;

    return Scaffold(
      backgroundColor: AppPalette.feedBase,
      body: Column(
        children: [
          PerformanceHeader(communityName: name),
          Expanded(
            child: Center(
              child: ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 480),
                child: ListView(
                  padding: EdgeInsets.fromLTRB(14, 16, 14, 32 + bottom),
                  children: [
                    OverallPlCard(report: report),
                    const SizedBox(height: 14),
                    TradesSummaryCard(report: report),
                    const SizedBox(height: 14),
                    PerformanceNote(
                      text:
                          'Note: All calculations are done assuming INR '
                          '${formatAmount(report.capitalDeployed)} capital '
                          'deployed and ${report.marginLabel.split(' ').first} '
                          'margin used in each trade.',
                    ),
                    const SizedBox(height: 14),
                    TradeList(report: report),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
