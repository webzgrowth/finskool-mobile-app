/// `POST /auth/mobile/forgot-password/verify-otp`'s `data` payload.
///
/// [cypher] is a one-time opaque token, not a session — hold it in memory for
/// the reset call only. It is **consumed whether the reset succeeds or
/// fails**, so a failed reset needs a fresh verify-otp round rather than a
/// retry with the same value.
class ResetCypherModel {
  const ResetCypherModel({
    required this.cypher,
    required this.cypherExpiresInSeconds,
  });

  final String cypher;
  final int cypherExpiresInSeconds;

  factory ResetCypherModel.fromJson(Map<String, dynamic> json) =>
      ResetCypherModel(
        cypher: json['cypher'] as String,
        cypherExpiresInSeconds: json['cypherExpiresInSeconds'] as int? ?? 600,
      );

  Map<String, dynamic> toJson() => {
        'cypher': cypher,
        'cypherExpiresInSeconds': cypherExpiresInSeconds,
      };
}
