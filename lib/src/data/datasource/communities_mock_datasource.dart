import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';

/// Hardcoded community catalog standing in for a backend that doesn't
/// exist yet — `docs/auth_api_doc.md` documents no community endpoints at
/// all beyond `/auth/mobile/select-community`.
///
/// `CommunitiesRepositoryImpl` calls this directly; swap this one file for
/// a `Dio`-backed datasource when the API lands. Same arrangement as
/// `FeedMockDatasource`.
///
/// Covers every card variant in Figma so all four CTA states and both plan
/// styles are exercised: subscribed, locked with duration plans, locked
/// without a public price, and an academy with tiers.
class CommunitiesMockDatasource {
  CommunitiesMockDatasource._();

  static const _cover =
      'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800';
  static const _coverAlt =
      'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=800';
  static const _coverAcademy =
      'https://images.unsplash.com/photo-1543286386-713bdd548da4?w=800';

  /// Two fixed subscription end-dates for the Profile tab's "My
  /// Subscription" section — one comfortably active, one inside the
  /// 14-day renewal window, so both `CommunityModel.subscriptionStatusLabel`
  /// phrasings ("Active till…" / "Expires in…") are exercised.
  static final _farExpiry = DateTime(2026, 12, 31);
  static final _nearExpiry = DateTime.now().add(const Duration(days: 7));

  /// Shared across the trading communities in the mockup.
  /// `**…**` marks the emphasised run, matching the bold words in Figma.
  static const _tradingBenefits = [
    'Min 3 trades per week – **12 trades per month**',
    'Average target **3%–4% per trade**',
    '**Specific entry price**, stoploss and target for each trade',
    '**Watchlist stocks** – every morning',
    'Private WhatsApp **community access**',
  ];

  static List<CommunityModel> getCommunities() => [
        CommunityModel(
          id: 'intraday',
          name: 'Intraday Community',
          slug: 'intraday-community',
          category: 'Long Term Investment',
          description:
              'Research reports, portfolio ideas, fundamental analysis and '
              '**long-term wealth building** strategies from our analysts.',
          tags: ['Research', 'Portfolio', 'Long-term'],
          coverImageUrl: _cover,
          memberCount: 1240,
          newAnnouncements: 10,
          access: CommunityAccess.subscribed,
          benefits: _tradingBenefits,
          subscribedUntil: _farExpiry,
        ),
        CommunityModel(
          id: 'investor',
          name: 'Investor Community',
          slug: 'investor-community',
          category: 'Short Term Investment',
          description:
              'Research reports, portfolio ideas, fundamental analysis and '
              '**market insights** for short-term positions.',
          tags: ['Market Insights', 'Portfolio', 'Short Term'],
          coverImageUrl: _coverAlt,
          memberCount: 540,
          // Figma's own Profile mockup (893:15731) shows this one
          // subscribed and close to expiry — "Expires in 7 days" + Renew —
          // so it's mocked subscribed here too, not locked.
          access: CommunityAccess.subscribed,
          plans: [
            CommunityPlanModel(
              id: 'investor-3m',
              label: '3 months',
              price: 4000,
              months: 3,
            ),
            CommunityPlanModel(
              id: 'investor-6m',
              label: '6 months',
              price: 7000,
              months: 6,
              saveLabel: 'Save ₹ 1k',
              perMonthLabel: '≈ ₹1,333/month',
              featured: true,
            ),
          ],
          benefits: _tradingBenefits,
          subscribedUntil: _nearExpiry,
        ),
        const CommunityModel(
          id: 'swing-alpha',
          name: 'Swing Alpha Community',
          slug: 'swing-alpha-community',
          category: 'Short Term Investment',
          description:
              'Curated swing trade ideas targeting **~5% returns** with '
              'defined entry, stoploss and target for every call.',
          tags: ['Swing', 'Alerts', 'Short Term'],
          coverImageUrl: _cover,
          memberCount: 860,
          newAnnouncements: 4,
          access: CommunityAccess.locked,
          plans: [
            CommunityPlanModel(
              id: 'swing-3m',
              label: '3 months',
              price: 4000,
              months: 3,
              saveLabel: 'Save ₹ 1k',
            ),
            CommunityPlanModel(
              id: 'swing-6m',
              label: '6 months',
              price: 7000,
              months: 6,
              saveLabel: 'Save ₹ 1k',
              perMonthLabel: '≈ ₹1,333/month',
              featured: true,
            ),
            CommunityPlanModel(
              id: 'swing-12m',
              label: '12 months',
              price: 12000,
              months: 12,
            ),
          ],
          benefits: _tradingBenefits,
        ),
        const CommunityModel(
          id: 'imp-model-portfolio',
          name: 'IMP – Model Portfolio',
          slug: 'imp-model-portfolio',
          category: 'Short Term Investment',
          description:
              'Research reports, portfolio ideas and fundamental analysis, '
              'with **pricing shared on request**.',
          tags: ['Research', 'Portfolio'],
          coverImageUrl: _coverAlt,
          memberCount: 310,
          access: CommunityAccess.pricingOnRequest,
          benefits: _tradingBenefits,
        ),
        const CommunityModel(
          id: 'portfolio-analysis',
          name: 'Portfolio Analysis',
          slug: 'portfolio-analysis',
          category: 'Short Term Investment',
          description:
              'A **one-to-one review** of your holdings with actionable '
              'rebalancing suggestions.',
          tags: ['Portfolio', 'Review'],
          coverImageUrl: _cover,
          memberCount: 120,
          access: CommunityAccess.pricingOnRequest,
          benefits: [
            'Detailed holding-by-holding review',
            'Rebalancing plan tailored to your goals',
            'Private WhatsApp community access',
          ],
        ),
        CommunityModel(
          id: 'finskool-academy',
          name: 'Finskool21 Academy',
          slug: 'finskool21-academy',
          category: 'For all skill levels',
          description:
              'Structured courses covering **technical and fundamental '
              'analysis**, from first principles to advanced strategy.',
          tags: ['Academy', 'Courses'],
          coverImageUrl: _coverAcademy,
          memberCount: 2100,
          newAnnouncements: 2,
          // Figma's Profile mockup shows this one subscribed too
          // ("Active till 31 Dec 2026"), alongside the catalog's locked
          // tier pricing for a user who hasn't bought it yet — the same
          // community can appear either way depending on the user, so the
          // mock picks the subscribed variant to match the Profile screen.
          access: CommunityAccess.subscribed,
          planStyle: CommunityPlanStyle.tier,
          plans: [
            CommunityPlanModel(
                id: 'academy-beginner', label: 'Beginner', price: 4000),
            CommunityPlanModel(
                id: 'academy-intermediate',
                label: 'Intermediate',
                price: 15000),
            CommunityPlanModel(
                id: 'academy-advanced', label: 'Advanced', price: 25000),
          ],
          benefits: [
            'Lifetime access to every module in your tier',
            'Live doubt-clearing sessions each week',
            'Certificate on completion',
            'Private WhatsApp community access',
          ],
          subscribedUntil: _farExpiry,
        ),
      ];
}
