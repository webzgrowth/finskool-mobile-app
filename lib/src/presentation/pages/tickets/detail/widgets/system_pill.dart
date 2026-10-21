import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Status changed to In progress" / "Marked as resolved by Support team" —
/// the centred `#7D7D91`-at-20% pill between messages.
class SystemPill extends StatelessWidget {
  const SystemPill(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
        decoration: BoxDecoration(
          color: AppPalette.ticketSystemSurface,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(text, style: context.ticketType.systemPill),
      ),
    );
  }
}
