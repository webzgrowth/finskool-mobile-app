import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's per-screen header positions, in sheet coordinates.
///
/// The arrow, title and subtitle sit at slightly different offsets on each
/// frame (the list is 4pt lower than the form; the chat's title is 2pt
/// lower). They are the design's own numbers, so they are kept per screen
/// rather than averaged.
class TicketHeaderSpec {
  const TicketHeaderSpec({
    required this.arrowTop,
    required this.titleTop,
    required this.subtitleTop,
    required this.height,
  });

  /// My Tickets (list and empty).
  static const list = TicketHeaderSpec(
    arrowTop: 17,
    titleTop: 14,
    subtitleTop: 41,
    height: 75,
  );

  /// Raise a Ticket.
  static const form = TicketHeaderSpec(
    arrowTop: 13,
    titleTop: 10,
    subtitleTop: 37,
    height: 65,
  );

  /// "How Can We Help?".
  static const chat = TicketHeaderSpec(
    arrowTop: 15,
    titleTop: 12,
    subtitleTop: 37,
    height: 79,
  );

  /// Ticket submitted: just the arrow; the halo starts at y=39.
  static const submitted = TicketHeaderSpec(
    arrowTop: 13,
    titleTop: 0,
    subtitleTop: 0,
    height: 39,
  );

  final double arrowTop;
  final double titleTop;
  final double subtitleTop;

  /// Where the screen's content begins.
  final double height;
}

/// The teal back arrow, the screen title and its subtitle.
///
/// The arrow is Figma's exported `arrow-right`, **mirrored** — the design uses
/// one asset for both directions. Its tap target is padded out to 44pt.
class TicketHeader extends StatelessWidget {
  const TicketHeader({
    super.key,
    required this.spec,
    required this.onBack,
    this.title,
    this.subtitle,
    this.trailing,
  });

  final TicketHeaderSpec spec;
  final VoidCallback onBack;
  final String? title;
  final String? subtitle;

  /// Pinned top-right — the chat's Status button.
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return SizedBox(
      height: spec.height,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: 21 - 14,
            top: spec.arrowTop - 14,
            child: Semantics(
              button: true,
              label: 'Back',
              child: GestureDetector(
                onTap: onBack,
                behavior: HitTestBehavior.opaque,
                child: Padding(
                  padding: const EdgeInsets.all(14),
                  child: Transform.flip(
                    flipX: true,
                    child: SvgPicture.asset(
                      'assets/icons/ticket_arrow.svg',
                      height: 15.07,
                      width: 15.07,
                      colorFilter: const ColorFilter.mode(
                        AppPalette.badgeTeal,
                        BlendMode.srcIn,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (title != null)
            Positioned(
              left: 46,
              top: spec.titleTop,
              child: Text(title!, style: type.headerTitle),
            ),
          if (subtitle != null)
            Positioned(
              left: 21,
              right: 20,
              top: spec.subtitleTop,
              child: Text(subtitle!, style: type.headerSubtitle),
            ),
          ?trailing,
        ],
      ),
    );
  }
}
