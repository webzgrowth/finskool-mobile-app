import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/repository/profile_info_repository.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'widgets/faq_list.dart';
import 'widgets/info_actions.dart';
import 'widgets/info_blocks.dart';
import 'widgets/info_page.dart';

/// Profile → Help & support. **Not drawn in Figma** — built on the same chrome
/// and blocks as About & SEBI info (hero, `#F6F6F6` plates, 36px icon tiles),
/// so the designer can restyle it without a different structure to unpick.
/// FAQs and contact details are placeholders in `ProfileInfoDemoDatasource`.
class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final help = locator<ProfileInfoRepository>().help;
    return InfoPage(
      title: 'Help & support',
      subtitle: 'FAQs and contact',
      children: [
        InfoPlate(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InfoRow(
                icon: 'assets/icons/profile_tickets.svg',
                iconTint: AppPalette.badgeTeal,
                title: 'My tickets',
                subtitle: 'Track your queries',
                onTap: () => context.push(AppRoutes.SUPPORT_TICKETS_ROUTE_PATH),
              ),
              const InfoHairline(),
              InfoRow(
                icon: 'assets/icons/profile_support.svg',
                iconTint: AppPalette.badgeTeal,
                title: 'Raise a ticket',
                subtitle: 'Our team replies in the chat',
                onTap: () => context.push(AppRoutes.TICKET_NEW_ROUTE_PATH),
              ),
            ],
          ),
        ),
        const InfoSectionLabel('Frequently asked'),
        FaqList(faqs: help.faqs),
        const InfoSectionLabel('Contact us'),
        InfoPlate(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            children: [
              InfoRow(
                icon: 'assets/icons/info_call.svg',
                title: 'Call us',
                subtitle: help.phone,
                onTap: () => openExternal(
                  context,
                  'tel:${help.phone.replaceAll(' ', '')}',
                ),
              ),
              const InfoHairline(),
              InfoRow(
                icon: 'assets/icons/info_mail.svg',
                title: 'Email us',
                subtitle: help.email,
                onTap: () => openExternal(context, 'mailto:${help.email}'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 10),
        Center(child: Text(help.hours, style: context.infoType.metaLabel)),
        const SizedBox(height: 22),
        TicketButton(
          label: 'Raise a ticket',
          onTap: () => context.push(AppRoutes.TICKET_NEW_ROUTE_PATH),
        ),
      ],
    );
  }
}
