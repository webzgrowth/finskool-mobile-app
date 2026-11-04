import 'performance_kind.dart';

/// One row of `GET /mobile/performance/boards`: a community that has a
/// Performance screen. Listed whether or not the member is subscribed — a free
/// member opens the preview.
class PerformanceBoardEntry {
  const PerformanceBoardEntry({
    required this.communityId,
    required this.name,
    required this.slug,
    required this.kind,
    required this.segments,
    required this.isPaid,
  });

  final String communityId;
  final String name;
  final String slug;
  final PerformanceKind kind;
  final List<PerformanceSegment> segments;

  /// The server's `access: "paid"`, worked out live on every call. Never
  /// decide this from the app's own subscription list.
  final bool isPaid;

  /// Null for a kind this build doesn't know, so that board is skipped.
  static PerformanceBoardEntry? fromJson(Map<String, dynamic> json) {
    final kind = PerformanceKindX.fromName(json['kind'] as String?);
    final id = json['communityId'] as String?;
    if (kind == null || id == null) return null;
    return PerformanceBoardEntry(
      communityId: id,
      name: json['name'] as String? ?? '',
      slug: json['slug'] as String? ?? '',
      kind: kind,
      segments: [
        for (final s in (json['segments'] as List?) ?? const [])
          if (PerformanceSegmentX.fromWire(s as String?) != null)
            PerformanceSegmentX.fromWire(s)!,
      ],
      isPaid: json['access'] == 'paid',
    );
  }
}
