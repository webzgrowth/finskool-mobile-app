import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "What happens next": three numbered steps on a 68px pitch.
///
/// Reworded from Figma to what the backend really does (§10): no email goes
/// out for replies, and a member can neither close nor reopen a ticket — they
/// rate it once support resolves it.
class WhatHappensNext extends StatelessWidget {
  const WhatHappensNext({super.key});

  static const _steps = [
    (
      'Support team reviews your ticket',
      'Your details and attachments are shared with the team.',
    ),
    ('You get a reply', 'Here, under My tickets, as soon as support answers.'),
    ('Rate it when sorted', 'Once it is resolved, tell us how it went.'),
  ];

  @override
  Widget build(BuildContext context) {
    return TealSectionCard(
      title: 'What happens next',
      padding: const EdgeInsets.fromLTRB(17, 14.5, 17, 14),
      child: Column(
        children: [
          for (var i = 0; i < _steps.length; i++) ...[
            if (i > 0) const SizedBox(height: 14),
            _Step(number: i + 1, title: _steps[i].$1, body: _steps[i].$2),
          ],
        ],
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.number, required this.title, required this.body});

  final int number;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 24,
          width: 24,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: AppPalette.badgeTeal,
            shape: BoxShape.circle,
          ),
          child: Text('$number', style: type.stepBadge),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: type.nextTitle),
              const SizedBox(height: 2),
              Text(body, style: type.nextBody),
            ],
          ),
        ),
      ],
    );
  }
}
