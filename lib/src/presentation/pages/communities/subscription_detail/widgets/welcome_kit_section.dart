import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'capital_allocation_section.dart';
import 'watch_first_section.dart';
import 'welcome_kit_notice_card.dart';

/// The Welcome Kit, down to but not including "What You get".
///
/// It stops there on purpose: the design interleaves the kit with the
/// benefits list — risk notices above it, the disclaimer and the mission
/// sign-off below — so the screen owns that ordering and this renders only
/// the run that comes first. See [WelcomeKitFooter] for the other half.
class WelcomeKitSection extends StatelessWidget {
  const WelcomeKitSection({super.key, required this.kit});

  final WelcomeKit kit;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // The one heading on this screen that sits on the page rather than in
        // a teal bar: Manrope 700 · 20 over a 2px teal rule.
        IntrinsicWidth(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text('Welcome Kit', style: type.kitTitle),
              Container(
                height: 2,
                margin: const EdgeInsets.only(top: 1),
                decoration: BoxDecoration(
                  color: AppPalette.badgeTeal,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 11),
        if (kit.hasWatchSection) ...[
          WatchFirstSection(intro: kit.intro, videos: kit.videos),
          const SizedBox(height: 16),
        ],
        if (kit.capital != null) ...[
          CapitalAllocationSection(capital: kit.capital!),
          const SizedBox(height: 16),
        ],
        for (var i = 0; i < kit.notices.length; i++) ...[
          if (i > 0) const SizedBox(height: 16),
          WelcomeKitNoticeCard(notice: kit.notices[i]),
        ],
      ],
    );
  }
}

/// The run that follows "What You get": the acknowledgment and the centred
/// teal sign-off.
///
/// **Fixed design copy, not kit data** — Figma draws the same "understand the
/// trading process" banner and mission line under every community's kit, and
/// the API has no field for either, so they live here rather than in the model.
class WelcomeKitFooter extends StatelessWidget {
  const WelcomeKitFooter({super.key});

  static const _disclaimer = WelcomeKitNotice(
    tone: NoticeTone.info,
    body:
        'Please ensure that you **understand the trading** process and '
        'associated risks before participating in any trade.',
  );

  static const _mission = [
    'Saath Mein Seekhenge… Saath Mein Grow Karenge!!',
    'Our Mission: Har Ghar Ek Smart Investor!!',
  ];

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Column(
      children: [
        const WelcomeKitNoticeCard(notice: _disclaimer),
        const SizedBox(height: 13),
        for (final line in _mission)
          Text(line, style: type.mission, textAlign: TextAlign.center),
      ],
    );
  }
}
