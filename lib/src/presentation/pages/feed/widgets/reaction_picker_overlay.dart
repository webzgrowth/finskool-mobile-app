import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_picker_row.dart';

/// Drives the long-press reaction popup: which icon is hovered while the
/// finger drags is transient gesture state, not app state, so it's kept
/// here as plain fields — not a bloc (see CLAUDE.md's "Bloc granularity"
/// note). Owned as a field on [PostReactionBar]'s state.
class ReactionPickerOverlay {
  static const double itemSize = 44;
  final reactions = ReactionType.values;
  final ValueNotifier<int?> hoveredIndex = ValueNotifier(null);

  OverlayEntry? _entry;
  Rect _bounds = Rect.zero;

  void show(BuildContext context, Offset anchorTopCenter) {
    hide();
    final width = itemSize * reactions.length;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final left = (anchorTopCenter.dx - width / 2).clamp(8.0, screenWidth - width - 8);
    final top = anchorTopCenter.dy - itemSize - 16;
    _bounds = Rect.fromLTWH(left, top, width, itemSize);
    _entry = OverlayEntry(
      builder: (_) => Positioned(
        left: left,
        top: top,
        child: ReactionPickerRow(
          reactions: reactions,
          hoveredIndex: hoveredIndex,
          itemSize: itemSize,
        ),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  void updateHover(Offset globalPosition) {
    if (_entry == null) return;
    if (!_bounds.contains(globalPosition)) {
      hoveredIndex.value = null;
      return;
    }
    final relativeX = globalPosition.dx - _bounds.left;
    final index = (relativeX / itemSize).floor().clamp(0, reactions.length - 1);
    hoveredIndex.value = index;
  }

  /// Removes the popup, returning the hovered reaction (if any) so the
  /// caller can dispatch it.
  ReactionType? hide() {
    final selected =
        hoveredIndex.value == null ? null : reactions[hoveredIndex.value!];
    _entry?.remove();
    _entry = null;
    hoveredIndex.value = null;
    return selected;
  }

  void dispose() => hoveredIndex.dispose();
}
