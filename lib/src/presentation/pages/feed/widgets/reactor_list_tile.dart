import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';
import 'reaction_glyph.dart';

/// One person in the Reactions sheet.
///
/// Figma (`Group 1739329620`): a 35px avatar, a 15px gap, the name, then the
/// person's reaction badge **beside the name** rather than right-aligned,
/// with a hairline rule inset to the text column.
class ReactorListTile extends StatelessWidget {
  const ReactorListTile({
    super.key,
    required this.reactor,
    this.showDivider = true,
  });

  final ReactorModel reactor;
  final bool showDivider;

  static const double _avatar = 35;
  static const double _gap = 15;
  static const double _badge = 19.5;
  static const double _badgeArt = 12.6;
  static const double _inset = 13;

  @override
  Widget build(BuildContext context) {
    final type = context.feedType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: _inset, vertical: 5),
          child: Row(
            children: [
              CircleAvatar(
                radius: _avatar / 2,
                backgroundImage:
                    CachedNetworkImageProvider(reactor.avatarUrl),
              ),
              const SizedBox(width: _gap),
              // The badge tracks the end of the name, so the name must not
              // expand — hence Flexible rather than Expanded.
              Flexible(
                child: Text(
                  reactor.name,
                  style: type.reactorName,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              const SizedBox(width: 8),
              ReactionGlyphBadge(reactor: reactor),
              const Spacer(),
            ],
          ),
        ),
        if (showDivider)
          Padding(
            // Rule is inset to the text column, not the avatar (Figma: x=58
            // against the sheet's 13, i.e. 45 in).
            padding: const EdgeInsets.only(left: _avatar + _gap + _inset - 3),
            child: Container(height: 1, color: AppPalette.rowDivider),
          ),
      ],
    );
  }
}

/// The reaction badge shown next to a reactor's name.
class ReactionGlyphBadge extends StatelessWidget {
  const ReactionGlyphBadge({super.key, required this.reactor});

  final ReactorModel reactor;

  @override
  Widget build(BuildContext context) => ReactionBadge(
        reaction: reactor.reaction,
        diameter: ReactorListTile._badge,
        art: ReactorListTile._badgeArt,
      );
}
