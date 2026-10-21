import 'package:flutter/material.dart';

import '../text/text_style_factory.dart';
import '../tokens/app_palette.dart';

/// Figma specifies **no letter-spacing** on these styles, but a bare
/// `inter()` / `manrope()` leaves the field unset, so a `Text` inherits it
/// from the ambient `DefaultTextStyle`. `ThemeData` merges the app's text
/// theme over Material's defaults, which is where `letterSpacing: 0.25` leaks
/// back in — +0.25pt on every glyph, enough to wrap a 301pt line Figma fits on
/// one. Pinned to 0 here, for tickets only: the other screens were matched
/// with the inherited value and are left as they were.
TextStyle _i(double size, double weight, double height, Color color) => inter(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

TextStyle _m(double size, double weight, double height, Color color) => manrope(
  size: size,
  weight: weight,
  height: height,
  color: color,
).copyWith(letterSpacing: 0);

/// Support-ticket type scale, read from Figma's **Final** page.
///
/// A separate extension for the same reason `FeedTypography` is: these use
/// sizes the global `TextTheme` doesn't (9, 10.5, 11.5, 12.5), and
/// repurposing `titleMedium` and friends would silently reskin the auth
/// screens, which are pixel-matched to them.
///
/// **`height` is a multiplier**, not pixels: Figma's pixel line-heights are
/// divided by the size (19px on 14pt = 1.357). Where Figma leaves it
/// automatic, the box is the font's own natural one, ≈1.2.
///
/// The subject is **Manrope** on the list card but **Inter** on the summary
/// card — the design really does differ between them.
@immutable
class TicketTypography extends ThemeExtension<TicketTypography> {
  const TicketTypography({
    required this.headerTitle,
    required this.headerSubtitle,
    required this.chip,
    required this.ticketNumber,
    required this.summaryNumber,
    required this.statusPill,
    required this.cardSubject,
    required this.summarySubject,
    required this.meta,
    required this.detailMeta,
    required this.newReply,
    required this.footnote,
    required this.button,
    required this.buttonGhost,
    required this.emptyTitle,
    required this.emptyBody,
    required this.cardHeader,
    required this.cardHint,
    required this.fieldLabel,
    required this.fieldHint,
    required this.fieldValue,
    required this.fieldPlaceholder,
    required this.fieldCounter,
    required this.fieldError,
    required this.uploadTitle,
    required this.uploadHint,
    required this.fileTag,
    required this.fileName,
    required this.fileSize,
    required this.successTitle,
    required this.successSubtitle,
    required this.summaryLabel,
    required this.summaryValue,
    required this.nextTitle,
    required this.nextBody,
    required this.stepBadge,
    required this.stepTitle,
    required this.stepPending,
    required this.stepDate,
    required this.stepCheck,
    required this.pendingRed,
    required this.bubble,
    required this.bubbleCaption,
    required this.systemPill,
    required this.attachmentTag,
    required this.attachmentName,
    required this.avatarInitials,
    required this.loadEarlier,
    required this.replyPlaceholder,
    required this.plusGlyph,
    required this.sendGlyph,
    required this.statusButton,
    required this.feedbackTitle,
    required this.feedbackBody,
    required this.feedbackButton,
  });

  final TextStyle headerTitle;
  final TextStyle headerSubtitle;
  final TextStyle chip;
  final TextStyle ticketNumber;
  final TextStyle summaryNumber;
  final TextStyle statusPill;
  final TextStyle cardSubject;
  final TextStyle summarySubject;
  final TextStyle meta;
  final TextStyle detailMeta;
  final TextStyle newReply;
  final TextStyle footnote;
  final TextStyle button;
  final TextStyle buttonGhost;
  final TextStyle emptyTitle;
  final TextStyle emptyBody;
  final TextStyle cardHeader;
  final TextStyle cardHint;
  final TextStyle fieldLabel;
  final TextStyle fieldHint;
  final TextStyle fieldValue;
  final TextStyle fieldPlaceholder;
  final TextStyle fieldCounter;
  final TextStyle fieldError;
  final TextStyle uploadTitle;
  final TextStyle uploadHint;
  final TextStyle fileTag;
  final TextStyle fileName;
  final TextStyle fileSize;
  final TextStyle successTitle;
  final TextStyle successSubtitle;
  final TextStyle summaryLabel;
  final TextStyle summaryValue;
  final TextStyle nextTitle;
  final TextStyle nextBody;
  final TextStyle stepBadge;
  final TextStyle stepTitle;
  final TextStyle stepPending;
  final TextStyle stepDate;
  final TextStyle stepCheck;
  final TextStyle pendingRed;
  final TextStyle bubble;
  final TextStyle bubbleCaption;
  final TextStyle systemPill;
  final TextStyle attachmentTag;
  final TextStyle attachmentName;
  final TextStyle avatarInitials;
  final TextStyle loadEarlier;
  final TextStyle replyPlaceholder;
  final TextStyle plusGlyph;
  final TextStyle sendGlyph;
  final TextStyle statusButton;
  final TextStyle feedbackTitle;
  final TextStyle feedbackBody;
  final TextStyle feedbackButton;

  static const _ink = AppPalette.ticketInk;
  static const _soft = AppPalette.ticketInkSoft;
  static const _muted = AppPalette.ticketMuted;
  static const _hint = AppPalette.ticketHint;
  static const _teal = AppPalette.badgeTeal;
  static const _white = AppPalette.white;

  /// The screens are drawn on a fixed white sheet, so there is one set of
  /// values and no dark variant to maintain. [of] exists to match the other
  /// typography extensions' call shape.
  static final TicketTypography light = TicketTypography(
    headerTitle: _m(16, 700, 1.375, const Color(0xFF000000)),
    headerSubtitle: _i(10, 400, 1.4, _hint),
    chip: _i(10, 500, 1.2, _soft),
    ticketNumber: _i(11, 500, 1.18, _muted),
    summaryNumber: _i(11, 700, 1.18, _muted),
    statusPill: _i(10.5, 600, 1.238, _ink),
    cardSubject: _m(14, 600, 1.357, _ink),
    summarySubject: _i(14, 600, 1.4286, _ink),
    meta: _i(11, 400, 1.18, _muted),
    detailMeta: _i(11.5, 400, 1.217, _muted),
    newReply: _i(11, 500, 1.18, _teal),
    footnote: _i(10, 400, 1.4, AppPalette.ticketFootnote),
    button: _i(14, 600, 1.4235, _white).copyWith(letterSpacing: 0.2657),
    buttonGhost: _i(14, 500, 1.4235, _hint).copyWith(letterSpacing: 0.2657),
    emptyTitle: _m(20, 700, 1.35, _ink),
    emptyBody: _i(12.5, 400, 1.52, _muted),
    cardHeader: _m(16, 700, 1.375, _white),
    cardHint: _i(10, 400, 1.2, const Color(0xE0FFFFFF)),
    fieldLabel: _m(12, 700, 1.333, _soft),
    fieldHint: _i(10, 400, 1.2, _hint),
    fieldValue: _i(10, 500, 1.4, _soft),
    fieldPlaceholder: _i(10, 500, 1.4, _hint),
    fieldCounter: _i(9, 400, 1.22, _hint),
    fieldError: _i(10, 400, 1.3, AppPalette.ticketRequired),
    uploadTitle: _i(12, 700, 1.25, _teal),
    uploadHint: _i(10, 400, 1.2, _hint),
    fileTag: _m(9, 700, 1.33, _teal),
    fileName: _i(10, 500, 1.2, _soft),
    fileSize: _i(9, 400, 1.22, _hint),
    successTitle: _m(22, 700, 1.364, const Color(0xFF000000)),
    successSubtitle: _i(12.5, 400, 1.2, const Color(0xFF000000)),
    summaryLabel: _i(12, 400, 1.25, _muted),
    summaryValue: _i(12, 600, 1.25, _ink),
    nextTitle: _i(12.5, 600, 1.44, _ink),
    nextBody: _i(11.5, 400, 1.478, _muted),
    stepBadge: _i(11, 700, 1.18, _white),
    stepTitle: _i(10.5, 600, 1.238, _ink),
    stepPending: _i(10.5, 500, 1.238, AppPalette.ticketPlaceholder),
    stepDate: _i(10, 400, 1.2, _muted),
    stepCheck: _i(10, 700, 1.2, _white),
    pendingRed: _i(10, 400, 1.2, AppPalette.ticketPendingRed),
    bubble: _i(12.5, 400, 1.52, _ink),
    bubbleCaption: _i(10.5, 400, 1.238, _muted),
    systemPill: _i(10.5, 500, 1.238, AppPalette.ticketSystemInk),
    attachmentTag: _m(9, 700, 1.33, _white),
    attachmentName: _i(11, 500, 1.18, _white),
    avatarInitials: _i(10, 700, 1.2, _white),
    loadEarlier: _i(11.5, 500, 1.217, _teal),
    replyPlaceholder: _i(13, 400, 1.2, AppPalette.ticketPlaceholder),
    plusGlyph: _i(18, 700, 1.2, AppPalette.reactionRing),
    sendGlyph: _i(16, 700, 1.2, _white),
    statusButton: _i(11, 400, 1.18, _white),
    feedbackTitle: _m(15, 700, 1.333, _ink),
    feedbackBody: _i(11.5, 400, 1.478, _muted),
    feedbackButton: _i(12.5, 600, 1.2, _white),
  );

  static TicketTypography of(Brightness brightness) => light;

  @override
  TicketTypography copyWith() => this;

  @override
  TicketTypography lerp(ThemeExtension<TicketTypography>? other, double t) =>
      this;
}

extension TicketTypographyX on BuildContext {
  TicketTypography get ticketType =>
      Theme.of(this).extension<TicketTypography>()!;
}
