import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Plan Details", "Personal Details", "Attachments", "Ticket Overview"…: a
/// 35px `#108B8B` header over a `#F6F6F6` body, r10, with a hairline teal edge
/// and a soft shadow on the body — the one section-card shape in the Final
/// design, shared by Subscription Detail, Edit Profile and the ticket screens.
///
/// [trailing] puts an action or hint in the header (Edit Profile's pencil, a
/// ticket card's "Optional").
class TealSectionCard extends StatelessWidget {
  const TealSectionCard({
    super.key,
    required this.title,
    required this.child,
    this.trailing,
    this.padding = const EdgeInsets.all(12),
  });

  final String title;
  final Widget child;
  final Widget? trailing;
  final EdgeInsetsGeometry padding;

  static const _teal = AppPalette.badgeTeal;
  static const _radius = 10.0;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
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
                Expanded(child: Text(title, style: type.sectionTitle)),
                ?trailing,
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
