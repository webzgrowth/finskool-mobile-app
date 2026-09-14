import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';
import 'reaction_tab.dart';
import 'reactor_list_tile.dart';

/// Who reacted, filterable by reaction. Measured from Figma's sheet in
/// frame `605:16036`: 486/852 of the screen, white, 10px top corners, an
/// 82x5 near-black handle, an 18px semibold title, then the underlined tab
/// row over a `#D9D9D9` rule.
Future<void> showReactionsSheet(
  BuildContext context, {
  required List<ReactorModel> reactors,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => _ReactionsSheet(reactors: reactors),
  );
}

class _ReactionsSheet extends StatefulWidget {
  const _ReactionsSheet({required this.reactors});

  final List<ReactorModel> reactors;

  @override
  State<_ReactionsSheet> createState() => _ReactionsSheetState();
}

class _ReactionsSheetState extends State<_ReactionsSheet> {
  ReactionType? _filter;

  /// Figma: sheet 486 tall on an 852 frame.
  static const double _heightFraction = 486 / 852;

  /// Figma: content inset 13 from each edge.
  static const double _inset = 13;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final type = context.feedType;

    final counts = <ReactionType, int>{};
    for (final r in widget.reactors) {
      counts[r.reaction] = (counts[r.reaction] ?? 0) + 1;
    }
    final visible = _filter == null
        ? widget.reactors
        : widget.reactors.where((r) => r.reaction == _filter).toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * _heightFraction,
      decoration: BoxDecoration(
        color: cs.surface,
        // Figma corner radii are [10, 10, 0, 0] — square at the bottom.
        borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
      ),
      // SafeArea goes around the content, not the whole sheet — wrapping
      // the Container itself shrinks it away from the true bottom edge,
      // leaving the modal scrim visible below it as a "cut off" gap.
      child: SafeArea(
        top: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 8),
            Center(
              child: Container(
                height: 5,
                width: 82,
                decoration: BoxDecoration(
                  color: AppPalette.sheetHandle,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 11),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: _inset),
              child: Text('Reactions', style: type.sheetTitle),
            ),
            const SizedBox(height: 7),
            _TabRow(
              inset: _inset,
              total: widget.reactors.length,
              counts: counts,
              filter: _filter,
              onSelect: (f) => setState(() => _filter = f),
            ),
            Expanded(
              child: visible.isEmpty
                  ? Center(
                      child: Text('No reactions yet', style: type.timestamp))
                  : ListView.builder(
                      padding: const EdgeInsets.only(top: 6),
                      itemCount: visible.length,
                      itemBuilder: (context, i) => ReactorListTile(
                        reactor: visible[i],
                        showDivider: i != visible.length - 1,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The filter row: a full-width rule with the selected tab's teal underline
/// drawn over it. Scrolls horizontally — six reactions plus "All" is wider
/// than Figma's five.
class _TabRow extends StatelessWidget {
  const _TabRow({
    required this.inset,
    required this.total,
    required this.counts,
    required this.filter,
    required this.onSelect,
  });

  final double inset;
  final int total;
  final Map<ReactionType, int> counts;
  final ReactionType? filter;
  final ValueChanged<ReactionType?> onSelect;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // The rule sits behind every tab, inset like the rest of the content.
        Positioned(
          left: inset,
          right: inset,
          bottom: 0,
          child: Container(height: 1, color: AppPalette.tabDivider),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: EdgeInsets.symmetric(horizontal: inset),
          child: Row(
            children: [
              ReactionTab(
                count: total,
                selected: filter == null,
                onTap: () => onSelect(null),
              ),
              // Every reaction gets a tab, including zero-count ones — Figma
              // shows "0" tabs rather than hiding them.
              for (final reaction in ReactionType.values)
                ReactionTab(
                  reaction: reaction,
                  count: counts[reaction] ?? 0,
                  selected: filter == reaction,
                  onTap: () => onSelect(reaction),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
