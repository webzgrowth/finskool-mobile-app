import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'perf_card.dart';

/// Shown to a free member under their preview: how many trades the
/// subscription adds. The app never learns the admin's preview rules, only
/// `hiddenCount`.
class UnlockBanner extends StatelessWidget {
  const UnlockBanner({super.key, required this.hidden, required this.onTap});

  final int hidden;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return PerfCard(
      padding: const EdgeInsets.all(18),
      child: Row(
        children: [
          const Icon(Icons.lock_outline_rounded, color: AppPalette.badgeTeal),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              hidden == 1
                  ? '1 more trade for subscribers'
                  : '$hidden more trades for subscribers',
              style: type.stock,
            ),
          ),
          const SizedBox(width: 8),
          TextButton(onPressed: onTap, child: const Text('See plans')),
        ],
      ),
    );
  }
}
