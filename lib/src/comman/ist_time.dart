/// India Standard Time, which is the only clock this app shows.
///
/// The API sends instants in **UTC** (`"2026-10-04T08:27:11.567Z"`), and
/// `DateTime.parse` keeps them that way. `DateFormat` then reads the
/// `DateTime`'s own fields, so formatting a parsed timestamp directly prints
/// **UTC** — a post published at 1:57 PM IST showed as "8:27 AM". Every
/// display of a server instant has to be converted first.
///
/// IST, not `toLocal()`: this is an Indian markets product, its sessions and
/// the backend's own `date` filter are `Asia/Kolkata`, and a post's time
/// means the market's time. A user abroad therefore sees IST rather than
/// their own clock — that is the intent, not an oversight.
///
/// A fixed offset is safe: India has observed no DST since 1945, so UTC+5:30
/// is constant and needs no timezone database.
///
/// **This file deliberately exposes no `DateTime`-to-`DateTime` converter.**
/// Such a function is not idempotent — the shifted value looks like any
/// other `DateTime`, so converting twice silently lands 5½ hours out, and
/// nothing in the type system catches it. Callers format or compare instead,
/// and the conversion happens exactly once, here.
library;

import 'package:intl/intl.dart';

const Duration istOffset = Duration(hours: 5, minutes: 30);

DateTime _shift(DateTime instant) => instant.toUtc().add(istOffset);

/// Formats a UTC instant from the API in IST. The only way this file lets
/// you render a timestamp.
String formatIst(DateTime instant, String pattern) =>
    DateFormat(pattern).format(_shift(instant));

/// Now, in IST — for code that needs to compare rather than display.
DateTime istNow() => _shift(DateTime.now());

/// Whether [instant] falls on today's IST date.
///
/// Both sides are shifted together. Comparing a UTC `postedAt` against a
/// local `DateTime.now()` decided "Today" across two different timezones,
/// which is the second half of the bug this file exists for.
bool isTodayIst(DateTime instant) {
  final a = _shift(instant);
  final b = istNow();
  return a.year == b.year && a.month == b.month && a.day == b.day;
}
