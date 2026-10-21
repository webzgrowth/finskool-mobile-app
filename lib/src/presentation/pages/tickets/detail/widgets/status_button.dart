import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The teal "Status" pill pinned top-right of the chat header (74x28, r=14).
class StatusButton extends StatelessWidget {
  const StatusButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Ticket status',
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          height: 28,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(
            color: AppPalette.badgeTeal,
            borderRadius: BorderRadius.circular(14),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(
                'assets/icons/ticket_status_icon.svg',
                height: 12,
                width: 12,
              ),
              const SizedBox(width: 6),
              Text('Status', style: context.ticketType.statusButton),
            ],
          ),
        ),
      ),
    );
  }
}
