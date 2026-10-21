import 'package:flutter/material.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// One of the three tinted advisory banners. They differ only in tone, so
/// the plate, hairline, ink and icon all come from [NoticeTone] rather than
/// from three near-identical widgets.
class WelcomeKitNoticeCard extends StatelessWidget {
  const WelcomeKitNoticeCard({super.key, required this.notice});

  final WelcomeKitNotice notice;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    final tone = _ToneStyle.of(notice.tone);

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: tone.surface,
        borderRadius: BorderRadius.circular(AppRadii.md),
        border: Border.all(color: tone.border),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(tone.icon, size: 14, color: tone.ink),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notice.title != null) ...[
                  Text(
                    notice.title!,
                    style: type.noticeTitle.copyWith(color: tone.ink),
                  ),
                  const SizedBox(height: 3),
                ],
                Text.rich(
                  TextSpan(
                    children: bodySpans(
                      notice.body,
                      type.noticeBody.copyWith(color: tone.ink),
                      type.noticeBody.copyWith(
                        color: tone.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ToneStyle {
  const _ToneStyle(this.surface, this.border, this.ink, this.icon);

  final Color surface;
  final Color border;
  final Color ink;
  final IconData icon;

  static _ToneStyle of(NoticeTone tone) => switch (tone) {
    NoticeTone.info => const _ToneStyle(
      AppPalette.noticeInfoSurface,
      AppPalette.noticeInfoBorder,
      AppPalette.noticeInfoInk,
      Icons.info_outline,
    ),
    NoticeTone.warning => const _ToneStyle(
      AppPalette.noticeWarnSurface,
      AppPalette.noticeWarnBorder,
      AppPalette.noticeWarnInk,
      Icons.info_outline,
    ),
    NoticeTone.danger => const _ToneStyle(
      AppPalette.noticeDangerSurface,
      AppPalette.noticeDangerBorder,
      AppPalette.noticeDangerInk,
      Icons.warning_amber_rounded,
    ),
  };
}
