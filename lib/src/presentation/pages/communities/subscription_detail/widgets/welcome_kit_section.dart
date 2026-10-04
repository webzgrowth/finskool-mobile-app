import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'capital_allocation_section.dart';
import 'watch_first_section.dart';
import 'welcome_kit_notice_card.dart';

/// The Welcome Kit, down to but not including "What You get".
///
/// It stops there on purpose: the design interleaves the kit with the
/// benefits list — risk notices above it, the blue disclaimer and the
/// mission sign-off below — so the screen owns that ordering and this
/// renders only the run that comes first. See [WelcomeKitFooter] for the
/// other half.
class WelcomeKitSection extends StatelessWidget {
  const WelcomeKitSection({super.key, required this.kit});

  final WelcomeKit kit;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The one heading on this screen that sits on the page rather than
        // in a teal bar, with a rule under it.
        Container(
          padding: const EdgeInsets.only(bottom: 2),
          decoration: const BoxDecoration(
            border: Border(
              bottom: BorderSide(color: AppPalette.postTitle, width: 1.5),
            ),
          ),
          child: Text('Welcome Kit', style: type.kitTitle),
        ),
        const SizedBox(height: AppSpacing.md),
        WatchFirstSection(intro: kit.watchIntro, videos: kit.videos),
        const SizedBox(height: AppSpacing.lg),
        CapitalAllocationSection(capital: kit.capital),
        for (final notice in kit.riskNotices) ...[
          const SizedBox(height: AppSpacing.md),
          WelcomeKitNoticeCard(notice: notice),
        ],
      ],
    );
  }
}

/// The run that follows "What You get": the blue disclaimer and the centred
/// teal sign-off.
class WelcomeKitFooter extends StatelessWidget {
  const WelcomeKitFooter({super.key, required this.kit});

  final WelcomeKit kit;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Column(
      children: [
        WelcomeKitNoticeCard(notice: kit.disclaimer),
        if (kit.mission.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          for (final line in kit.mission)
            Text(line, style: type.mission, textAlign: TextAlign.center),
        ],
      ],
    );
  }
}
