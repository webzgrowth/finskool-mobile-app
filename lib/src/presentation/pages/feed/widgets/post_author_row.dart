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
    final type = context.feedType;
    return Row(
      children: [
        // 35px, not Material's 40: Figma's avatar is `Ellipse 1702`, 35x35.
        CircleAvatar(
          radius: 17.5,
          backgroundColor: Theme.of(context)
              .colorScheme
              .surfaceContainerHighest,
          child: avatarUrl == null
              ? Text(initialsFor(name), style: type.authorName)
              : ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: avatarUrl!,
                    height: 35,
                    width: 35,
                    fit: BoxFit.cover,
                  ),
                ),
        ),
        const SizedBox(width: 14.5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: type.authorName),
            Text(_timeLabel, style: type.timestamp),
          ],
        ),
      ],
    );
  }
}
