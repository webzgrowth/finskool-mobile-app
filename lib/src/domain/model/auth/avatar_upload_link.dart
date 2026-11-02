/// Where to PUT a new profile picture, and the address it will have.
///
/// [uploadUrl] is signed and valid for about 5 minutes — use it at once and
/// exactly as returned (every query parameter is part of the signature).
class AvatarUploadLink {
  const AvatarUploadLink({required this.uploadUrl, required this.publicUrl});

  final String uploadUrl;
  final String publicUrl;

  factory AvatarUploadLink.fromJson(Map<String, dynamic> json) =>
      AvatarUploadLink(
        uploadUrl: json['uploadUrl'] as String? ?? '',
        publicUrl: json['publicUrl'] as String? ?? '',
      );
}
