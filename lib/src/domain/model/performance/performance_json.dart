/// Small readers shared by the performance models. The API sends plain
/// numbers (never strings) and calendar dates with no time of day.
double? asDouble(Object? value) => value is num ? value.toDouble() : null;

int asInt(Object? value) => value is num ? value.toInt() : 0;

/// `YYYY-MM-DD` as a **calendar date**: built from its parts with no zone, so
/// it can't slip a day when shown in another zone (same rule as KYC's DOB).
DateTime? asDate(Object? value) {
  if (value is! String || value.length < 10) return null;
  final y = int.tryParse(value.substring(0, 4));
  final m = int.tryParse(value.substring(5, 7));
  final d = int.tryParse(value.substring(8, 10));
  if (y == null || m == null || d == null) return null;
  return DateTime(y, m, d);
}
