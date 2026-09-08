import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';

/// Placeholder filter chips — no filter-panel design was provided, so
/// these guessed options are wired fully to [FeedFilterBloc] and are
/// expected to be restyled once a real design exists (see CLAUDE.md).
const _placeholderFilters = ['Stocks', 'Videos', 'Buy calls', 'Sell calls'];

Future<void> showFeedFilterSheet(BuildContext context) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const _FeedFilterSheet(),
  );
}

class _FeedFilterSheet extends StatelessWidget {
  const _FeedFilterSheet();

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final tt = Theme.of(context).textTheme;
    final bloc = context.read<FeedFilterBloc>();
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: cs.surface, borderRadius: AppRadii.sheet),
      child: SafeArea(
        top: false,
        child: BlocBuilder<FeedFilterBloc, FeedFilterState>(
          builder: (context, state) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Filter posts', style: tt.headlineSmall),
                const SizedBox(height: AppSpacing.lg),
                Wrap(
                  spacing: AppSpacing.sm,
                  runSpacing: AppSpacing.sm,
                  children: _placeholderFilters.map((f) {
                    final selected = state.activeFilterIds.contains(f);
                    return FilterChip(
                      label: Text(f),
                      selected: selected,
                      onSelected: (_) =>
                          bloc.add(FeedFilterEvent.filterToggled(f)),
                    );
                  }).toList(),
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            );
          },
        ),
      ),
    );
  }
}
