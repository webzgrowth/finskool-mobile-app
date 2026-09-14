import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';

/// The buyable options on a locked community, as **radio rows**: a radio
/// dot, the period or tier, then the price pushed to the right edge.
///
/// Selected rows take a teal border over a pale teal fill with teal text;
/// the "Save ₹ 1k" flag is a slate pill notched onto the top-right corner.
/// Two per row, matching Figma's 163-wide buttons on a 333-wide card.
class PlanSelector extends StatelessWidget {
  const PlanSelector({
    super.key,
    required this.plans,
    required this.selectedId,
    required this.onSelected,
  });

  final List<CommunityPlanModel> plans;
  final String selectedId;
  final ValueChanged<CommunityPlanModel> onSelected;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final itemWidth = (constraints.maxWidth - AppSpacing.sm) / 2;
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.md,
          children: [
            for (final plan in plans)
              SizedBox(
                width: itemWidth,
                child: _PlanRow(
                  plan: plan,
                  selected: plan.id == selectedId,
                  onTap: () => onSelected(plan),
                ),
              ),
          ],
        );
      },
    );
  }
}

class _PlanRow extends StatelessWidget {
  const _PlanRow({
    required this.plan,
    required this.selected,
    required this.onTap,
  });

  final CommunityPlanModel plan;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.communityType;
    final accent = AppPalette.badgeTeal;

    return GestureDetector(
      onTap: onTap,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 160),
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm),
            decoration: BoxDecoration(
              color: selected
                  ? accent.withValues(alpha: 0.08)
                  : cs.surface,
              borderRadius: AppRadii.small,
              border: Border.all(
                color: selected ? accent : AppPalette.tabDivider,
                width: selected ? 1.4 : 1,
              ),
            ),
            child: Row(
              children: [
                _Radio(selected: selected, accent: accent),
                const SizedBox(width: AppSpacing.sm),
                // Expanded, not Flexible: the price is pinned to the right
                // edge of the row, with the label taking the slack.
                Expanded(
                  child: Text(
                    plan.label,
                    overflow: TextOverflow.ellipsis,
                    style: type.planLabel.copyWith(
                        color: selected ? accent : AppPalette.postMeta),
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                Text(
                  plan.priceLabel,
                  style: type.planLabel
                      .copyWith(color: selected ? accent : null),
                ),
              ],
            ),
          ),
          if (plan.saveLabel != null)
            Positioned(
              top: -9,
              right: 8,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
                decoration: BoxDecoration(
                  color: AppPalette.postMeta,
                  borderRadius: BorderRadius.circular(AppRadii.pill),
                ),
                child: Text(plan.saveLabel!,
                    style: type.memberCount.copyWith(fontSize: 9)),
              ),
            ),
        ],
      ),
    );
  }
}

class _Radio extends StatelessWidget {
  const _Radio({required this.selected, required this.accent});

  final bool selected;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 160),
      height: 14,
      width: 14,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: selected ? accent : AppPalette.tabDivider,
          width: selected ? 4 : 1.2,
        ),
      ),
    );
  }
}
