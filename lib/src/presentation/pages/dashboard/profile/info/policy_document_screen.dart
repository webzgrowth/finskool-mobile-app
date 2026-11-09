import 'package:flutter/material.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/model/profile/profile_info.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';

import 'widgets/info_actions.dart';
import 'widgets/info_blocks.dart';
import 'widgets/info_page.dart';
import 'widgets/policy_blocks.dart';

/// One long compliance text — Disclosures, Investor charter, or the full
/// Terms / Privacy policy — chosen by [kind]. Content is
/// `ProfileInfoRepository.policy`, so every document shares this one screen.
class PolicyDocumentScreen extends StatelessWidget {
  const PolicyDocumentScreen({super.key, required this.kind});

  final PolicyKind kind;

  @override
  Widget build(BuildContext context) {
    final repo = locator<ProfileInfoRepository>();
    final doc = repo.policy(kind);
    final email = repo.sebi.email;
    return InfoPage(
      title: doc.title,
      subtitle: doc.subtitle,
      children: [
        PolicyBlocks(blocks: doc.blocks),
        const SizedBox(height: 22),
        InfoPlate(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InfoRow(
            icon: 'assets/icons/info_mail.svg',
            title: 'Questions about this document?',
            subtitle: email,
            onTap: () => openExternal(context, 'mailto:$email'),
          ),
        ),
      ],
    );
  }
}
