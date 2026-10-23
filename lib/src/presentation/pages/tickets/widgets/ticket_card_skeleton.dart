import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'ticket_card.dart';

/// A loading row shaped like [TicketCard]'s real content (My Tickets, My
/// Requests, and anywhere else that reuses it) — same chrome, so nothing
/// resizes once real rows replace it; the number/status/subject/meta lines
/// inside are an approximation, not traced to Figma (see
/// `ServiceCardSkeleton`).
class TicketCardSkeleton extends StatelessWidget {
  const TicketCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return TicketCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(child: SkeletonLine(widthFactor: 0.3, height: 14)),
              const SizedBox(width: AppSpacing.sm),
              SkeletonBox(height: 21, width: 74, radius: AppRadii.pill),
            ],
          ),
          const SizedBox(height: 10),
          const SkeletonLine(widthFactor: 0.7, height: 14),
          const SizedBox(height: 10),
          Container(height: 1, color: AppPalette.ticketDivider),
          const SizedBox(height: 10),
          Row(
            children: [
              const Expanded(child: SkeletonLine(widthFactor: 0.4, height: 11)),
              const SizedBox(width: AppSpacing.sm),
              const SkeletonBox(height: 10, width: 10, radius: 2),
            ],
          ),
        ],
      ),
    );
  }
}
