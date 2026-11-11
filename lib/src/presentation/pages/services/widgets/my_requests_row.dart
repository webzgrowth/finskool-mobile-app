import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "My requests" — the way into the member's service requests, now that the
/// Services bell is the same notification bell as on every other tab (it used
/// to open this list and carry *its* unread count, which is why Services showed
/// a different badge from Feed and Communities).
///
/// [unread] is the requests' own unread count, shown as a small pill; zero
/// hides it.
class MyRequestsRow extends StatelessWidget {
  const MyRequestsRow({super.key, required this.unread, required this.onTap});

  final int unread;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.communityType;
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        0,
        AppSpacing.lg,
        AppSpacing.lg,
      ),
      child: Material(
        color: context.gradients.feedCard,
        borderRadius: BorderRadius.circular(AppRadii.lg),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              children: [
                Icon(
                  Icons.chat_bubble_outline_rounded,
                  size: 18,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text('My requests', style: type.title)),
                if (unread > 0) ...[
                  Container(
                    constraints: const BoxConstraints(minWidth: 20),
                    height: 20,
                    padding: const EdgeInsets.symmetric(horizontal: 6),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppPalette.ticketRequired,
                      borderRadius: BorderRadius.circular(AppRadii.pill),
                    ),
                    child: Text(
                      unread > 99 ? '99+' : '$unread',
                      style: context.profileType.badge,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                ],
                Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
