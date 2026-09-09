import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/post_media_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reactor_model.dart';

/// Hardcoded feed data standing in for a real backend. `FeedBloc` calls
/// this directly — swap this file's contents for a `Dio`-backed
/// repository call once a real API exists; nothing else needs to change.
class FeedMockDatasource {
  static const _chartImage =
      'https://images.unsplash.com/photo-1642790106117-e829e14a795f?w=800';
  static const _candleImage =
      'https://images.unsplash.com/photo-1611974789855-9c2a0a7236a3?w=800';
  static const _tickerImage =
      'https://images.unsplash.com/photo-1590283603385-17ffb3a7f29f?w=800';
  static const _avatar =
      'https://ui-avatars.com/api/?name=Ritesh+Kumar&background=164544&color=fff';

  static final _reactors = [
    const ReactorModel(
      id: 'u1',
      name: 'Jai Sharma',
      avatarUrl: 'https://ui-avatars.com/api/?name=Jai+Sharma',
      reaction: ReactionType.like,
    ),
    const ReactorModel(
      id: 'u2',
      name: 'Ram Kumar',
      avatarUrl: 'https://ui-avatars.com/api/?name=Ram+Kumar',
      reaction: ReactionType.love,
    ),
    const ReactorModel( 
      id: 'u3',
      name: 'Vinod Sharma',
      avatarUrl: 'https://ui-avatars.com/api/?name=Vinod+Sharma',
      reaction: ReactionType.wow,
    ),
  ];

  static List<FeedPostModel> getPosts() => [
        FeedPostModel(
          id: 'p1',
          authorName: 'Ritesh Kumar',
          authorAvatarUrl: _avatar,
          postedAt: DateTime.now().subtract(const Duration(hours: 2)),
          title: 'Reliance Industries Breakout Above ₹1,480',
          body: 'Strong buying momentum above the ₹1,480 resistance zone. '
              'Entry zone ₹1,475–1,485, SL below ₹1,445, Target ₹1,525–1,550.',
          media: const [
            PostMediaModel(
                type: PostMediaType.image,
                imageUrl: _chartImage,
                durationLabel: '01:11'),
            PostMediaModel(type: PostMediaType.image, imageUrl: _candleImage),
            PostMediaModel(
              type: PostMediaType.youtubeEmbed,
              imageUrl: _chartImage,
              embedUrl: 'https://www.youtube.com/embed/dQw4w9WgXcQ',
            ),
            PostMediaModel(type: PostMediaType.image, imageUrl: _tickerImage),
          ],
          hashtags: const ['#TATASTEEL', '#BUY', '#SWING'],
          reactionCounts: const {
            ReactionType.like: 540,
            ReactionType.love: 2,
            ReactionType.wow: 2,
          },
          reactors: _reactors,
        ),
        FeedPostModel(
          id: 'p2',
          authorName: 'Ritesh Kumar',
          authorAvatarUrl: _avatar,
          postedAt: DateTime.now().subtract(const Duration(hours: 5)),
          title: 'HDFC Bank Signals Fresh Breakout',
          body: 'The stock breaks above a key resistance level with strong '
              'volume. Buyers remain in control, with ₹1,780–1,820 as the '
              'next target zone.',
          media: const [
            PostMediaModel(type: PostMediaType.image, imageUrl: _candleImage),
          ],
          hashtags: const ['#HDFCBANK', '#BREAKOUT'],
          reactionCounts: const {ReactionType.like: 128},
          reactors: const [],
        ),
      ];
}
