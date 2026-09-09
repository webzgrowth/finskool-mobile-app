import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'post_author_row.dart';
import 'post_media_carousel.dart';
import 'post_reaction_bar.dart';
import 'hashtag_chip.dart';

class FeedPostCard extends StatelessWidget {
  const FeedPostCard({super.key, required this.post});

  final FeedPostModel post;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(
          left: AppSpacing.lg, right: AppSpacing.lg, bottom: AppSpacing.lg),
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: cs.surface,
        borderRadius: AppRadii.large,
        border: Border.all(color: cs.outlineVariant),
        boxShadow: [
          BoxShadow(
            color: cs.secondary.withValues(alpha: 0.06),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostAuthorRow(
            name: post.authorName,
            avatarUrl: post.authorAvatarUrl,
            postedAt: post.postedAt,
          ),
          const SizedBox(height: AppSpacing.md),
          Text(post.title, style: tt.titleLarge),
          const SizedBox(height: AppSpacing.xs),
          Text(post.body, style: tt.bodyMedium?.copyWith(color: cs.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          PostMediaCarousel(media: post.media),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.xs,
            children: post.hashtags.map((h) => HashtagChip(text: h)).toList(),
          ),
          const SizedBox(height: AppSpacing.md),
          Divider(height: 1, color: cs.outlineVariant),
          const SizedBox(height: AppSpacing.sm),
          PostReactionBar(post: post),
        ],
      ),
    );
  }
}
