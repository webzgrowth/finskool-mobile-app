import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Watch before you start" — the intro paragraph, then one white row per
/// video: a 93x52 thumbnail (r5, teal hairline, soft shadow, YouTube mark in
/// the middle) beside a 10px title. Rows are 74 tall, 5 apart.
class WatchFirstSection extends StatelessWidget {
  const WatchFirstSection({
    super.key,
    required this.intro,
    required this.videos,
  });

  final String intro;
  final List<WelcomeKitVideo> videos;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return TealSectionCard(
      title: 'Watch before you start',
      padding: const EdgeInsets.fromLTRB(15, 9, 15, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(
            TextSpan(
              children: bodySpans(intro, type.kitBody, type.kitBodyBold),
            ),
          ),
          const SizedBox(height: 8),
          for (var i = 0; i < videos.length; i++) ...[
            if (i > 0) const SizedBox(height: 5),
            _VideoRow(video: videos[i]),
          ],
        ],
      ),
    );
  }
}

class _VideoRow extends StatelessWidget {
  const _VideoRow({required this.video});

  final WelcomeKitVideo video;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Container(
      height: 74,
      padding: const EdgeInsets.fromLTRB(11, 10, 11, 10),
      decoration: BoxDecoration(
        color: AppPalette.white,
        borderRadius: BorderRadius.circular(10.74),
      ),
      child: Row(
        children: [
          Container(
            width: 93,
            height: 52,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(color: AppPalette.badgeTeal, width: 0.5),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x1A000000),
                  blurRadius: 10,
                  offset: Offset(0, 2),
                ),
              ],
            ),
            child: Stack(
              fit: StackFit.expand,
              children: [
                _Thumbnail(url: video.thumbnailUrl),
                Center(child: SvgPicture.asset('assets/icons/sub_youtube.svg')),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(video.title, style: type.kitVideoTitle)),
        ],
      ),
    );
  }
}

/// A dark plate when there's no artwork. `thumbnailUrl` comes from the demo
/// data until an endpoint supplies it.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const fallback = ColoredBox(color: AppPalette.reactionRing);
    if (url == null || url!.isEmpty) return fallback;
    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      placeholder: (_, _) => fallback,
      errorWidget: (_, _, _) => fallback,
    );
  }
}
