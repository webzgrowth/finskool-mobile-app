import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// The picker a dropdown opens.
///
/// **Figma draws no picker** — only the closed field — so this is built from
/// the same tokens rather than copied from a frame, and borrows the app's
/// established sheet chrome (the Reactions and country-picker sheets): a
/// transparent route, a white sheet, the 82x5 drag handle. Worth a look from
/// the designer.
Future<T?> showTicketOptionSheet<T>(
  BuildContext context, {
  required String title,
  required List<T> options,
  required String Function(T) labelOf,
  T? selected,
}) {
  return showModalBottomSheet<T>(
    context: context,
    backgroundColor: Colors.transparent,
    isScrollControlled: true,
    builder: (sheetContext) {
      final type = sheetContext.ticketType;
      return Container(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.sizeOf(sheetContext).height * 0.6,
        ),
        decoration: const BoxDecoration(
          color: AppPalette.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 5,
                width: 82,
                decoration: BoxDecoration(
                  color: AppPalette.sheetHandle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(title, style: type.feedbackTitle),
                ),
              ),
              Flexible(
                child: ListView(
                  shrinkWrap: true,
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 16),
                  children: [
                    for (final option in options)
                      _Row(
                        label: labelOf(option),
                        selected: option == selected,
                        onTap: () => Navigator.of(sheetContext).pop(option),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

class _Row extends StatelessWidget {
  const _Row({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        height: 48,
        alignment: Alignment.centerLeft,
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: AppPalette.ticketDivider)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                label,
                style: selected
                    ? type.fieldValue.copyWith(fontWeight: FontWeight.w600)
                    : type.fieldValue,
              ),
            ),
            if (selected) Text('✓', style: type.loadEarlier),
          ],
        ),
      ),
    );
  }
}
