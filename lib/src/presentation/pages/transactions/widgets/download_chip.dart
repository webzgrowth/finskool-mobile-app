import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// Figma's `Button / Download invoice`: a 25px pill, `#108B8B` at 10%, a 12px
/// tray glyph and "Download" — padded 10 left, 12 right, 5 between.
class DownloadChip extends StatelessWidget {
  const DownloadChip({super.key, required this.onTap, this.busy = false});

  final VoidCallback? onTap;

  /// An invoice is being fetched: the glyph becomes a spinner, taps are ignored.
  final bool busy;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      label: 'Download invoice',
      child: GestureDetector(
        onTap: busy ? null : onTap,
        behavior: HitTestBehavior.opaque,
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 6, 12, 6),
          decoration: BoxDecoration(
            color: AppPalette.ticketTagSurface,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              busy
                  ? const SizedBox(
                      height: 12,
                      width: 12,
                      child: CircularProgressIndicator(
                        strokeWidth: 1.5,
                        color: AppPalette.badgeTeal,
                      ),
                    )
                  : SvgPicture.asset('assets/icons/txn_download.svg'),
              const SizedBox(width: 5),
              Text('Download', style: context.transactionType.download),
            ],
          ),
        ),
      ),
    );
  }
}
