import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
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
    final type = context.feedType;
    final hasMedia = post.media.isNotEmpty;
    return Container(
      // Final page `iPhone 16 - 12`: the card is 364 wide at x14, r20, a 1px
      // `#108B8B` edge and a soft 10px shadow, with 10 between cards.
      margin: const EdgeInsets.fromLTRB(14, 0, 14, 10),
      padding: const EdgeInsets.fromLTRB(17, 13, 15, 16),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(20),
        // Figma's `#108B8B` stroke renders as one device pixel of `#A5D3D3`
        // at 2x — a 0.5dp hairline, not a solid teal line.
        border: Border.all(color: AppPalette.feedBorder, width: 0.5),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PostAuthorRow(
            name: post.authorName,
            avatarUrl: post.authorAvatarUrl,
            postedAt: post.postedAt,
          ),
          const SizedBox(height: 12),
          Text(post.title, style: type.title),
          const SizedBox(height: 4.3),
          // `content` is HTML from the admin composer (the spec says
          // Markdown; it isn't) — bodySpans sniffs and renders either.
          Text.rich(
            TextSpan(children: bodySpans(post.body, type.body, type.bodyBold)),
          ),
          if (hasMedia) ...[
            const SizedBox(height: 14.3),
            PostMediaCarousel(media: post.media),
          ],
          if (post.hashtags.isNotEmpty) ...[
            const SizedBox(height: 14),
            Wrap(
              spacing: 4.4,
              runSpacing: 4,
              children: [for (final h in post.hashtags) HashtagChip(text: h)],
            ),
          ],
          const SizedBox(height: 13),
          const Divider(height: 1, thickness: 1, color: AppPalette.feedRule),
          const SizedBox(height: 12),
          PostReactionBar(post: post),
        ],
      ),
    );
  }
}
