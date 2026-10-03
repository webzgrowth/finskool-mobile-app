import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';


/// Transaction Details — the receipt, then Download Invoice.
///
/// There's no invoice generation anywhere in the app, so the button is a
/// no-op until a backend endpoint exists.
class SubscriptionTransactionSection extends StatelessWidget {
  const SubscriptionTransactionSection({super.key, required this.info});

  final SubscriptionInfo info;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return TealSectionCard(
      title: 'Transaction Details',
      child: Column(
        children: [
          IntrinsicHeight(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: DetailCell(
                    icon: Icons.content_copy_outlined,
                    label: 'ID',
                    value: info.transactionId,
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: DetailCell(
                    icon: Icons.calendar_today_outlined,
                    label: 'Paid on',
                    value: DateFormat('d MMM yyyy,\nh:mm a').format(info.paidOn),
                  ),
                ),
                const GridVRule(),
                Expanded(
                  child: DetailCell(
                    icon: Icons.credit_card_outlined,
                    label: 'Payment method',
                    value: info.paymentMethod,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(
                backgroundColor: AppPalette.primary,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Download Invoice', style: type.buttonLabel),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(Icons.download, size: 16, color: AppPalette.white),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
