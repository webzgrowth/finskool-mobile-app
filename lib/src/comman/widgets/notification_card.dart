import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The OS-style notification card from Figma (`1629:2230`): a white r22 card
/// with a soft teal shadow, the 38px app icon, "FINSKOOL21" and the time on
/// one line, a semibold title (up to two lines) and a two-line body.
///
/// Shared by the in-app banner (which drops from the top) and the inbox rows,
/// so the two can never drift apart. [unread] draws a small teal dot on the
/// icon — the inbox's only addition to the design.
class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.title,
    required this.body,
    required this.time,
    this.unread = false,
    this.onTap,
  });

  final String title;
  final String body;
  final String time;
  final bool unread;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.notificationType;
    return Material(
      color: AppPalette.white,
      borderRadius: BorderRadius.circular(22),
      elevation: 0,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [
              BoxShadow(
                color: AppPalette.notificationShadow,
                offset: Offset(0, 8),
                blurRadius: 24,
              ),
            ],
          ),
          padding: const EdgeInsets.fromLTRB(12, 12, 14, 13),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AppIcon(unread: unread),
              const SizedBox(width: 11),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text('FINSKOOL21', style: type.appName),
                        ),
                        Text(time, style: type.time),
                      ],
                    ),
                    const SizedBox(height: 2),
                    Text(
                      title,
                      style: type.title,
                      // Up to three lines: "New announcement in Investor Community"
                      // is longer than one, and the community name is the
                      // part that got cut.
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 1),
                    Text(
                      body,
                      style: type.body,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppIcon extends StatelessWidget {
  const _AppIcon({required this.unread});

  final bool unread;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      width: 38,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            decoration: BoxDecoration(
              color: AppPalette.white,
              borderRadius: BorderRadius.circular(9),
              border: Border.all(color: AppPalette.notificationIconRule),
            ),
            padding: const EdgeInsets.all(5),
            child: Image.asset('assets/images/logo.png', fit: BoxFit.contain),
          ),
          if (unread)
            Positioned(
              top: -3,
              left: -3,
              child: Container(
                height: 10,
                width: 10,
                decoration: BoxDecoration(
                  color: AppPalette.badgeTeal,
                  shape: BoxShape.circle,
                  border: Border.all(color: AppPalette.white, width: 1.5),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
