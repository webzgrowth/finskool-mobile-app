import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'benefit_check.dart';

/// The "What You Get" dropdown on a locked community card (the designer
/// labels it "Drop Down", `902:19009`).
///
/// Shown only on communities the user hasn't joined — once subscribed the
/// benefits are moot, so `CommunityCard` omits it entirely.
///
/// Expansion is **local widget state, not a bloc** — transient UI with no
/// app-state meaning, and each card expands independently. See CLAUDE.md's
/// "Bloc granularity" note.
class WhatYouGetPanel extends StatefulWidget {
  const WhatYouGetPanel({super.key, required this.benefits});

  /// May carry `**bold**` runs — Figma emphasises the key figure in each
  /// line ("**12 trades per month**").
  final List<String> benefits;

  @override
  State<WhatYouGetPanel> createState() => _WhatYouGetPanelState();
}

class _WhatYouGetPanelState extends State<WhatYouGetPanel> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    if (widget.benefits.isEmpty) return const SizedBox.shrink();
    final cs = Theme.of(context).colorScheme;
    final type = context.communityType;

    return Container(
      decoration: BoxDecoration(
        color: AppPalette.communityChipTint.withValues(alpha: 0.06),
        borderRadius: AppRadii.small,
        border: Border.all(color: AppPalette.communityChipBorder, width: 0.862),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          InkWell(
            onTap: () => setState(() => _expanded = !_expanded),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              child: Row(
                children: [
                  // Exact 17x16 mark from Figma (`921:21494`).
                  Image.asset('assets/icons/what_you_get.png',
                      height: 16, width: 17),
                  const SizedBox(width: AppSpacing.sm),
                  Text('What You Get',
                      style: type.planLabel.copyWith(color: cs.secondary)),
                  const Spacer(),
                  AnimatedRotation(
                    turns: _expanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 180),
                    child: Icon(Icons.keyboard_arrow_down_rounded,
                        size: 18, color: cs.secondary),
                  ),
                ],
              ),
            ),
          ),
          AnimatedCrossFade(
            firstChild: const SizedBox(width: double.infinity),
            secondChild: Padding(
              padding: const EdgeInsets.fromLTRB(
                  AppSpacing.md, 0, AppSpacing.md, AppSpacing.md),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final benefit in widget.benefits)
                    Padding(
                      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Padding(
                            padding: EdgeInsets.only(top: 3),
                            child: BenefitCheck(),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text.rich(TextSpan(
                              children: boldSpans(benefit, type.benefit,
                                  type.benefitBold),
                            )),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
            crossFadeState: _expanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 180),
            sizeCurve: Curves.easeOut,
          ),
        ],
      ),
    );
  }
}
