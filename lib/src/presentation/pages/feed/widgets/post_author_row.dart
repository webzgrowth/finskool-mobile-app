import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/comman/initials.dart';
import 'package:finskool/src/comman/ist_time.dart';
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

  /// Nullable — the API's `authorAvatarUrl` often is. Falls back to initials
  /// rather than firing a request that's guaranteed to 404.
  final String? avatarUrl;
  final DateTime postedAt;

  /// Both sides are converted to IST before anything is read off them. The
  /// API sends UTC, so formatting `postedAt` raw printed UTC — and comparing
  /// it against a local `DateTime.now()` decided "Today" across two
  /// different timezones. See `comman/ist_time.dart`.
  String get _timeLabel {
    final time = formatIst(postedAt, 'h:mm a');
    if (isTodayIst(postedAt)) return 'Today, $time';
    return '${formatIst(postedAt, 'MMM d')}, $time';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundColor: cs.surfaceContainerHighest,
          child: avatarUrl == null
              ? Text(initialsFor(name), style: context.feedType.authorName)
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl!,
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
            Text(name, style: context.feedType.authorName),
            Text(_timeLabel, style: context.feedType.timestamp),
          ],
        ),
      ],
    );
  }
}
