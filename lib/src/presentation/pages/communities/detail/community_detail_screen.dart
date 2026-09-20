import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Where "Enter Community" lands.
///
/// **Figma has no design for the inside of a community**, so this is a
/// deliberate placeholder rather than invented UI — it exists so the button
/// works and the route is real. Replace the body when a design lands; the
/// route and navigation are already wired.
class CommunityDetailScreen extends StatelessWidget {
  const CommunityDetailScreen({super.key, required this.communityName});

  final String communityName;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      backgroundColor: cs.surfaceContainer,
      appBar: AppBar(
        title: Text(communityName),
        leading: BackButton(onPressed: () => context.pop()),
      ),
      body: Center(
        child: Padding(
          padding: AppSpacing.screen,
          child: Text(
            'Posts for $communityName will appear here.',
            textAlign: TextAlign.center,
            style: context.communityType.description,
          ),
        ),
      ),
    );
  }
}
