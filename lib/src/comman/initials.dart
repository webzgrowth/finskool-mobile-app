/// First and last initial of a display name, for an avatar with no photo.
///
/// Shared because three different shapes need it — [UserModel] via
/// `UserAvatar`, a post's author, and a reactor row — and each of them gets
/// a nullable avatar URL from the API.
String initialsFor(String? name) {
  final trimmed = name?.trim() ?? '';
  if (trimmed.isEmpty) return '?';
  final parts = trimmed.split(RegExp(r'\s+'));
  if (parts.length == 1) return parts.first.substring(0, 1).toUpperCase();
  return (parts.first.substring(0, 1) + parts.last.substring(0, 1))
      .toUpperCase();
}
