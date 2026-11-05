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
    this.pinned = false,
  });

  final String name;

  /// Nullable — the API's `authorAvatarUrl` often is. Falls back to initials
  /// rather than firing a request that's guaranteed to 404.
  final String? avatarUrl;
  final DateTime postedAt;

  /// The post carries a `pinOrder`: a "Pinned" tag sits at the far end of the
  /// row. Not in Figma — built from the card's own tokens; flag for the designer.
  final bool pinned;

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
        if (pinned) ...[const Spacer(), _PinnedTag(style: type.timestamp)],
      ],
    );
  }
}

/// A small teal "Pinned" tag: the push-pin glyph and the word on a pale plate.
class _PinnedTag extends StatelessWidget {
  const _PinnedTag({required this.style});

  final TextStyle style;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppPalette.infoVerifiedPlate,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.push_pin_rounded,
            size: 11,
            color: AppPalette.badgeTeal,
          ),
          const SizedBox(width: 4),
          Text('Pinned', style: style.copyWith(color: AppPalette.badgeTeal)),
        ],
      ),
    );
  }
}
