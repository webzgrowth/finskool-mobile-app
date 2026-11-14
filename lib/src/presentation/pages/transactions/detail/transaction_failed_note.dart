import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Why a payment failed, on the red-tinted plate — the list card's note, given
/// room to wrap.
class TransactionFailedNote extends StatelessWidget {
  const TransactionFailedNote({super.key, required this.reason});

  final String? reason;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppPalette.ticketOpenSurface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 1),
            child: SvgPicture.asset('assets/icons/txn_alert.svg'),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              reason ?? 'The payment did not go through.',
              style: context.transactionType.failedNote,
            ),
          ),
        ],
      ),
    );
  }
}
