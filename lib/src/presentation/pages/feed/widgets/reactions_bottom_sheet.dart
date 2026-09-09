import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';
import 'reaction_filter_chip.dart';
import 'reactor_list_tile.dart';

/// "All (N)" + one tab per reaction type, listing who reacted. Reuses the
/// exact sheet chrome from `country_picker_sheet.dart`.
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

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final counts = <ReactionType, int>{};
    for (final r in widget.reactors) {
      counts[r.reaction] = (counts[r.reaction] ?? 0) + 1;
    }
    final visible = _filter == null
        ? widget.reactors
        : widget.reactors.where((r) => r.reaction == _filter).toList();

    return Container(
      height: MediaQuery.sizeOf(context).height * 0.6,
      decoration: BoxDecoration(color: cs.surface, borderRadius: AppRadii.sheet),
      // SafeArea goes around the content, not the whole sheet — wrapping
      // the Container itself shrinks it away from the true bottom edge,
      // leaving the modal scrim visible below it as a "cut off" gap.
      child: SafeArea(
        top: false,
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.sm),
            Container(
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                  color: cs.outlineVariant, borderRadius: BorderRadius.circular(2)),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text('Reactions', style: tt.headlineSmall),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
              child: Row(
                children: [
                  ReactionFilterChip(
                    label: 'All (${widget.reactors.length})',
                    selected: _filter == null,
                    onTap: () => setState(() => _filter = null),
                  ),
                  for (final entry in counts.entries)
                    ReactionFilterChip(
                      label: '${entry.key.emoji} ${entry.value}',
                      selected: _filter == entry.key,
                      onTap: () => setState(() => _filter = entry.key),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: ListView.builder(
                itemCount: visible.length,
                itemBuilder: (context, i) => ReactorListTile(reactor: visible[i]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
