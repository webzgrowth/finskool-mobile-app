import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:finskool/src/comman/widgets/detail_cell.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Transaction Details — the receipt, then Download Invoice (a 32px teal bar).
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
      padding: const EdgeInsets.fromLTRB(10, 15, 10, 15),
      child: Column(
        children: [
          ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 57),
            child: IntrinsicHeight(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 92,
                    child: DetailCell(
                      glyph: 'assets/icons/sub_copy.svg',
                      label: 'ID',
                      value: info.transactionId,
                    ),
                  ),
                  const GridVRule(),
                  Expanded(
                    flex: 100,
                    child: DetailCell(
                      glyph: 'assets/icons/sub_calendar_add.svg',
                      label: 'Paid on',
                      value: DateFormat('d MMM yyyy,\nh:mm a')
                          .format(info.paidOn),
                    ),
                  ),
                  const GridVRule(),
                  Expanded(
                    flex: 100,
                    child: DetailCell(
                      glyph: 'assets/icons/sub_card.svg',
                      label: 'Payment method',
                      value: info.paymentMethod,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 14),
          GestureDetector(
            onTap: () {},
            child: Container(
              height: 32,
              width: double.infinity,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: AppPalette.badgeTeal,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Download Invoice', style: type.buttonLabel),
                  const SizedBox(width: 4),
                  SvgPicture.asset('assets/icons/sub_download.svg'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
