import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "10 New Announcements" — shown only when a community has unread posts.
///
/// Figma (`750:1147`): 18 high, radius 20, green text on the same green at
/// 10%, padded 8 left / 10 right.
class AnnouncementTag extends StatelessWidget {
  const AnnouncementTag({super.key, this.count = 0, this.label});

  final int count;

  /// Replaces the "N New Announcements" copy — the Services card reuses this
  /// pill for "Pricing on request".
  final String? label;

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
          label ?? '$count New Announcement${count == 1 ? '' : 's'}',
          style: context.communityType.announcement,
        ),
      ),
    );
  }
}
