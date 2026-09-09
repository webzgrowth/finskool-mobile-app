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
  });

  final String id;
  final String name;
  final String phone;
  final String email;
  final String role;
  final bool isSuperAdmin;
  final bool postNotificationsEnabled;
  final String? avatarUrl;

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
      };
}
