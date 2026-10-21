import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A single "#TATASTEEL"-style hashtag pill under a post.
class HashtagChip extends StatelessWidget {
  const HashtagChip({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    // Figma: a 17.8px pill, `#F5F6F9`, fully rounded, text 10px.
    return Container(
      height: 17.8,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppPalette.feedChip,
        borderRadius: BorderRadius.circular(14.5),
      ),
      // `Container(alignment:)` would expand to fill the Wrap's width; a
      // width-hugging Center keeps the pill the size of its label.
      child: Center(
        widthFactor: 1,
        child: Text(text, style: context.feedType.hashtag),
      ),
    );
  }
}
