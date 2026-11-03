/// `GET /auth/mobile/me/kyc` — whether the member has given their date of
/// birth and PAN.
///
/// The full PAN is **never** returned, only [panMasked] (`XXXXXX234F`).
class KycStatus {
  const KycStatus({required this.completed, this.dateOfBirth, this.panMasked});

  final bool completed;

  /// A calendar date, not an instant: built from `YYYY-MM-DD` with no time
  /// zone, so it can't slip a day when shown in another zone.
  final DateTime? dateOfBirth;
  final String? panMasked;

  factory KycStatus.fromJson(Map<String, dynamic> json) {
    final dob = json['dateOfBirth'] as String?;
    return KycStatus(
      completed: json['completed'] as bool? ?? false,
      dateOfBirth: _date(dob),
      panMasked: json['panMasked'] as String?,
    );
  }

  static DateTime? _date(String? iso) {
    if (iso == null || iso.length < 10) return null;
    final y = int.tryParse(iso.substring(0, 4));
    final m = int.tryParse(iso.substring(5, 7));
    final d = int.tryParse(iso.substring(8, 10));
    if (y == null || m == null || d == null) return null;
    return DateTime(y, m, d);
  }
}
