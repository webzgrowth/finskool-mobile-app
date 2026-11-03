import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/data/datasource/reaction_type_catalog.dart';

import 'reaction_glyph.dart';
import 'reaction_icons.dart';
import 'reaction_picker_overlay.dart';
import 'reactions_bottom_sheet.dart';
import 'reaction_badge_stack.dart';

/// The like row: **tap opens the full reaction picker** (the member chooses —
/// there is no instant like), long-press opens the same picker as a drag-to-
/// select, tapping the count opens the Reactions sheet.
class PostReactionBar extends StatefulWidget {
  const PostReactionBar({super.key, required this.post});

  final FeedPostModel post;

  @override
  State<PostReactionBar> createState() => _PostReactionBarState();
}

class _PostReactionBarState extends State<PostReactionBar> {
  final _picker = ReactionPickerOverlay();
  final _buttonKey = GlobalKey();

  /// What the backend offers (`GET /mobile/reaction-types`, fetched once for
  /// the app). Null until it answers; the picker then offers the default set.
  Set<ReactionType>? _offered;

  @override
  void initState() {
    super.initState();
    locator<ReactionTypeCatalog>()
        .all()
        .then((types) {
          if (!mounted) return;
          _offered = {
            for (final t in types)
              if (t.type != null) t.type!,
          };
        })
        .catchError((_) {}); // the default set is a fine fallback
  }

  List<ReactionType> get _reactions => ReactionIcons.available(_offered);

  @override
  void dispose() {
    _picker.dispose();
    super.dispose();
  }

  Offset _anchor() {
    final box = _buttonKey.currentContext!.findRenderObject() as RenderBox;
    final topLeft = box.localToGlobal(Offset.zero);
    return topLeft + Offset(box.size.width / 2, 0);
  }

  void _react(ReactionType reaction) {
    context.read<FeedBloc>().add(
      FeedEvent.reactToPost(postId: widget.post.id, reaction: reaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final current = widget.post.currentUserReaction;
    return Row(
      children: [
        GestureDetector(
          key: _buttonKey,
          // Opens every reaction and lets the member choose. Choosing the one
          // they already have takes it back.
          onTap: () => _picker.showTappable(
            context,
            _anchor(),
            offered: _reactions,
            current: current,
            onSelect: (r) {
              if (r == current) {
                context.read<FeedBloc>().add(
                  FeedEvent.removeReaction(postId: widget.post.id),
                );
              } else {
                _react(r);
              }
            },
          ),
          onLongPressStart: (_) =>
              _picker.show(context, _anchor(), offered: _reactions),
          onLongPressMoveUpdate: (d) => _picker.updateHover(d.globalPosition),
          onLongPressEnd: (_) {
            final selected = _picker.hide();
            if (selected != null) {
              // A clear "landed" tick, distinct from the lighter scrub ticks
              // while dragging across the row — this is the one that means
              // "a reaction was actually sent".
              HapticFeedback.mediumImpact();
              _react(selected);
            }
          },
          // Figma's Like control (`Group 1739329635`) puts the glyph on a
          // 24px `#E4E4E4` disc — restored per the user's reference
          // screenshot (an earlier pass had dropped it for a bare-icon
          // look; that's now reverted). Still no text label: there is no
          // "Like" text node anywhere in the file. Once a different
          // reaction is picked we show that instead, which Figma doesn't
          // specify but the picker implies.
          child: Container(
            height: 24,
            width: 24,
            decoration: const BoxDecoration(
              color: AppPalette.likeButtonSurface,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: current == null || current == ReactionType.like
                  ? SizedBox(
                      height: 16,
                      width: 16,
                      child: SvgPicture.asset(
                        ReactionIcons.likeButton,
                        colorFilter: ColorFilter.mode(
                          current == null ? AppPalette.postMeta : cs.primary,
                          BlendMode.srcIn,
                        ),
                      ),
                    )
                  // `inherit: false` is required: the theme sets a custom
                  // fontFamily and U+2764 (❤) defaults to *text*
                  // presentation, so without it the heart renders as a
                  // monochrome glyph tinted by the inherited text colour —
                  // which showed up as a green heart, not a red one.
                  : ReactionGlyph(reaction: current, size: 16),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => showReactionsSheet(context, postId: widget.post.id),
          child: Row(
            children: [
              ReactionBadgeStack(reactions: widget.post.rankedReactions),
              const SizedBox(width: AppSpacing.xs),
              Text(
                '${widget.post.totalReactions}',
                style: context.feedType.reactionCount,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
