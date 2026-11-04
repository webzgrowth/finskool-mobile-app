import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/data/datasource/reaction_type_catalog.dart';
import 'package:finskool/src/domain/model/feed_post_model.dart';
import 'package:finskool/src/domain/model/post_page_model.dart';
import 'package:finskool/src/domain/model/post_reactions_page_model.dart';
import 'package:finskool/src/domain/model/reaction_summary_model.dart';
import 'package:finskool/src/domain/model/reaction_type.dart';
import 'package:finskool/src/domain/model/reaction_type_model.dart';
import 'package:finskool/src/domain/repository/posts_repository.dart';
import 'package:finskool/src/domain/usecases/feed/get_post_reactions.dart';
import 'package:finskool/src/domain/usecases/feed/get_posts.dart';
import 'package:finskool/src/domain/usecases/feed/react_to_post.dart';
import 'package:finskool/src/domain/usecases/feed/remove_reaction.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/post_reaction_bar.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/reaction_icons.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/reaction_picker_row.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _Repo implements PostsRepository {
  _Repo(this.mine);

  /// The reaction the seeded post already carries.
  final ReactionType? mine;
  final reacted = <ReactionType>[];
  int removed = 0;

  /// The bloc patches the post **in its own list**, so it has to hold one.
  @override
  Future<Either<Failure, PostPageModel>> getPosts({
    int page = 1,
    int pageSize = 20,
    String? communityId,
    String? date,
    String order = 'desc',
  }) async => Right(
    PostPageModel(
      posts: [_post(mine: mine)],
      total: 1,
      page: 1,
      pageSize: 20,
      totalPages: 1,
    ),
  );

  @override
  Future<Either<Failure, ReactionSummaryModel>> react({
    required String postId,
    required ReactionType reaction,
  }) async {
    reacted.add(reaction);
    return Right(
      ReactionSummaryModel(counts: {reaction: 1}, myReaction: reaction),
    );
  }

  @override
  Future<Either<Failure, ReactionSummaryModel>> removeReaction(
    String postId,
  ) async {
    removed++;
    return const Right(ReactionSummaryModel(counts: {}));
  }

  @override
  Future<Either<Failure, PostReactionsPageModel>> getPostReactions(
    String postId, {
    int page = 1,
    int pageSize = 50,
  }) async => const Left(ServerFailure('skipped'));

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// A catalog that answers from memory instead of the network.
class _Catalog extends ReactionTypeCatalog {
  _Catalog(this.names) : super(ApiClient());

  final List<String> names;

  @override
  Future<List<ReactionTypeModel>> all() async => [
    for (var i = 0; i < names.length; i++)
      ReactionTypeModel(id: i + 1, name: names[i], emoji: '', sortOrder: i),
  ];
}

FeedPostModel _post({ReactionType? mine}) => FeedPostModel(
  id: 'p1',
  communityId: 'c',
  communityName: 'C',
  authorName: 'A',
  postedAt: DateTime(2026),
  title: 't',
  body: 'b',
  media: const [],
  hashtags: const [],
  currentUserReaction: mine,
);

