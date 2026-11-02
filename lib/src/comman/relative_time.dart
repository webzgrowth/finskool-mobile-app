import 'ist_time.dart';

/// Figma's push timestamps: `now`, `5m ago`, `1h ago`, `Yesterday`, then a
/// date. Anything under 24 hours reads as hours — an event 1h ago stays "1h
/// ago" even across midnight — and "Yesterday" is the previous **calendar day
/// in IST** (the only clock the app shows) once it is a day or more old.
///
/// [now] is injectable so a test needn't depend on the clock.
String relativeTime(DateTime instant, {DateTime? now}) {
  final at = now ?? DateTime.now();
  final diff = at.difference(instant);
  if (diff.inSeconds < 60) return 'now';
  if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
  if (diff.inHours < 24) return '${diff.inHours}h ago';
  const day = 'yyyyMMdd';
  if (formatIst(instant, day) ==
      formatIst(at.subtract(const Duration(days: 1)), day)) {
    return 'Yesterday';
  }
  return formatIst(instant, 'd MMM');
}
