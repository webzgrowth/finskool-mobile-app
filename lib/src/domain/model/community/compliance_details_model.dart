/// The SEBI details collected once, before a user's first paid community.
///
/// Held only long enough to submit; the app persists a completion flag
/// (`StorageKeys.complianceCompleted`), never the PAN itself.
class ComplianceDetailsModel {
  const ComplianceDetailsModel({
    required this.dateOfBirth,
    required this.panNumber,
  });

  /// As typed, `DD/MM/YY` per the Figma placeholder.
  final String dateOfBirth;

  /// 10 characters, uppercase — `ABCDE1234F`.
  final String panNumber;

  Map<String, dynamic> toJson() => {
        'dateOfBirth': dateOfBirth,
        'panNumber': panNumber,
      };
}
