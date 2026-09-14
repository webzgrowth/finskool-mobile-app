import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'reaction_glyph.dart';
import 'reaction_icons.dart';
import 'reaction_picker_overlay.dart';
import 'reactions_bottom_sheet.dart';
import 'reaction_badge_stack.dart';

/// The like row: tap toggles the default reaction, long-press opens the
/// animated 6-emoji picker, tapping the count opens the Reactions sheet.
class PostReactionBar extends StatefulWidget {
  const PostReactionBar({super.key, required this.post});

  final FeedPostModel post;

  @override
  State<PostReactionBar> createState() => _PostReactionBarState();
}

class _PostReactionBarState extends State<PostReactionBar> {
  final _picker = ReactionPickerOverlay();
  final _buttonKey = GlobalKey();

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
          onTap: () => current == null
              ? _react(ReactionType.like)
              : context.read<FeedBloc>().add(
                  FeedEvent.removeReaction(postId: widget.post.id),
                ),
          onLongPressStart: (_) => _picker.show(context, _anchor()),
          onLongPressMoveUpdate: (d) => _picker.updateHover(d.globalPosition),
          onLongPressEnd: (_) {
            final selected = _picker.hide();
            if (selected != null) _react(selected);
          },
          // Figma's Like control (`Group 1739329635`) puts the glyph on a
          // 24px `#E4E4E4` disc, but that background is **deliberately
          // dropped** — the bare icon reads cleaner on the white card. The
          // 24px box is kept as the tap target. Still no text label: there
          // is no "Like" text node anywhere in the file. Once a different
          // reaction is picked we show that instead, which Figma doesn't
          // specify but the picker implies.
          child: SizedBox(
            height: 24,
            width: 24,
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
          onTap: () =>
              showReactionsSheet(context, reactors: widget.post.reactors),
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