void main() {
  setUpAll(loadAppFonts);

  late _Repo repo;
  late FeedBloc bloc;

  Future<void> pumpBar(
    WidgetTester tester, {
    ReactionType? mine,
    List<String> offered = const [
      'like',
      'love',
      'insightful',
      'haha',
      'celebrate',
    ],
  }) async {
    if (locator.isRegistered<ReactionTypeCatalog>()) {
      await locator.unregister<ReactionTypeCatalog>();
    }
    locator.registerSingleton<ReactionTypeCatalog>(_Catalog(offered));
    addTearDown(() => locator.unregister<ReactionTypeCatalog>());
    repo = _Repo(mine);
    bloc = FeedBloc(
      GetPosts(repo),
      GetPostReactions(repo),
      ReactToPost(repo),
      RemoveReaction(repo),
    );
    addTearDown(bloc.close);
    bloc.add(const FeedEvent.loadFeed());
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(40),
              child: BlocProvider.value(
                value: bloc,
                child: SizedBox(
                  width: 300,
                  child: PostReactionBar(post: _post(mine: mine)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 50)); // catalog + feed
    }
  }

  /// The write runs through the bloc's own async handler, in the test's fake
  /// clock — it only advances while the clock is pumped.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  Finder like() => find.byType(GestureDetector).first;

  testWidgets('a TAP on Like opens every reaction and sends nothing yet', (
    tester,
  ) async {
    await pumpBar(tester);
    await tester.tap(like());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300)); // the entrance scale
    for (final r in ReactionIcons.pickerOrder) {
      expect(find.text(r.emoji), findsOneWidget);
    }
    expect(repo.reacted, isEmpty); // the member has not chosen yet
  });

  testWidgets('choosing one from the picker reacts with exactly that', (
    tester,
  ) async {
    await pumpBar(tester);
    await tester.tap(like());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300)); // the entrance scale
    await tester.tap(find.text(ReactionType.insightful.emoji));
    await settle(tester);
    expect(repo.reacted, [ReactionType.insightful]);
    expect(
      find.text(ReactionType.insightful.emoji),
      findsNothing,
    ); // picker closed
  });

  testWidgets('choosing the reaction you already have takes it back', (
    tester,
  ) async {
    await pumpBar(tester, mine: ReactionType.love);
    await tester.tap(like());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300)); // the entrance scale
    // The Like control now shows the member's own ❤️ too, so aim at the picker's.
    await tester.tap(
      find.descendant(
        of: find.byType(ReactionPickerRow),
        matching: find.text(ReactionType.love.emoji),
      ),
    );
    await settle(tester);
    expect(repo.removed, 1);
    expect(repo.reacted, isEmpty);
  });

  testWidgets('tapping outside dismisses it without reacting', (tester) async {
    await pumpBar(tester);
    await tester.tap(like());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300)); // the entrance scale
    await tester.tapAt(const Offset(700, 50)); // nowhere near the picker
    await tester.pump(const Duration(milliseconds: 250));
    expect(find.text(ReactionType.insightful.emoji), findsNothing);
    expect(repo.reacted, isEmpty);
    expect(repo.removed, 0);
  });

  testWidgets('only what the backend offers is shown', (tester) async {
    await pumpBar(tester, offered: const ['like', 'love', 'sad']);
    await tester.tap(like());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300)); // the entrance scale
    expect(find.text(ReactionType.like.emoji), findsOneWidget);
    expect(find.text(ReactionType.love.emoji), findsOneWidget);
    expect(find.text(ReactionType.insightful.emoji), findsNothing);
    expect(find.text(ReactionType.haha.emoji), findsNothing);
  });

  test('the picker follows the API order, and only what the server offers', () {
    // 👍 ❤️ 💡 😂 👏 — the backend's `sortOrder`.
    expect(ReactionIcons.pickerOrder, [
      ReactionType.like,
      ReactionType.love,
      ReactionType.insightful,
      ReactionType.haha,
      ReactionType.celebrate,
    ]);
    expect(ReactionIcons.sheetOrder, ReactionIcons.pickerOrder);
    final order = ReactionIcons.pickerOrder;
    expect(ReactionIcons.available(null), order);
    expect(ReactionIcons.available({}), order);
    expect(
      ReactionIcons.available({ReactionType.celebrate, ReactionType.like}),
      [ReactionType.like, ReactionType.celebrate],
    );
  });

  test('removed types (wow, sad, angry) are dropped, not thrown on', () {
    expect(ReactionTypeX.fromName('wow'), isNull);
    expect(ReactionTypeX.fromName('sad'), isNull);
    expect(ReactionTypeX.fromName('angry'), isNull);
    expect(ReactionTypeX.fromName('insightful'), ReactionType.insightful);
    expect(ReactionTypeX.fromName('celebrate'), ReactionType.celebrate);
  });
}
