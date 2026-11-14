import 'package:flutter/material.dart';
import 'package:finskool/src/comman/widgets/skeleton.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';

/// The card's own shape in grey blocks: tile, two text lines, the amount and
/// the pill, a rule, and the invoice row.
class TransactionCardSkeleton extends StatelessWidget {
  const TransactionCardSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return const TicketCard(
      child: Column(
        children: [
          Row(
            children: [
              SkeletonBox(height: 36, width: 36, radius: 11),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SkeletonBox(height: 14, width: 150, radius: 6),
                    SizedBox(height: 8),
                    SkeletonBox(height: 10, width: 110, radius: 6),
                  ],
                ),
              ),
              SizedBox(width: 12),
              SkeletonBox(height: 34, width: 56, radius: 8),
            ],
          ),
          SizedBox(height: 24),
          Row(
            children: [
              SkeletonBox(height: 22, width: 90, radius: 6),
              Spacer(),
              SkeletonBox(height: 25, width: 93, radius: 20),
            ],
          ),
        ],
      ),
    );
  }
}
