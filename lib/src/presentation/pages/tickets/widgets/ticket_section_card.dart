import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Ticket details", "Attachments", "Ticket Overview", "What happens next": a
/// 35px `#108B8B` header over a `#F6F6F6` body, r=10, with a hairline teal edge
/// and a soft shadow on the body.
///
/// Not the shared `TealSectionCard`, which is `primary` (`#1E9299`) with a
/// different body and header metrics — this design's teal is `#108B8B`.
class TicketSectionCard extends StatelessWidget {
  const TicketSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.hint,
    this.padding = const EdgeInsets.all(12),
  });

  final String title;
  final Widget child;

  /// "Optional" — small, right-aligned in the header.
  final String? hint;
  final EdgeInsetsGeometry padding;

  static const _teal = AppPalette.badgeTeal;
  static const _radius = 10.0;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Container(
      decoration: BoxDecoration(
        color: _teal,
        borderRadius: BorderRadius.circular(_radius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 7, 12, 6),
            child: Row(
              children: [
                Expanded(child: Text(title, style: type.cardHeader)),
                if (hint != null) Text(hint!, style: type.cardHint),
              ],
            ),
          ),
          Container(
            padding: padding,
            decoration: BoxDecoration(
              color: AppPalette.ticketCard,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(_radius),
              ),
              border: Border.all(color: _teal, width: 0.75),
              boxShadow: const [
                BoxShadow(
                  color: AppPalette.ticketShadow,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: child,
          ),
        ],
      ),
    );
  }
}
