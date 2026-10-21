import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "No tickets yet": an 88px tile holding Figma's 44px ticket glyph, then
/// the two buttons.
///
/// Gaps are Figma's: tile → title 14, title → body 6, body → button 20,
/// button → ghost button 14. The tile sits 109 below the header (y=184).
class TicketsEmptyView extends StatelessWidget {
  const TicketsEmptyView({
    super.key,
    required this.onRaise,
    required this.onNeedHelp,
  });

  final VoidCallback onRaise;
  final VoidCallback onNeedHelp;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 109, 20, 24),
      child: Column(
        children: [
          Container(
            height: 88,
            width: 88,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppPalette.ticketTile,
              borderRadius: BorderRadius.circular(26.9),
            ),
            child: SvgPicture.asset(
              'assets/icons/ticket_glyph.svg',
              height: 44,
              width: 44,
            ),
          ),
          const SizedBox(height: 14),
          Text('No tickets yet', style: type.emptyTitle),
          const SizedBox(height: 6),
          Text(
            'When you raise a query, it shows up here with its status and '
            'replies from the support team.',
            textAlign: TextAlign.center,
            style: type.emptyBody,
          ),
          const SizedBox(height: 20),
          TicketButton(label: 'Raise a new ticket', onTap: onRaise),
          const SizedBox(height: 14),
          // Figma: "Need help?" — outlined and greyed. It goes to Help &
          // support, the nearest real destination; the earlier "Browse FAQs"
          // had no screen at all.
          TicketButton(
            label: 'Need help?',
            onTap: onNeedHelp,
            ghost: true,
            arrow: false,
          ),
        ],
      ),
    );
  }
}
