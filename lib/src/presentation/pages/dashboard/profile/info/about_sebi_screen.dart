import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/info_actions.dart';
import 'widgets/info_blocks.dart';
import 'widgets/info_page.dart';
import 'widgets/sebi_hero_card.dart';

/// Profile → About & SEBI info — Final page `1554:8149`. Content is the
/// placeholder in `ProfileInfoDemoDatasource`, behind the repository.
class AboutSebiScreen extends StatelessWidget {
  const AboutSebiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final info = locator<ProfileInfoRepository>().sebi;
    final type = context.infoType;
    return InfoPage(
      title: 'About & SEBI info',
      subtitle: 'Registration, research, disclaimer',
      children: [
        SebiHeroCard(info: info),
        const InfoSectionLabel('About us'),
        InfoPlate(
          padding: const EdgeInsets.all(16),
          child: Text(info.about, style: type.body),
        ),
        const InfoSectionLabel('Contact & office'),
        InfoPlate(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InfoRow(
                icon: 'assets/icons/info_call.svg',
                title: 'Call us',
                subtitle: info.phone,
                onTap: () => openExternal(
                  context,
                  'tel:${info.phone.replaceAll(' ', '')}',
                ),
              ),
              const InfoHairline(),
              InfoRow(
                icon: 'assets/icons/info_mail.svg',
                title: 'Email us',
                subtitle: info.email,
                onTap: () => openExternal(context, 'mailto:${info.email}'),
              ),
              const InfoHairline(),
              InfoRow(
                icon: 'assets/icons/info_pin.svg',
                title: 'Office address',
                subtitle: info.address,
                extra: Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: GestureDetector(
                    onTap: () => openExternal(context, info.mapsUrl),
                    child: Text('Get directions →', style: type.link),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 22),
        _Disclaimer(paragraphs: info.disclaimer),
      ],
    );
  }
}

class _Disclaimer extends StatelessWidget {
  const _Disclaimer({required this.paragraphs});

  final List<String> paragraphs;

  @override
  Widget build(BuildContext context) {
    final type = context.infoType;
    return InfoPlate(
      color: AppPalette.infoDisclaimerPlate,
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/icons/info_disclaimer.svg',
                height: 16,
                width: 16,
              ),
              const SizedBox(width: 8),
              Text('Disclaimer', style: type.disclaimerHead),
            ],
          ),
          for (final p in paragraphs) ...[
            const SizedBox(height: 10),
            Text(p, style: type.disclaimerBody),
          ],
        ],
      ),
    );
  }
}
