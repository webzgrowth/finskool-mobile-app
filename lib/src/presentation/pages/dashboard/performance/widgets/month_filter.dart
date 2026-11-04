import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import '../performance_format.dart';

/// The month filter, in the shape each board's guide calls for:
///
/// * **intraday** — one picker, "All months" or a month;
/// * **swing / investor** (`range`) — From and To pickers and a ✕ to clear.
///
/// The offered months are [months] — the server's list of months that have
/// trades, newest first — never a made-up calendar. A range is reported only
/// once **both** ends are chosen, and To can never be earlier than From
/// (those months are disabled; moving From past To pulls To up with it).
///
/// A half-chosen range is transient UI, so it lives here and the bloc only ever
/// sees a complete filter. The screen keys this widget by segment, so an
/// investor tab change starts it afresh with the new tab's months.
class MonthFilter extends StatefulWidget {
  const MonthFilter({
    super.key,
    required this.range,
    required this.months,
    required this.filter,
    required this.onChanged,
  });

  final bool range;
  final List<String> months;
  final PerformanceMonthFilter? filter;
  final ValueChanged<PerformanceMonthFilter?> onChanged;

  @override
  State<MonthFilter> createState() => _MonthFilterState();
}

class _MonthFilterState extends State<MonthFilter> {
  late String? _from = widget.filter?.from;
  late String? _to = widget.filter?.to;

  @override
  void didUpdateWidget(MonthFilter old) {
    super.didUpdateWidget(old);
    // Follow the bloc when it changed the filter (a failed change reverts it);
    // a rebuild with the same filter must not undo a half-chosen range.
    if (old.filter != widget.filter) {
      _from = widget.filter?.from;
      _to = widget.filter?.to;
    }
  }

  void _pickMonth(String? month) {
    setState(() => _from = _to = month);
    widget.onChanged(
      month == null ? null : PerformanceMonthFilter.single(month),
    );
  }

  void _pickFrom(String from) {
    setState(() {
      _from = from;
      // Past To? Move To up with it rather than leave an impossible range.
      if (_to != null && from.compareTo(_to!) > 0) _to = from;
    });
    _report();
  }

  void _pickTo(String to) {
    setState(() => _to = to);
    _report();
  }

  void _report() {
    final from = _from, to = _to;
    if (from == null || to == null) return;
    widget.onChanged(PerformanceMonthFilter(from: from, to: to));
  }

  void _clear() {
    final hadFilter = widget.filter != null;
    setState(() => _from = _to = null);
    if (hadFilter) widget.onChanged(null);
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.range) {
      return Row(
        children: [
          _Picker(
            label: 'Month',
            value: _from,
            emptyLabel: 'All months',
            months: widget.months,
            allowClear: true,
            onSelected: _pickMonth,
          ),
        ],
      );
    }
    return Row(
      children: [
        Flexible(
          child: _Picker(
            label: 'From',
            value: _from,
            emptyLabel: 'Select',
            months: widget.months,
            onSelected: (m) => _pickFrom(m!),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: _Picker(
            label: 'To',
            value: _to,
            emptyLabel: 'Select',
            months: widget.months,
            // To can't be before From.
            isDisabled: (m) => _from != null && m.compareTo(_from!) < 0,
            onSelected: (m) => _pickTo(m!),
          ),
        ),
        if (_from != null || _to != null)
          IconButton(
            tooltip: 'Clear filter',
            onPressed: _clear,
            icon: const Icon(Icons.close_rounded, size: 18),
          ),
      ],
    );
  }
}

/// A pill that opens a menu of months. `null` from [onSelected] means
/// "All months" (only offered when [allowClear]).
class _Picker extends StatelessWidget {
  const _Picker({
    required this.label,
    required this.value,
    required this.emptyLabel,
    required this.months,
    required this.onSelected,
    this.allowClear = false,
    this.isDisabled,
  });

  final String label;
  final String? value;
  final String emptyLabel;
  final List<String> months;
  final bool allowClear;
  final bool Function(String month)? isDisabled;
  final ValueChanged<String?> onSelected;

  /// A sentinel: a menu item's value can't be null.
  static const _all = '';

  @override
  Widget build(BuildContext context) {
    final type = context.performanceType;
    final shown = value == null ? emptyLabel : formatMonthLong(value!);
    return PopupMenuButton<String>(
      tooltip: label,
      enabled: months.isNotEmpty,
      onSelected: (m) => onSelected(m == _all ? null : m),
      itemBuilder: (_) => [
        if (allowClear)
          const PopupMenuItem(value: _all, child: Text('All months')),
        for (final m in months)
          PopupMenuItem(
            value: m,
            enabled: !(isDisabled?.call(m) ?? false),
            child: Text(formatMonthLong(m)),
          ),
      ],
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
        decoration: BoxDecoration(
          color: AppPalette.perfChip,
          borderRadius: BorderRadius.circular(999),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Flexible(
              child: Text(
                '$label: $shown',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: type.chip.copyWith(color: AppPalette.perfLabel),
              ),
            ),
            const SizedBox(width: 4),
            const Icon(Icons.expand_more_rounded, size: 18),
          ],
        ),
      ),
    );
  }
}
