import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';

/// One row in the Reactions sheet's reactor list.
class ReactorListTile extends StatelessWidget {
  const ReactorListTile({super.key, required this.reactor});

  final ReactorModel reactor;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: CachedNetworkImageProvider(reactor.avatarUrl),
      ),
      title: Text(reactor.name, style: Theme.of(context).textTheme.bodyLarge),
      trailing:
          Text(reactor.reaction.emoji, style: const TextStyle(fontSize: 18)),
    );
  }
}
