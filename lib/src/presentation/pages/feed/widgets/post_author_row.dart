import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Avatar + author name + timestamp row at the top of a [FeedPostCard].
class PostAuthorRow extends StatelessWidget {
  const PostAuthorRow({
    super.key,
    required this.name,
    required this.avatarUrl,
    required this.postedAt,
  });

  final String name;
  final String avatarUrl;
  final DateTime postedAt;

  String get _timeLabel {
    final now = DateTime.now();
    final sameDay = now.year == postedAt.year &&
        now.month == postedAt.month &&
        now.day == postedAt.day;
    final time = DateFormat('h:mm a').format(postedAt);
    return sameDay ? 'Today, $time' : '${DateFormat('MMM d').format(postedAt)}, $time';
  }

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: cs.surfaceContainerHighest,
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              height: 40,
              width: 40,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: tt.titleMedium?.copyWith(color: cs.secondary)),
            Text(_timeLabel,
                style: tt.bodySmall?.copyWith(color: cs.onSurfaceVariant)),
          ],
        ),
      ],
    );
  }
}
