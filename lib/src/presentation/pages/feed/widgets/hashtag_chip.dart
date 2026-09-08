import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A single "#TATASTEEL"-style hashtag pill under a post.
class HashtagChip extends StatelessWidget {
  const HashtagChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(
        color: cs.surfaceContainer,
        borderRadius: AppRadii.small,
      ),
      child: Text(text, style: tt.labelSmall?.copyWith(color: cs.secondary)),
    );
  }
}
