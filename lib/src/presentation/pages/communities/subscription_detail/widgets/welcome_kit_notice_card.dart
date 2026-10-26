import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/markdown_text.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// A Welcome Kit notice. Two shapes, as drawn in the Final design and as the
/// API's two notice `type`s:
///
/// * **risk** (`warning` → [NoticeTone.danger]) — a tinted plate with a
///   triangle, a Manrope heading and a body, no border;
/// * **info** (`normal` → [NoticeTone.info]) — the "Acknowledgment": a
///   `#F6F6F6` plate with a teal hairline, a teal "i" disc and a paragraph
///   (with its heading, in bold, when the admin gave one).
class WelcomeKitNoticeCard extends StatelessWidget {
  const WelcomeKitNoticeCard({super.key, required this.notice});

  final WelcomeKitNotice notice;

  @override
  Widget build(BuildContext context) => notice.tone == NoticeTone.info
      ? _Acknowledgment(notice: notice)
      : _Risk(notice: notice);
}

class _Risk extends StatelessWidget {
  const _Risk({required this.notice});

  final WelcomeKitNotice notice;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    const ink = AppPalette.subRiskInk;
    const body = AppPalette.subRiskBody;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(15, 12, 27, 12),
      decoration: BoxDecoration(
        color: AppPalette.subRiskPlate,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset('assets/icons/sub_warning.svg'),
          const SizedBox(width: 9),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (notice.title != null) ...[
                  Text(
                    notice.title!,
                    style: type.noticeTitle.copyWith(color: ink),
                  ),
                  const SizedBox(height: 4),
                ],
                Text.rich(
                  TextSpan(
                    children: markdownSpans(
                      notice.body,
                      type.noticeBody.copyWith(color: body),
                      type.noticeBodyBold.copyWith(color: ink),
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

class _Acknowledgment extends StatelessWidget {
  const _Acknowledgment({required this.notice});

  final WelcomeKitNotice notice;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(13, 7.5, 13, 7.5),
      decoration: BoxDecoration(
        color: AppPalette.ticketCard,
        borderRadius: BorderRadius.circular(11),
        border: Border.all(color: AppPalette.badgeTeal, width: 0.75),
        boxShadow: const [
          BoxShadow(
            color: AppPalette.ticketShadow,
            blurRadius: 10,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 3.5),
            child: Container(
              height: 18,
              width: 18,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppPalette.badgeTeal,
                shape: BoxShape.circle,
              ),
              child: Text(
                'i',
                style: type.disclaimerBold.copyWith(
                  color: AppPalette.white,
                  fontSize: 11,
                  height: 1.0,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8.3),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  if (notice.title != null)
                    TextSpan(
                      text: '${notice.title}\n',
                      style: type.disclaimerBold,
                    ),
                  ...markdownSpans(
                    notice.body,
                    type.disclaimer,
                    type.disclaimerBold,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
