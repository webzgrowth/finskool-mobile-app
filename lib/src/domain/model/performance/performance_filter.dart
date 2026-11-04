/// The months a member narrowed a board to: `YYYY-MM` at both ends, inclusive
/// (a single month is `from == to`). Narrows the summary, the trades and
/// `hiddenCount` together, so the cards and the list never disagree.
class PerformanceMonthFilter {
  const PerformanceMonthFilter({required this.from, required this.to});

  const PerformanceMonthFilter.single(String month) : from = month, to = month;

  final String from;
  final String to;

  bool get isSingleMonth => from == to;

  /// `YYYY-MM` sorts as text, so this is a plain comparison.
  bool get isValid => from.compareTo(to) <= 0;

  /// What the server echoes back as `filter`, or null for "all months".
  static PerformanceMonthFilter? fromJson(Object? json) {
    if (json is! Map<String, dynamic>) return null;
    final from = json['fromMonth'] as String?;
    final to = json['toMonth'] as String?;
    if (from == null || to == null) return null;
    return PerformanceMonthFilter(from: from, to: to);
  }

  @override
  bool operator ==(Object other) =>
      other is PerformanceMonthFilter && other.from == from && other.to == to;

  @override
  int get hashCode => Object.hash(from, to);
}
