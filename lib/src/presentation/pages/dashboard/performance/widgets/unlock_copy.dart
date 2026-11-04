import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';

/// The words on a free member's unlock card (Figma `Performance – Intraday
/// (Free)` and `– Swing Alpha (Free)`). Intraday sells *more trades*; swing and
/// investor sell following *live* ones. The app only knows [hidden]; the
/// admin's preview rules stay on the server.
class UnlockCopy {
  const UnlockCopy({
    required this.title,
    required this.body,
    required this.perks,
    required this.listSubtitle,
  });

  final String title;
  final String body;
  final List<String> perks;

  /// The line under the trade list's title, in place of the paid count pill.
  final String listSubtitle;

  factory UnlockCopy.of(PerformanceBoard board, {required int shown}) {
    final hidden = board.hiddenCount ?? 0;
    final name = board.communityName.endsWith('Community')
        ? board.communityName
        : '${board.communityName} Community';
    if (board.kind == PerformanceKind.intraday) {
      final total = shown + hidden;
      return UnlockCopy(
        title: hidden == 1
            ? 'Unlock 1 more trade'
            : 'Unlock $hidden more trades',
        body: 'Join $name to see every trade, not just the highlights.',
        perks: [
          'All $total trades with entry and exit',
          'P&L, charges and net P&L',
          'Month-wise trade history',
        ],
        listSubtitle: 'Showing $shown of $total trades',
      );
    }
    return UnlockCopy(
      title: 'Unlock live trades',
      body: 'Join $name to follow open trades as they run.',
      perks: const [
        'Open trades with entry and target',
        'Analysis on every trade',
        'Exit dates and holding days',
      ],
      listSubtitle: 'Past trades',
    );
  }
}
