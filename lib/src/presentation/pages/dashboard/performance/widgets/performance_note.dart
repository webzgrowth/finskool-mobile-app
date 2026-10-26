import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma `Note` (`1554:6581`): a small "i" disc and the assumptions line.
class PerformanceNote extends StatelessWidget {
  const PerformanceNote({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    return Padding(
      padding: const EdgeInsets.fromLTRB(6, 2, 6, 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 16,
            width: 16,
            alignment: Alignment.center,
            margin: const EdgeInsets.only(top: 0),
            decoration: const BoxDecoration(
              color: AppPalette.perfNoteDisc,
              shape: BoxShape.circle,
            ),
            child: Text(
              'i',
              style: type.chip.copyWith(
                color: AppPalette.badgeTeal,
                fontSize: 10,
                fontWeight: FontWeight.w700,
                height: 1,
              ),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(child: Text(text, style: type.note)),
        ],
      ),
    );
  }
}
