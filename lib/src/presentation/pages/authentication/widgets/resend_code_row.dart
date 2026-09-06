import 'package:flutter/material.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Didn't receive Code? Resend in 0:24" — becomes a tappable "Resend"
/// link once the countdown reaches zero.
class ResendCodeRow extends StatelessWidget {
  const ResendCodeRow({
    super.key,
    required this.secondsRemaining,
    required this.onResend,
  });

  final int secondsRemaining;
  final VoidCallback onResend;

  @override
  Widget build(BuildContext context) {
    final tt = Theme.of(context).textTheme;
    final cs = Theme.of(context).colorScheme;
    final canResend = secondsRemaining <= 0;
    final minutes = secondsRemaining ~/ 60;
    final seconds = (secondsRemaining % 60).toString().padLeft(2, '0');
    return Column(
      children: [
        Text("Didn't receive Code?", style: tt.bodySmall),
        GestureDetector(
          onTap: canResend ? onResend : null,
          child: Text(
            canResend ? 'Resend' : 'Resend in $minutes:$seconds',
            style: inter(size: 10, weight: 700, height: 1.6, color: cs.primary)
                .copyWith(decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }
}
