import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show HapticFeedback;
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

  /// The root `Overlay`'s own `RenderBox`, kept for the life of one picker so
  /// [updateHover] can convert drag points into the same coordinate space
  /// [show] positioned the pill in. See the comment there for why that
  /// conversion exists at all.
  RenderBox? _overlayBox;

  void show(BuildContext context, Offset anchorTopCenter) {
    hide();
    // The open itself is the one haptic every long-press reaction picker in
    // the wild gives (Facebook, Instagram, WhatsApp) — without it the popup
    // can appear and still feel like nothing happened.
    HapticFeedback.mediumImpact();

    final overlayState = Overlay.of(context, rootOverlay: true);
    final overlayBox = overlayState.context.findRenderObject()! as RenderBox;
    _overlayBox = overlayBox;

    // `UiScaler` (CLAUDE.md "Design system" — see `comman/design_metrics.dart`)
    // renders the whole app inside a `Transform.scale`, including this very
    // `Overlay`. `anchorTopCenter` is a **true screen pixel** position (from
    // `RenderBox.localToGlobal`, which already accounts for that transform),
    // but `Positioned` inside the overlay is read in the overlay's own
    // *pre-scale* local space — so feeding it true screen pixels applied the
    // scale a second time on the way to the screen, landing the pill well
    // past where it should sit (reliably *below* the button rather than
    // above it, since everything here is positive and the scale only ever
    // grows it). `globalToLocal` undoes exactly that transform, whatever its
    // factor, rather than this file needing to know the scale itself.
    final anchor = overlayBox.globalToLocal(anchorTopCenter);

    final width = pillWidth;
    final screenWidth = overlayBox.size.width;
    final left = (anchor.dx - width / 2).clamp(8.0, screenWidth - width - 8);
    final top = anchor.dy - pillHeight - 16;
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
    overlayState.insert(_entry!);
  }

  void updateHover(Offset globalPosition) {
    final overlayBox = _overlayBox;
    if (_entry == null || overlayBox == null) return;
    // Drag callbacks report true screen pixels too — same conversion as the
    // anchor in `show`, so it's compared against `_bounds` in the same space.
    final position = overlayBox.globalToLocal(globalPosition);
    // Vertical slop: at 39px tall the pill is easy to drag out of, and
    // leaving it vertically shouldn't clear a selection the user is still
    // scrubbing along — only horizontal misses count as "off the picker".
    final withinRow =
        position.dx >= _bounds.left &&
        position.dx <= _bounds.right &&
        (position.dy - _bounds.center.dy).abs() <= pillHeight * 1.5;
    if (!withinRow) {
      hoveredIndex.value = null;
      return;
    }
    final relativeX = position.dx - _bounds.left - padH;
    final index = (relativeX / pitch).floor().clamp(0, reactions.length - 1);
    // A tick per *landed-on* emoji, not per pixel dragged — this is what
    // reads as "scrubbing across options" rather than one long buzz.
    if (index != hoveredIndex.value) HapticFeedback.selectionClick();
    hoveredIndex.value = index;
  }

  /// Removes the popup, returning the hovered reaction (if any) so the
  /// caller can dispatch it.
  ReactionType? hide() {
    final selected = hoveredIndex.value == null
        ? null
        : reactions[hoveredIndex.value!];
    _entry?.remove();
    _entry = null;
    _overlayBox = null;
    hoveredIndex.value = null;
    return selected;
  }

  void dispose() => hoveredIndex.dispose();
}
