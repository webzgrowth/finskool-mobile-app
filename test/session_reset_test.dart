import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/usecases/community/get_communities.dart';
import 'package:finskool/src/domain/usecases/community/request_pricing.dart';
import 'package:finskool/src/domain/usecases/feed/get_post_reactions.dart';
import 'package:finskool/src/domain/usecases/feed/get_posts.dart';
import 'package:finskool/src/domain/usecases/feed/react_to_post.dart';
import 'package:finskool/src/domain/usecases/feed/remove_reaction.dart';
import 'package:finskool/src/domain/usecases/services/get_service_catalog.dart';
import 'package:finskool/src/presentation/bloc/communities/list/communities_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/bloc/services/catalog/services_catalog_bloc.dart';

/// The blocs behind the three tabs live for the whole app. These pin what a
/// **sign-out** must do to them: forget the account's data (so the next login
/// neither shows it nor skips the load and its skeleton) and drop any response
/// still in flight for the old session.

class _Posts implements PostsRepository {
  int calls = 0;
  Duration delay = Duration.zero;
  String id = 'a';

  @override
  Future<Either<Failure, PostPageModel>> getPosts({
    int page = 1,
    int pageSize = 20,
    String? communityId,
    String? date,
    String order = 'desc',
  }) async {
    calls++;
    final mine = id;
    await Future<void>.delayed(delay);
    return Right(
      PostPageModel(
        posts: [
          FeedPostModel(
            id: mine,
            communityId: 'c',
            communityName: 'C',
            authorName: 'A',
            postedAt: DateTime(2026),
            title: 't',
            body: 'b',
            media: const [],
            hashtags: const [],
          ),
        ],
        total: 1,
        page: 1,
        pageSize: 20,
        totalPages: 1,
      ),
    );
  }

  /// Hydration is fired after every load; one post failing is not the feed's.
  @override
  Future<Either<Failure, PostReactionsPageModel>> getPostReactions(
    String postId, {
    int page = 1,
    int pageSize = 50,
  }) async => const Left(ServerFailure('skipped'));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Communities implements CommunitiesRepository {
  Duration delay = Duration.zero;
  String name = 'Mine';
  int calls = 0;

  @override
  Future<Either<Failure, List<CommunityModel>>> getCommunities() async {
    calls++;
    final mine = name;
    await Future<void>.delayed(delay);
    return Right([
      CommunityModel(
        id: 'c1',
        name: mine,
        slug: 's',
        tags: const [],
        memberCount: 0,
      ),
    ]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _Services implements ServicesRepository {
  int calls = 0;

  @override
  Future<Either<Failure, List<ServiceModel>>> getCatalog() async {
    calls++;
    return const Right([
      ServiceModel(id: 's1', title: 'Portfolio', description: 'd'),
    ]);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

Future<void> pump([int ms = 30]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  group('FeedBloc', () {
    late _Posts repo;
    late FeedBloc bloc;
    setUp(() {
      repo = _Posts();
      bloc = FeedBloc(
        GetPosts(repo),
        GetPostReactions(repo),
        ReactToPost(repo),
        RemoveReaction(repo),
      );
    });
    tearDown(() => bloc.close());

    test('reset forgets the previous account\'s posts', () async {
      bloc.add(const FeedEvent.loadFeed());
      await pump();
      expect(bloc.state.posts, isNotEmpty);
      bloc.add(const FeedEvent.reset());
      await pump();
      // Empty again — which is what makes the Feed tab load (and show its
      // skeleton) on the next login instead of reusing the last member's feed.
      expect(bloc.state.posts, isEmpty);
      expect(bloc.state.state, RequestState.empty);
    });

    test(
      'a load still in flight at sign-out cannot repopulate the feed',
      () async {
        repo.delay = const Duration(milliseconds: 80);
        bloc.add(const FeedEvent.loadFeed());
        await pump(10);
        bloc.add(const FeedEvent.reset());
        await pump(150);
        expect(bloc.state.posts, isEmpty);
      },
    );
  });

  group('CommunitiesBloc', () {
    late _Communities repo;
    late CommunitiesBloc bloc;
    setUp(() {
      repo = _Communities();
      bloc = CommunitiesBloc(GetCommunities(repo), RequestPricing(repo));
    });
    tearDown(() => bloc.close());

    test('reset forgets the subscriptions and the catalog', () async {
      bloc.add(const CommunitiesEvent.loadCommunities());
      await pump();
      expect(bloc.state.communities, hasLength(1));
      bloc.add(const CommunitiesEvent.reset());
      await pump();
      expect(bloc.state.communities, isEmpty);
    });

    test(
      'a response for the old session is dropped, the new one wins',
      () async {
        repo.delay = const Duration(milliseconds: 80);
        bloc.add(const CommunitiesEvent.loadCommunities());
        await pump(10);
        bloc.add(const CommunitiesEvent.reset());
        repo.name = 'New account';
        bloc.add(const CommunitiesEvent.loadCommunities());
        await pump(200);
        expect(bloc.state.communities.single.name, 'New account');
      },
    );
  });

  group('ServicesCatalogBloc', () {
    late _Services repo;
    late ServicesCatalogBloc bloc;
    setUp(() {
      repo = _Services();
      bloc = ServicesCatalogBloc(GetServiceCatalog(repo));
    });
    tearDown(() => bloc.close());

    test(
      'without a reset the second login would NOT reload (the bug)',
      () async {
        bloc.add(const ServicesCatalogEvent.load());
        await pump();
        bloc.add(const ServicesCatalogEvent.load());
        await pump();
        expect(repo.calls, 1); // "already loaded" — no request, no skeleton
      },
    );

    test('after a reset the next load really loads again', () async {
      bloc.add(const ServicesCatalogEvent.load());
      await pump();
      bloc.add(const ServicesCatalogEvent.reset());
      await pump();
      expect(bloc.state.state, RequestState.empty);
      expect(bloc.state.services, isEmpty);
      bloc.add(const ServicesCatalogEvent.load());
      await pump();
      expect(repo.calls, 2);
      expect(bloc.state.services, hasLength(1));
    });
  });
}
