import 'package:flutter/material.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';

import 'widgets/info_actions.dart';
import 'widgets/info_blocks.dart';
import 'widgets/info_page.dart';
import 'widgets/legal_article.dart';
import 'widgets/legal_tabs.dart';

/// Profile → Terms & privacy policy — Final page `1554:8682`. One screen, two
/// texts: the tab switch only chooses which document is drawn, so it is plain
/// `State`, not a bloc (CLAUDE.md "Not everything is a bloc"). [initialTab]
/// lets the About screen's "Privacy policy" row open straight on the second.
class TermsPrivacyScreen extends StatefulWidget {
  const TermsPrivacyScreen({super.key, this.initialTab = 0});

  final int initialTab;

  @override
  State<TermsPrivacyScreen> createState() => _TermsPrivacyScreenState();
}

class _TermsPrivacyScreenState extends State<TermsPrivacyScreen> {
  late int _tab = widget.initialTab;
  final _repo = locator<ProfileInfoRepository>();

  @override
  Widget build(BuildContext context) {
    final docs = [_repo.terms, _repo.privacy];
    final email = _repo.sebi.email;
    return InfoPage(
      title: 'Terms & privacy policy',
      subtitle: 'How we work and use your data',
      children: [
        LegalTabs(
          labels: [for (final d in docs) d.tabLabel],
          selected: _tab,
          onChanged: (i) => setState(() => _tab = i),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 220),
          child: KeyedSubtree(
            key: ValueKey(_tab),
            child: LegalArticle(document: docs[_tab]),
          ),
        ),
        const SizedBox(height: 22),
        InfoPlate(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: InfoRow(
            icon: 'assets/icons/info_mail.svg',
            title: 'Questions about these terms?',
            subtitle: email,
            onTap: () => openExternal(context, 'mailto:$email'),
          ),
        ),
      ],
    );
  }
}
