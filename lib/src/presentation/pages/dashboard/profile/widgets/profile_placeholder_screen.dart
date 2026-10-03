import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// Destination for the seven Profile menu rows Figma draws but doesn't
/// design past the row itself (Edit Profile, About & SEBI info, Welcome
/// kits, My tickets, Help & support, Give feedback, Terms & privacy
/// policy). One generic screen rather than seven near-duplicates — same
/// "no design provided" approach as `CommunityDetailScreen`, just factored
/// for reuse since Profile has several such destinations instead of one.
class ProfilePlaceholderScreen extends StatelessWidget {
  const ProfilePlaceholderScreen({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      appBar: AppBar(
        title: Text(title),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: Center(
        child: Text(
          '$title is coming soon.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
