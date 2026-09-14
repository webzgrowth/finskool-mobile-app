import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_glyph.dart';

/// The overlapping circles next to a post's reaction count.
///
/// These show **which reaction types** the post received, not who reacted —
/// per Figma's `Group 1739329594`: five 20.65px white circles on a 13px
/// pitch, each holding ~12px of art, with the total to their right. (Who
/// reacted is the Reactions bottom sheet's job.)
class ReactionBadgeStack extends StatelessWidget {
  const ReactionBadgeStack({super.key, required this.reactions});

  /// Distinct reaction types present on the post, most-used first.
  final List<ReactionType> reactions;

  static const double _diameter = 20;
  static const double _pitch = 13;
  static const double _art = 12;

  @override
  Widget build(BuildContext context) {
    final visible = reactions.take(5).toList();
    if (visible.isEmpty) return const SizedBox.shrink();

    return SizedBox(
      width: _diameter + (visible.length - 1) * _pitch,
      height: _diameter,
      child: Stack(
        children: [
          // Built in reverse so the earlier (more-used) badges paint on top,
          // matching the overlap direction in the mockup.
          for (var i = visible.length - 1; i >= 0; i--)
            Positioned(
              left: i * _pitch,
              child: ReactionBadge(
                reaction: visible[i],
                diameter: _diameter,
                art: _art,
              ),
            ),
        ],
      ),
    );
  }
}
