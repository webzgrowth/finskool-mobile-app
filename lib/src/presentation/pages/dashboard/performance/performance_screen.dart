import 'package:flutter/material.dart';

/// A community's performance. Pushed from the community card's "Performance"
/// button — it used to be a bottom-bar tab. No design provided yet, so it is a
/// placeholder with a way back.
class PerformanceScreen extends StatelessWidget {
  const PerformanceScreen({super.key, this.communityName});

  final String? communityName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(communityName ?? 'Performance')),
      body: const Center(child: Text('Performance — coming soon')),
    );
  }
}
