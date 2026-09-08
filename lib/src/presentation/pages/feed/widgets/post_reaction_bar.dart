import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'reaction_picker_overlay.dart';
import 'reactions_bottom_sheet.dart';
import 'reactor_avatar_stack.dart';

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
    context
        .read<FeedBloc>()
        .add(FeedEvent.reactToPost(postId: widget.post.id, reaction: reaction));
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final current = widget.post.currentUserReaction;
    return Row(
      children: [
        GestureDetector(
          key: _buttonKey,
          onTap: () => current == null
              ? _react(ReactionType.like)
              : context
                  .read<FeedBloc>()
                  .add(FeedEvent.removeReaction(postId: widget.post.id)),
          onLongPressStart: (_) => _picker.show(context, _anchor()),
          onLongPressMoveUpdate: (d) => _picker.updateHover(d.globalPosition),
          onLongPressEnd: (_) {
            final selected = _picker.hide();
            if (selected != null) _react(selected);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(current?.emoji ?? '👍',
                  style: TextStyle(
                      fontSize: 18,
                      color: current == null ? cs.onSurfaceVariant : null)),
              const SizedBox(width: AppSpacing.xs),
              Text(current?.label ?? 'Like',
                  style: tt.labelLarge?.copyWith(
                      color: current == null ? cs.onSurfaceVariant : cs.primary)),
            ],
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () => showReactionsSheet(context, reactors: widget.post.reactors),
          child: Row(
            children: [
              ReactorAvatarStack(reactors: widget.post.reactors),
              const SizedBox(width: AppSpacing.xs),
              Text('${widget.post.totalReactions}', style: tt.labelLarge),
            ],
          ),
        ),
      ],
    );
  }
}
