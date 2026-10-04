import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:finskool/src/comman/rich_text_spans.dart';
import 'package:finskool/src/comman/widgets/teal_section_card.dart';
import 'package:finskool/src/domain/model/community/welcome_kit.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

/// "Watch before you start" — the intro paragraph and the onboarding video
/// rows, each a 16:9 thumbnail beside its title.
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text.rich(TextSpan(
            children: bodySpans(intro, type.kitBody, type.kitBodyBold),
          )),
          for (final video in videos) ...[
            const SizedBox(height: AppSpacing.md),
            _VideoRow(video: video),
          ],
        ],
      ),
    );
  }
}

class _VideoRow extends StatelessWidget {
  const _VideoRow({required this.video});

  final WelcomeKitVideo video;

  /// Figma's row is a wide thumbnail with the title set beside it, not
  /// beneath — so the strip is fixed-width and the text takes the rest.
  static const double _thumbWidth = 96;

  @override
  Widget build(BuildContext context) {
    final type = context.subscriptionType;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadii.sm),
          child: SizedBox(
            width: _thumbWidth,
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: _Thumbnail(url: video.thumbnailUrl),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Text(video.title, style: type.kitVideoTitle)),
      ],
    );
  }
}

/// A dark plate with a play glyph when there's no artwork — which is every
/// row today, since no endpoint supplies these thumbnails.
class _Thumbnail extends StatelessWidget {
  const _Thumbnail({required this.url});

  final String? url;

  @override
  Widget build(BuildContext context) {
    const fallback = ColoredBox(
      color: Colors.black87,
      child: Icon(Icons.play_arrow_rounded, color: Colors.white, size: 22),
    );
    if (url == null || url!.isEmpty) return fallback;
    return CachedNetworkImage(
      imageUrl: url!,
      fit: BoxFit.cover,
      placeholder: (_, _) => const ColoredBox(color: Colors.black26),
      errorWidget: (_, _, _) => fallback,
    );
  }
}
