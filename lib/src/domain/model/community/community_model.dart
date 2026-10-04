import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';

/// A community, in both the shapes the app sees it.
///
/// `POST /auth/mobile/login` returns a **subset** of these fields for the
/// communities the user is subscribed to (id, name, slug, description, tags,
/// cover, member count). The browsable catalog knows more — category,
/// pricing, benefits, announcement counts — but it's the same entity, so
/// this is one class rather than two, and every catalog-only field is
/// optional so the login payload still parses.
///
/// Three factories, one per source: [fromCatalogJson] for
/// `GET /mobile/communities`, [fromMembershipJson] for the `communities` on
/// `GET /auth/mobile/me`, and [fromJson] for login's payload and the prefs
/// cache (which round-trips [toJson]).
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
    this.subscribedUntil,
    this.subscriptionInfo,
    this.welcomeKit,
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

  /// Only meaningful when [access] is `subscribed` — drives the Profile
  /// tab's "My Subscription" row. Comes from `expiresAt` on
  /// `GET /auth/mobile/me`'s communities; null for anything not subscribed.
  final DateTime? subscribedUntil;

  /// Plan, transaction and auto-renew details for the Subscription Detail
  /// screen. Only set on subscribed communities with known purchase data.
  final SubscriptionInfo? subscriptionInfo;

  /// Onboarding material for the Subscription Detail screen. Never present
  /// in any payload — no endpoint describes it — so it is attached by
  /// `WelcomeKitDemoDatasource` and is null for a community the design
  /// doesn't cover, which hides the section.
  final WelcomeKit? welcomeKit;

  /// Renewal is nudged inside this window — Figma's mockup shows "Expires
  /// in 7 days" with a Renew pill on the community that's close, and a
  /// plain "Active till…" on the one that isn't.
  static const _renewalWindow = Duration(days: 14);

  bool get needsRenewal =>
      subscribedUntil != null &&
      subscribedUntil!.difference(DateTime.now()) <= _renewalWindow;

  /// "Active till 31 Dec 2026" or "Expires in 7 days", matching Figma's two
  /// phrasings. Null when there's no subscription date to show.
  String? get subscriptionStatusLabel {
    final until = subscribedUntil;
    if (until == null) return null;
    if (needsRenewal) {
      final days = until.difference(DateTime.now()).inDays;
      return 'Expires in ${days <= 0 ? 1 : days} day${days == 1 ? '' : 's'}';
    }
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return 'Active till ${until.day} ${months[until.month - 1]} ${until.year}';
  }

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
    DateTime? subscribedUntil,
    SubscriptionInfo? subscriptionInfo,
    WelcomeKit? welcomeKit,
  }) => CommunityModel(
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
    subscribedUntil: subscribedUntil ?? this.subscribedUntil,
    subscriptionInfo: subscriptionInfo ?? this.subscriptionInfo,
  );

  /// One row of `GET /mobile/communities` — the purchasable catalog.
  ///
  /// The API's names differ from this model's: `type` is our [category],
  /// `whatsIncluded` our [benefits], `subscribedMemberCount` our
  /// [memberCount].
  ///
  /// Three fields have **no API equivalent** and are derived or defaulted
  /// here rather than faked:
  ///
  /// * [access] — this endpoint says nothing about membership, so everything
  ///   arrives `locked` and the repository promotes the user's own
  ///   communities to `subscribed` from `GET /auth/mobile/me`. A community
  ///   with **no plans** becomes `pricingOnRequest` instead: nothing is
  ///   purchasable, so the price isn't public.
  /// * [planStyle] — always `duration`. The academy's "Enroll Now" tier
  ///   styling isn't expressible in the payload; it needs a backend field.
  /// * [newAnnouncements] — always 0, so the Communities nav badge reads 0
  ///   rather than showing an invented count. There is no unread-count
  ///   endpoint.
  factory CommunityModel.fromCatalogJson(Map<String, dynamic> json) {
    final plans = CommunityPlanModel.fromCatalogList(
      (json['plans'] as List?) ?? const [],
    );
    return CommunityModel(
      id: json['id'] as String,
      name: json['name'] as String,
      slug: json['slug'] as String? ?? '',
      tags: List<String>.from((json['tags'] as List?) ?? const []),
      memberCount: (json['subscribedMemberCount'] as num?)?.toInt() ?? 0,
      description: json['description'] as String?,
      coverImageUrl: json['coverImageUrl'] as String?,
      badgeUrl: json['badgeUrl'] as String?,
      category: json['type'] as String?,
      access: plans.isEmpty
          ? CommunityAccess.pricingOnRequest
          : CommunityAccess.locked,
      plans: plans,
      benefits: List<String>.from((json['whatsIncluded'] as List?) ?? const []),
    );
  }

  /// One row of `GET /auth/mobile/me`'s `communities` — a community the user
  /// is actually in, which is the only place membership is stated.
  ///
  /// `expiresAt` lands on [subscribedUntil], which is what drives the Profile
  /// tab's "Active till…" / "Expires in N days" line and the Renew pill. It
  /// used to be mock-only. The row carries no plans, benefits or member
  /// count — the repository merges those in from the catalog where the same
  /// community appears in both.
  factory CommunityModel.fromMembershipJson(Map<String, dynamic> json) =>
      CommunityModel(
        id: json['id'] as String,
        name: json['name'] as String,
        slug: json['slug'] as String? ?? '',
        tags: List<String>.from((json['tags'] as List?) ?? const []),
        memberCount: (json['subscribedMemberCount'] as num?)?.toInt() ?? 0,
        description: json['description'] as String?,
        coverImageUrl: json['coverImageUrl'] as String?,
        badgeUrl: json['badgeUrl'] as String?,
        access: CommunityAccess.subscribed,
        subscribedUntil: _date(json['expiresAt']),
      );

  static DateTime? _date(Object? value) =>
      value is String && value.isNotEmpty ? DateTime.tryParse(value) : null;

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
              .map(
                (p) => CommunityPlanModel.fromJson(p as Map<String, dynamic>),
              )
              .toList(),
    benefits: json['benefits'] == null
        ? const []
        : List<String>.from(json['benefits'] as List),
    // `expiresAt` too: login's community payload and the prefs cache
    // use this same factory, and login spells it the API's way.
    subscribedUntil: _date(json['subscribedUntil']) ?? _date(json['expiresAt']),
    subscriptionInfo: json['subscriptionInfo'] == null
        ? null
        : SubscriptionInfo.fromJson(
            json['subscriptionInfo'] as Map<String, dynamic>,
          ),
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
    'subscribedUntil': subscribedUntil?.toIso8601String(),
    'subscriptionInfo': subscriptionInfo?.toJson(),
  };
}
