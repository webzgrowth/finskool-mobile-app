import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_close_button.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Was your query resolved?" — five stars and one **Submit rating**.
///
/// Figma's two buttons ("No, reopen ticket" / "Yes, close ticket") both need
/// backend the API doesn't have (§10: no reopen, no member-side close), so by
/// decision they are one real action: a rating, sent once. Dismissible with
/// the ✕; a resolved ticket stays rate-able from the next visit.
///
/// The chosen star count is local state: it only means something once
/// "Submit rating" is tapped, and then it goes to the bloc.
class RatingPopup extends StatefulWidget {
  const RatingPopup({
    super.key,
    required this.submitting,
    required this.onSubmit,
    required this.onClose,
  });

  final bool submitting;
  final ValueChanged<int> onSubmit;
  final VoidCallback onClose;

  @override
  State<RatingPopup> createState() => _RatingPopupState();
}

class _RatingPopupState extends State<RatingPopup> {
  int _stars = 0;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    return Positioned(
      left: 13,
      right: 11,
      bottom: MediaQuery.paddingOf(context).bottom + 1,
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 351),
          // The ✕ sits in an outer stack, on the card's own bounds: a child
          // positioned outside its parent's box can't receive taps.
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                padding: const EdgeInsets.fromLTRB(17, 17.5, 17, 17),
                decoration: BoxDecoration(
                  color: AppPalette.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppPalette.ticketCardBorder),
                  boxShadow: const [
                    BoxShadow(
                      color: AppPalette.ticketShadow,
                      blurRadius: 24,
                      offset: Offset(0, 8),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text('Was your query resolved?', style: type.feedbackTitle),
                    const SizedBox(height: 12),
                    Text(
                      'Rate the support you received on this ticket.',
                      style: type.feedbackBody,
                    ),
                    const SizedBox(height: 14),
                    Row(
                      children: [
                        for (var i = 1; i <= 5; i++)
                          GestureDetector(
                            onTap: widget.submitting
                                ? null
                                : () => setState(() => _stars = i),
                            behavior: HitTestBehavior.opaque,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 16),
                              child: SvgPicture.asset(
                                i <= _stars
                                    ? 'assets/icons/ticket_star_on.svg'
                                    : 'assets/icons/ticket_star_off.svg',
                                height: 22,
                                width: 22,
                              ),
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(height: 1, color: AppPalette.ticketDivider),
                    const SizedBox(height: 12),
                    TicketButton(
                      label: 'Submit rating',
                      arrow: false,
                      loading: widget.submitting,
                      textStyle: type.feedbackButton,
                      onTap: _stars == 0 ? null : () => widget.onSubmit(_stars),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: 0,
                right: 1,
                child: TicketCloseButton(onTap: widget.onClose),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
