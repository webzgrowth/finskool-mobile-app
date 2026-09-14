import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_access.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'announcement_tag.dart';
import 'community_cover.dart';
import 'community_cta_button.dart';
import 'community_tag_chip.dart';
import 'plan_selector.dart';
import 'price_block.dart';
import 'what_you_get_panel.dart';

/// One community in the catalog.
///
/// Figma (`750:1116`): white, radius 20, shadow `0 2 10 rgba(0,0,0,.1)`.
/// The CTA and the presence of the price block follow from the community's
/// access + plan style — see [CommunityModel.ctaLabel].
///
/// Stateful only to hold the selected plan, which is a transient choice
/// until the CTA is tapped (CLAUDE.md's "not everything is a bloc").
class CommunityCard extends StatefulWidget {
  const CommunityCard({
    super.key,
    required this.community,
    required this.onCta,
  });

  final CommunityModel community;

  /// Fires with the chosen plan, or null when the community isn't priced
  /// (subscribed → enter, pricing-on-request → enquire).
  final void Function(CommunityPlanModel? plan) onCta;

  @override
  State<CommunityCard> createState() => _CommunityCardState();
}

class _CommunityCardState extends State<CommunityCard> {
  CommunityPlanModel? _selected;

  CommunityPlanModel? get _plan =>
      _selected ?? widget.community.defaultPlan;

  @override
  Widget build(BuildContext context) {
    final community = widget.community;
    final type = context.communityType;
    final showPricing =
        community.access.isLocked && community.plans.isNotEmpty;

    return Container(
      margin: const EdgeInsets.fromLTRB(
          AppSpacing.lg, 0, AppSpacing.lg, AppSpacing.lg),
      decoration: BoxDecoration(
        color: context.gradients.feedCard,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow.withValues(alpha: 0.1),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CommunityCover(
              imageUrl: community.coverImageUrl,
              memberCount: community.memberCount,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, AppSpacing.sm, AppSpacing.md, AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (community.category != null)
                        Expanded(
                          child: Text(community.category!,
                              style: type.category),
                        )
                      else
                        const Spacer(),
                      if (community.newAnnouncements > 0)
                        AnnouncementTag(count: community.newAnnouncements),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(community.name, style: type.title),
                  if (community.description != null) ...[
                    const SizedBox(height: AppSpacing.sm),
                    // Bold runs come from `**…**` markers — the designer's
                    // "important words in the description will be bold".
                    Text.rich(TextSpan(
                      children: boldSpans(community.description!,
                          type.description, type.descriptionBold),
                    )),
                  ],
                  if (community.tags.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: 7,
                      runSpacing: AppSpacing.sm,
                      children: [
                        for (final tag in community.tags)
                          CommunityTagChip(label: tag),
                      ],
                    ),
                  ],
                  // Only on communities the user hasn't joined — once
                  // subscribed the benefits are moot, so Figma drops the
                  // dropdown from those cards entirely.
                  if (!community.access.isSubscribed &&
                      community.benefits.isNotEmpty) ...[
                    const SizedBox(height: AppSpacing.md),
                    WhatYouGetPanel(benefits: community.benefits),
                  ],
                  if (showPricing) ...[
                    const SizedBox(height: AppSpacing.md),
                    if (community.headlinePlan != null)
                      PriceBlock(plan: community.headlinePlan!),
                    const SizedBox(height: AppSpacing.md),
                    PlanSelector(
                      plans: community.plans,
                      selectedId: _plan?.id ?? '',
                      onSelected: (plan) =>
                          setState(() => _selected = plan),
                    ),
                  ],
                  const SizedBox(height: AppSpacing.lg),
                  CommunityCtaButton(
                    label: community.ctaLabel,
                    leadingLock: community.access.isLocked,
                    onPressed: () => widget.onCta(showPricing ? _plan : null),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
