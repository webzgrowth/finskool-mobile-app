import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'info_blocks.dart';

/// "Last updated 1 Oct 2026 ··· 6 min read" and the numbered sections under
/// it — a teal `01`, a Manrope heading, a body, hairlines between.
class LegalArticle extends StatelessWidget {
  const LegalArticle({super.key, required this.document});

  final LegalDocument document;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text('Last updated  ', style: type.metaLabel),
            Text(document.lastUpdated, style: type.metaValue),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 3),
              decoration: BoxDecoration(
                color: AppPalette.ticketCard,
                borderRadius: BorderRadius.circular(AppRadii.pill),
              ),
              child: Text('${document.minutes} min read', style: type.chip),
            ),
          ],
        ),
        const SizedBox(height: 20),
        for (var i = 0; i < document.sections.length; i++) ...[
          if (i > 0) ...[
            const SizedBox(height: 18),
            const InfoHairline(),
            const SizedBox(height: 18),
          ],
          Text((i + 1).toString().padLeft(2, '0'), style: type.articleNo),
          const SizedBox(height: 3),
          Text(document.sections[i].title, style: type.articleTitle),
          const SizedBox(height: 6),
          Text(document.sections[i].body, style: type.articleBody),
        ],
      ],
    );
  }
}
