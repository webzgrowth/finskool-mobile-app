import 'package:flutter/material.dart';
import 'package:finskool/src/comman/ist_time.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_button.dart';
import 'package:finskool/src/presentation/pages/tickets/widgets/ticket_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "₹11,800" / "₹1,382.71" — whole rupees drop the decimals.
String rupees(double v) {
  final whole = v == v.roundToDouble();
  final s = v.toStringAsFixed(whole ? 0 : 2);
  final parts = s.split('.');
  final digits = parts.first;
  final head = digits.length > 3
      ? '${digits.substring(0, digits.length - 3).replaceAllMapped(RegExp(r'(\d)(?=(\d\d)+$)'), (m) => '${m[1]},')},${digits.substring(digits.length - 3)}'
      : digits;
  return '₹$head${parts.length > 1 ? '.${parts[1]}' : ''}';
}

/// The team's price, as a card in the conversation.
///
/// Its status is read from the **bloc's live map**, not the message snapshot:
/// a newer quote supersedes this one, the server expires it, or the member
/// pays it — and the card must say so without a refetch. Only an `active`
/// quote on an open request offers **Pay**; the server re-checks regardless.
class QuoteCard extends StatelessWidget {
  const QuoteCard({
    super.key,
    required this.quote,
    required this.canPay,
    required this.onPay,
    this.paying = false,
  });

  final ServiceQuoteModel quote;
  final bool canPay;
  final bool paying;
  final VoidCallback onPay;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final live = quote.isPayable;
    return Opacity(
      opacity: live || quote.status == ServiceQuoteStatus.paid ? 1 : 0.7,
      child: TicketCard(
        fill: AppPalette.white,
        borderColor: live ? AppPalette.badgeTeal : AppPalette.ticketCardBorder,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Quote v${quote.version}',
                    style: type.cardHeader,
                  ),
                ),
                Text(
                  live ? 'Valid' : quote.status.label,
                  style: type.bubbleCaption,
                ),
              ],
            ),
            const SizedBox(height: 10),
            _Row('Service fee', rupees(quote.baseAmount)),
            _Row(
              'GST (${quote.gstRatePercent.toStringAsFixed(quote.gstRatePercent % 1 == 0 ? 0 : 1)}%)',
              rupees(quote.gstAmount),
            ),
            Container(
              height: 1,
              margin: const EdgeInsets.symmetric(vertical: 8),
              color: AppPalette.ticketDivider,
            ),
            _Row('Total', rupees(quote.totalAmount), strong: true),
            if (quote.note?.isNotEmpty == true) ...[
              const SizedBox(height: 8),
              Text(quote.note!, style: type.bubbleCaption),
            ],
            if (live) ...[
              const SizedBox(height: 8),
              Text(
                'Valid until ${formatIst(quote.expiresAt, 'dd MMM, h:mm a')}',
                style: type.bubbleCaption,
              ),
              if (canPay) ...[
                const SizedBox(height: 12),
                TicketButton(
                  label: 'Pay ${rupees(quote.totalAmount)}',
                  loading: paying,
                  onTap: paying ? null : onPay,
                ),
              ],
            ],
          ],
        ),
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row(this.label, this.value, {this.strong = false});

  final String label;
  final String value;
  final bool strong;

  @override
  Widget build(BuildContext context) {
    final type = context.ticketType;
    final style = strong ? type.cardHeader : type.bubble;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}
