import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "10 New Announcements" — shown only when a community has unread posts.
///
/// Figma (`750:1147`): 18 high, radius 20, green text on the same green at
/// 10%, padded 8 left / 10 right.
class AnnouncementTag extends StatelessWidget {
  const AnnouncementTag({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: const EdgeInsets.only(left: 8, right: 10),
      decoration: BoxDecoration(
        color: AppPalette.announcementGreen.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      // See CommunityTagChip: `Container.alignment` would expand this to
      // the row's full remaining width.
      child: Center(
        widthFactor: 1,
        child: Text(
          '$count New Announcement${count == 1 ? '' : 's'}',
          style: context.communityType.announcement,
        ),
      ),
    );
  }
}
