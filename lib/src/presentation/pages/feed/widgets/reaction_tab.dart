import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_glyph.dart';

/// One tab in the Reactions sheet's filter row.
///
/// Not a Material chip: per Figma every label is teal `#108B8B` regardless of
/// state, and the **only** selected indicator is the 1px underline that
/// overlays the row's rule. A reaction tab is a 16px badge plus its count;
/// the leading tab is the plain "All (N)".
class ReactionTab extends StatelessWidget {
  const ReactionTab({
    super.key,
    required this.count,
    required this.selected,
    required this.onTap,
    this.reaction,
  });

  /// Null for the "All" tab.
  final ReactionType? reaction;
  final int count;
  final bool selected;
  final VoidCallback onTap;

  /// Figma: 16px disc with 9.3px of art.
  static const double _badge = 16;
  static const double _badgeArt = 9.3;

  @override
  Widget build(BuildContext context) {
    final type = context.feedType;
    final badge = reaction;
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      // The underline is a bottom *border* rather than a sibling box: a
      // `Container(height: 1)` with no child collapses to zero width inside
      // a Column, so it rendered as nothing. As a border it sizes itself to
      // the tab (padding included, matching Figma's 59px under "All (3)"),
      // and a transparent border keeps unselected tabs the same height so
      // selection causes no layout shift.
      child: Container(
        padding: const EdgeInsets.only(left: 8, right: 8, bottom: 6),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: selected ? AppPalette.badgeTeal : Colors.transparent,
              width: 1,
            ),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (badge == null)
              Text('All', style: type.tabLabel)
            else
              ReactionBadge(reaction: badge, diameter: _badge, art: _badgeArt),
            const SizedBox(width: 4),
            Text(badge == null ? '($count)' : '$count', style: type.tabLabel),
          ],
        ),
      ),
    );
  }
}
