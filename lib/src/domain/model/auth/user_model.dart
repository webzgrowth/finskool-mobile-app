/// The authenticated user, as returned inside `POST /auth/mobile/login`'s
/// `data.user`. Also cached to prefs so the splash screen can restore a
/// session without a round-trip.
class UserModel {
  const UserModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.email,
    required this.role,
    required this.isSuperAdmin,
    required this.postNotificationsEnabled,
    this.avatarUrl,
    this.memberSince,
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final bool isSuperAdmin;
  final bool postNotificationsEnabled;
  final String? avatarUrl;

  /// Backs the Profile header's "Member since…" pill. Not part of the
  /// login payload today — optional, so its absence just hides the pill
  /// rather than inventing a date.
  final DateTime? memberSince;

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'] as String,
        name: json['name'] as String,
        phone: json['phone'] as String,
        email: json['email'] as String,
        role: json['role'] as String,
        isSuperAdmin: json['isSuperAdmin'] as bool? ?? false,
        postNotificationsEnabled:
            json['postNotificationsEnabled'] as bool? ?? true,
        avatarUrl: json['avatarUrl'] as String?,
        memberSince: json['memberSince'] == null
            ? null
            : DateTime.parse(json['memberSince'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'phone': phone,
        'email': email,
        'role': role,
        'isSuperAdmin': isSuperAdmin,
        'postNotificationsEnabled': postNotificationsEnabled,
        'avatarUrl': avatarUrl,
        'memberSince': memberSince?.toIso8601String(),
      };

  /// Only field the app currently writes back to is
  /// [postNotificationsEnabled] (the Profile screen's toggle) — see
  /// `AuthenticatorWatcherBloc.notificationsToggled`.
  UserModel copyWith({bool? postNotificationsEnabled}) => UserModel(
        id: id,
        name: name,
        phone: phone,
        email: email,
        role: role,
        isSuperAdmin: isSuperAdmin,
        postNotificationsEnabled:
            postNotificationsEnabled ?? this.postNotificationsEnabled,
        avatarUrl: avatarUrl,
        memberSince: memberSince,
      );
}
