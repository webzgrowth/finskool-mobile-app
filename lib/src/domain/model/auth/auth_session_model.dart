import 'package:finskool/src/domain/model/auth/community_model.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';

/// `POST /auth/mobile/login`'s `data` payload.
///
/// Deliberately holds no token — the credential is the `mobile_session_id`
/// cookie, captured by `SessionInterceptor`, never present in this body.
class AuthSessionModel {
  const AuthSessionModel({
    required this.user,
    required this.communities,
  });

  final UserModel user;
  final List<CommunityModel> communities;

  /// The doc's rule: one community means treat it as already selected.
  CommunityModel? get autoSelectedCommunity =>
      communities.length == 1 ? communities.first : null;

  factory AuthSessionModel.fromJson(Map<String, dynamic> json) =>
      AuthSessionModel(
        user: UserModel.fromJson(json['user'] as Map<String, dynamic>),
        communities: json['communities'] == null
            ? const []
            : (json['communities'] as List)
                .map((c) => CommunityModel.fromJson(c as Map<String, dynamic>))
                .toList(),
      );

  Map<String, dynamic> toJson() => {
        'user': user.toJson(),
        'communities': communities.map((c) => c.toJson()).toList(),
      };
}
