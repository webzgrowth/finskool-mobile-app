import 'performance_filter.dart';
import 'performance_json.dart';
import 'performance_kind.dart';
import 'performance_summary.dart';
import 'performance_trade.dart';

/// One page of `GET /mobile/performance/communities/:id`: the summary, a banner
/// and a slice of the trade list.
class PerformanceBoard {
  const PerformanceBoard({
    required this.communityId,
    required this.communityName,
    required this.kind,
    required this.isPaid,
    required this.segment,
    required this.segments,
    required this.filter,
    required this.months,
    required this.summary,
    required this.noteText,
    required this.hiddenCount,
    required this.items,
    required this.nextCursor,
  });

  final String communityId;
  final String communityName;
  final PerformanceKind kind;

  /// `access: "paid"`. A free member is not an error — they see a preview.
  final bool isPaid;
  final PerformanceSegment segment;
  final List<PerformanceSegment> segments;

  /// The months this page was narrowed to, echoed back; null for all months.
  final PerformanceMonthFilter? filter;

  /// Every month with at least one trade on the segment, newest first —
  /// **whatever the filter and the member's access**. The month pickers are
  /// built from this (a month with no trades is never offered), and it changes
  /// with the investor tab.
  final List<String> months;

  /// For the picked months, or every trade when [filter] is null — the same for
  /// a free and a paid member.
  final PerformanceSummary summary;

  /// The banner under an intraday title; null on the other kinds.
  final String? noteText;

  /// Trades this member cannot see, **in the picked months** (or on the whole
  /// segment with no filter). Null for a paid member.
  final int? hiddenCount;
  final List<PerformanceTrade> items;

  /// Null on the last page.
  final String? nextCursor;

  factory PerformanceBoard.fromJson(Map<String, dynamic> json) {
    final kind =
        PerformanceKindX.fromName(json['kind'] as String?) ??
        PerformanceKind.intraday;
    return PerformanceBoard(
      communityId: json['communityId'] as String? ?? '',
      communityName: json['communityName'] as String? ?? '',
      kind: kind,
      isPaid: json['access'] == 'paid',
      segment:
          PerformanceSegmentX.fromWire(json['segment'] as String?) ??
          PerformanceSegment.main,
      segments: [
        for (final s in (json['segments'] as List?) ?? const [])
          if (PerformanceSegmentX.fromWire(s as String?) != null)
            PerformanceSegmentX.fromWire(s)!,
      ],
      filter: PerformanceMonthFilter.fromJson(json['filter']),
      months: [
        for (final m in (json['months'] as List?) ?? const [])
          if (m is String) m,
      ],
      summary: PerformanceSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      noteText: (json['noteText'] as String?)?.trim().isEmpty ?? true
          ? null
          : json['noteText'] as String,
      hiddenCount: json['hiddenCount'] is num
          ? asInt(json['hiddenCount'])
          : null,
      items: [
        for (final row in (json['items'] as List?) ?? const [])
          if (row is Map<String, dynamic>)
            ?PerformanceTrade.fromJson(row, kind),
      ],
      nextCursor: json['nextCursor'] as String?,
    );
  }
}
