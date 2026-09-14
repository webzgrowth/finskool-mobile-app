import 'package:flutter/material.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'reaction_picker_row.dart';

/// Drives the long-press reaction popup: which icon is hovered while the
/// finger drags is transient gesture state, not app state, so it's kept
/// here as plain fields — not a bloc (see CLAUDE.md's "Bloc granularity"
/// note). Owned as a field on [PostReactionBar]'s state.
///
/// Geometry is taken from Figma's `Picker` frame (`605:17127`): a 235x39
/// pill, six 27.87px items on a 36px pitch, 15px glyphs, 13.9/5.7 padding.
class ReactionPickerOverlay {
  /// Pill height (Figma: 39).
  static const double pillHeight = 39;

  /// Tap/drag extent of one reaction (Figma: 27.870969…).
  static const double itemExtent = 27.87;

  /// Distance between item origins — item extent plus the 8.13px gap.
  static const double pitch = 36;

  /// Inset before the first item and after the last (Figma: 13.908997…).
  static const double padH = 13.9;

  /// Emoji glyph size (Figma: the text nodes are 15x15).
  static const double glyphSize = 15;

  /// Hairline border (Figma strokeWeight 0.3767).
  static const double borderWidth = 0.38;

  /// 235 in Figma: 13.9 + 27.87 + 5 * 36 + 13.9, plus the border.
  ///
  /// The border has to be counted: Flutter's [Border] is drawn *inside* the
  /// box, so leaving it out made the row 0.76px wider than its own content
  /// box and tripped a RenderFlex overflow.
  static double get pillWidth =>
      padH * 2 +
      borderWidth * 2 +
      itemExtent +
      (ReactionType.values.length - 1) * pitch;

  final reactions = ReactionType.values;
  final ValueNotifier<int?> hoveredIndex = ValueNotifier(null);

  OverlayEntry? _entry;
  Rect _bounds = Rect.zero;

  void show(BuildContext context, Offset anchorTopCenter) {
    hide();
    final width = pillWidth;
    final screenWidth = MediaQuery.sizeOf(context).width;
    final left =
        (anchorTopCenter.dx - width / 2).clamp(8.0, screenWidth - width - 8);
    final top = anchorTopCenter.dy - pillHeight - 16;
    _bounds = Rect.fromLTWH(left, top, width, pillHeight);
    _entry = OverlayEntry(
      builder: (_) => Positioned(
        left: left,
        top: top,
        child: ReactionPickerRow(
          reactions: reactions,
          hoveredIndex: hoveredIndex,
        ),
      ),
    );
    Overlay.of(context, rootOverlay: true).insert(_entry!);
  }

  void updateHover(Offset globalPosition) {
    if (_entry == null) return;
    // Vertical slop: at 39px tall the pill is easy to drag out of, and
    // leaving it vertically shouldn't clear a selection the user is still
    // scrubbing along — only horizontal misses count as "off the picker".
    final withinRow = globalPosition.dx >= _bounds.left &&
        globalPosition.dx <= _bounds.right &&
        (globalPosition.dy - _bounds.center.dy).abs() <= pillHeight * 1.5;
    if (!withinRow) {
      hoveredIndex.value = null;
      return;
    }
    final relativeX = globalPosition.dx - _bounds.left - padH;
    final index =
        (relativeX / pitch).floor().clamp(0, reactions.length - 1);
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
