/// A community the user holds an active paid subscription to. Login returns
/// every one of them; exactly one means it's auto-selected, more than one
/// means the user has to pick before feed calls are scoped.
class CommunityModel {
  const CommunityModel({
    required this.id,
    required this.name,
    required this.slug,
    required this.tags,
    required this.memberCount,
    this.description,
    this.coverImageUrl,
    this.badgeUrl,
  });

  final String id;
  final String name;
  final String slug;
  final List<String> tags;
  final int memberCount;
  final String? description;
  final String? coverImageUrl;
  final String? badgeUrl;

  factory CommunityModel.fromJson(Map<String, dynamic> json) => CommunityModel(
        id: json['id'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String,
        tags: json['tags'] == null
            ? const []
            : List<String>.from(json['tags'] as List),
        memberCount: json['memberCount'] as int? ?? 0,
        description: json['description'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        badgeUrl: json['badgeUrl'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'slug': slug,
        'tags': tags,
        'memberCount': memberCount,
        'description': description,
        'coverImageUrl': coverImageUrl,
        'badgeUrl': badgeUrl,
      };
}
