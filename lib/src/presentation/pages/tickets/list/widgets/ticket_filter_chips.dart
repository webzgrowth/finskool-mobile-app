import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/presentation/bloc/tickets/list/tickets_list_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "All (4)  Open (1)  In progress (1)  Resolved (2)".
///
/// The counts only appear once **every page is loaded**: the API has no
/// counts endpoint, so with more pages to come a number would silently
/// undercount. Until then the chips read just "All", "Open"… — a label with
/// no number is honest where a wrong one is not.
///
/// Selected is a solid `#108B8B` pill, 22 tall; unselected is `#F6F6F6` with a
/// 1px `#7D7D91` hairline, 23 tall — the 1px difference is Figma's own, and it
/// falls out of the border here.
class TicketFilterChips extends StatelessWidget {
  const TicketFilterChips({
    super.key,
    required this.state,
    required this.onSelect,
  });

  final TicketsListState state;
  final ValueChanged<TicketStatus?> onSelect;

  @override
  Widget build(BuildContext context) {
    final entries = <(String, TicketStatus?)>[
      ('All', null),
      ('Open', TicketStatus.open),
      ('In progress', TicketStatus.inProgress),
      ('Resolved', TicketStatus.resolved),
    ];
    // Scrolls rather than wraps: at a large system font the four chips are
    // wider than the screen, and a clipped chip is worse than a swipe.
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          for (final (label, status) in entries) ...[
            _Chip(
              label: state.countsAreExact
                  ? '$label (${state.countFor(status)})'
                  : label,
              selected: state.filter == status,
              onTap: () => onSelect(status),
            ),
            const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final style = context.ticketType.chip;
    return Semantics(
      button: true,
      selected: selected,
      child: GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          // 12 horizontal / 5 vertical, less the 1px border on the outlined one.
          padding: selected
              ? const EdgeInsets.symmetric(horizontal: 12, vertical: 5)
              : const EdgeInsets.symmetric(horizontal: 11.5, vertical: 4.5),
          decoration: BoxDecoration(
            color: selected ? AppPalette.badgeTeal : AppPalette.ticketCard,
            borderRadius: BorderRadius.circular(20),
            border: selected
                ? null
                : Border.all(color: AppPalette.ticketChipBorder),
          ),
          child: Text(
            label,
            style: selected ? style.copyWith(color: AppPalette.white) : style,
          ),
        ),
      ),
    );
  }
}
