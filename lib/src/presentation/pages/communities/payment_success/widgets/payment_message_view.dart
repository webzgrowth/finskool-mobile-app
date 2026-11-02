import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A centred line of copy, optionally with a spinner above it.
class PaymentMessageView extends StatelessWidget {
  const PaymentMessageView({
    super.key,
    required this.message,
    this.busy = false,
  });

  final String message;
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (busy) ...[
            const CircularProgressIndicator(),
            const SizedBox(height: AppSpacing.lg),
          ],
          Text(
            message,
            textAlign: TextAlign.center,
            style: context.communityType.description,
          ),
        ],
      ),
    );
  }
}
