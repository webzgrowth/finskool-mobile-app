import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A "Research" / "Portfolio" pill under a community's description.
///
/// Figma (`750:1136`): 21 high, fully rounded, the brand teal at 6% behind
/// a 0.862px `#F5F6F9` hairline. Distinct from the feed's [HashtagChip],
/// which has no border and a different fill, so it isn't reused here.
class CommunityTagChip extends StatelessWidget {
  const CommunityTagChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 21,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: AppPalette.communityChipTint.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppRadii.pill),
        border: Border.all(color: AppPalette.communityChipBorder, width: 0.862),
      ),
      // `Center` with a width factor, not `Container.alignment`: that
      // property wraps the child in a bare `Align`, which expands to the
      // full incoming width and made every chip a full-width row.
      child: Center(
        widthFactor: 1,
        child: Text(label, style: context.communityType.tagChip),
      ),
    );
  }
}
