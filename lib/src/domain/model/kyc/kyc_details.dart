/// The SEBI details collected once, after a member's first paid community.
///
/// Held in memory only long enough to submit. **Nothing is persisted on the
/// device** — the server keeps them (the PAN encrypted) and answers with a
/// completion flag and a masked PAN, see `KycStatus`.
class KycDetails {
  const KycDetails({required this.dateOfBirth, required this.panNumber});

  /// As typed, `DD/MM/YYYY`.
  final String dateOfBirth;

  /// 10 characters, uppercase — `ABCDE1234F`.
  final String panNumber;

  /// The API's `YYYY-MM-DD`, or null when [dateOfBirth] isn't a complete,
  /// real calendar date (`31/02/2000` is not).
  String? get isoDateOfBirth {
    final parts = dateOfBirth.trim().split('/');
    if (parts.length != 3) return null;
    final day = int.tryParse(parts[0]);
    final month = int.tryParse(parts[1]);
    final year = int.tryParse(parts[2]);
    if (day == null || month == null || year == null) return null;
    if (parts[2].length != 4) return null;
    final date = DateTime(year, month, day);
    // DateTime rolls an impossible date over (31 Feb → 3 Mar); reject that.
    if (date.year != year || date.month != month || date.day != day) {
      return null;
    }
    String two(int n) => n.toString().padLeft(2, '0');
    return '$year-${two(month)}-${two(day)}';
  }

  Map<String, dynamic> toJson() => {
    'dateOfBirth': isoDateOfBirth,
    'panNumber': panNumber.trim().toUpperCase(),
  };
}
