import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'info_actions.dart';
import 'info_blocks.dart';

/// Draws a [PolicyDocument]'s blocks in order, in the same type the Terms
/// screen uses: a Manrope heading, Inter body, teal bullets and hairlines
/// above each major part.
class PolicyBlocks extends StatelessWidget {
  const PolicyBlocks({super.key, required this.blocks});

  final List<PolicyBlock> blocks;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    final children = <Widget>[];
    for (var i = 0; i < blocks.length; i++) {
      final block = blocks[i];
      final top = i == 0 ? 0.0 : _gapBefore(block);
      children.add(
        Padding(
          padding: EdgeInsets.only(top: top),
          child: switch (block) {
            PolicyHeading() => Text(block.text, style: type.articleTitle),
            PolicyLabel() => Text(
              block.text,
              style: type.articleBody.copyWith(fontWeight: FontWeight.w600),
            ),
            PolicyParagraph() => Text(block.text, style: type.articleBody),
            PolicyBullets() => _Bullets(items: block.items),
            PolicyLinks() => _Links(links: block.links),
          },
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

  static double _gapBefore(PolicyBlock b) => switch (b) {
    PolicyHeading() => 26,
    PolicyLabel() => 16,
    _ => 8,
  };
}

class _Bullets extends StatelessWidget {
  const _Bullets({required this.items});

  final List<String> items;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (final item in items)
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 7, right: 10),
                  child: Container(
                    width: 5,
                    height: 5,
                    decoration: const BoxDecoration(
                      color: AppPalette.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Expanded(child: Text(item, style: type.articleBody)),
              ],
            ),
          ),
      ],
    );
  }
}

class _Links extends StatelessWidget {
  const _Links({required this.links});

  final List<InfoDocument> links;

  @override
  Widget build(BuildContext context) {
    return InfoPlate(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          for (var i = 0; i < links.length; i++) ...[
            if (i > 0) const InfoHairline(),
            InfoRow(
              icon: 'assets/icons/info_doc.svg',
              title: links[i].title,
              onTap: () => openExternal(context, links[i].url!),
            ),
          ],
        ],
      ),
    );
  }
}
