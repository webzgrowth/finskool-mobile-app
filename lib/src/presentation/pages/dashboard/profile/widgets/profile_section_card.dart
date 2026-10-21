import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A titled section: an upper-cased 11px Manrope label, 10 below it a
/// `#F6F6F6` card (r16, a hairline `#153D3A0F` border, a soft 14px shadow)
/// holding its rows with 1px dividers inset 48 — past the 36px tile and the
/// 12 gap, so the rule starts under the text. 22 between sections.
class ProfileSectionCard extends StatelessWidget {
  const ProfileSectionCard({
    super.key,
    required this.title,
    required this.rows,
  });

  final String title;
  final List<Widget> rows;

  @override
  Widget build(BuildContext context) {
    if (rows.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.only(bottom: 22),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title.toUpperCase(), style: context.profileType.sectionTitle),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
            decoration: BoxDecoration(
              color: AppPalette.ticketCard,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: AppPalette.ticketCardBorder),
              boxShadow: const [
                BoxShadow(
                  color: AppPalette.ticketShadow,
                  blurRadius: 14,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              children: [
                for (var i = 0; i < rows.length; i++) ...[
                  rows[i],
                  if (i != rows.length - 1)
                    const Padding(
                      padding: EdgeInsets.only(left: 48),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        color: AppPalette.ticketDivider,
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
