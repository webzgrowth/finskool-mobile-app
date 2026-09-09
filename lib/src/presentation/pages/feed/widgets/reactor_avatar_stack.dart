import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';

/// Small overlapping avatar stack next to the reaction count.
class ReactorAvatarStack extends StatelessWidget {
  const ReactorAvatarStack({super.key, required this.reactors});

  final List<ReactorModel> reactors;

  @override
  Widget build(BuildContext context) {
    final visible = reactors.take(3).toList();
    if (visible.isEmpty) return const SizedBox.shrink();
    return SizedBox(
      width: 16 + (visible.length - 1) * 12,
      height: 20,
      child: Stack(
        children: List.generate(visible.length, (i) {
          return Positioned(
            left: i * 12.0,
            child: CircleAvatar(
              radius: 10,
              backgroundColor: Colors.white,
              child: CircleAvatar(
                radius: 9,
                backgroundImage:
                    CachedNetworkImageProvider(visible[i].avatarUrl),
              ),
            ),
          );
        }),
      ),
    );
  }
}
