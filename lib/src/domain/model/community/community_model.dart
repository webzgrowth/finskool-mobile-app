import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';

/// A community, in both the shapes the app sees it.
///
/// `POST /auth/mobile/login` returns a **subset** of these fields for the
/// communities the user is subscribed to (id, name, slug, description, tags,
/// cover, member count). The browsable catalog knows more — category,
/// pricing, benefits, announcement counts — but it's the same entity, so
/// this is one class rather than two, and every catalog-only field is
/// optional so the login payload still parses.
///
/// The catalog is currently served by `CommunitiesMockDatasource`; there is
/// no backend endpoint for it yet (see CLAUDE.md "Communities").
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
    this.category,
    this.newAnnouncements = 0,
    this.access = CommunityAccess.subscribed,
    this.planStyle = CommunityPlanStyle.duration,
    this.plans = const [],
    this.benefits = const [],
  });

  final String id;
  final String name;
  final String slug;
  final List<String> tags;
  final int memberCount;

  /// May carry `**bold**` runs — render with `comman/rich_text_spans.dart`.
  final String? description;
  final String? coverImageUrl;
  final String? badgeUrl;

  /// The line above the title: "Long Term Investment", "For all skill
  /// levels".
  final String? category;

  /// Drives the "N New Announcements" tag and the bottom-nav badge.
  final int newAnnouncements;

  final CommunityAccess access;
  final CommunityPlanStyle planStyle;
  final List<CommunityPlanModel> plans;

  /// The "What You Get" checklist, hidden behind the card's dropdown.
  final List<String> benefits;

  /// The card's call-to-action, derived rather than stored so all four
  /// variants stay in one place.
  String get ctaLabel => switch (access) {
        CommunityAccess.subscribed => 'Enter Community',
        CommunityAccess.pricingOnRequest => 'Request Pricing',
        CommunityAccess.locked =>
          planStyle.isTier ? 'Enroll Now' : 'Unlock Subscription',
      };

  /// The plan the card leads with, and the one selected by default: the
  /// editorially `featured` one if there is one, else the cheapest.
  CommunityPlanModel? get headlinePlan {
    if (plans.isEmpty) return null;
    for (final plan in plans) {
      if (plan.featured) return plan;
    }
    return plans.reduce((a, b) => b.price < a.price ? b : a);
  }

  CommunityPlanModel? get defaultPlan => headlinePlan;

  CommunityModel copyWith({
    CommunityAccess? access,
    int? newAnnouncements,
  }) =>
      CommunityModel(
        id: id,
        name: name,
        slug: slug,
        tags: tags,
        memberCount: memberCount,
        description: description,
        coverImageUrl: coverImageUrl,
        badgeUrl: badgeUrl,
        category: category,
        newAnnouncements: newAnnouncements ?? this.newAnnouncements,
        access: access ?? this.access,
        planStyle: planStyle,
        plans: plans,
        benefits: benefits,
      );

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
        category: json['category'] as String?,
        newAnnouncements: json['newAnnouncements'] as int? ?? 0,
        access: json['access'] == null
            ? CommunityAccess.subscribed
            : CommunityAccessX.fromName(json['access'] as String),
        planStyle: json['planStyle'] == null
            ? CommunityPlanStyle.duration
            : CommunityPlanStyleX.fromName(json['planStyle'] as String),
        plans: json['plans'] == null
            ? const []
            : (json['plans'] as List)
                .map((p) =>
                    CommunityPlanModel.fromJson(p as Map<String, dynamic>))
                .toList(),
        benefits: json['benefits'] == null
            ? const []
            : List<String>.from(json['benefits'] as List),
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
        'category': category,
        'newAnnouncements': newAnnouncements,
        'access': access.name,
        'planStyle': planStyle.name,
        'plans': plans.map((p) => p.toJson()).toList(),
        'benefits': benefits,
      };
}
