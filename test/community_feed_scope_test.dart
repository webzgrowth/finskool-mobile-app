@TestOn('vm')
library;

import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/injections/injection.dart';
import 'package:finskool/src/presentation/bloc/feed/filter/feed_filter_bloc.dart';
import 'package:finskool/src/presentation/bloc/feed/posts/feed_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

void main() {
  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    if (!locator.isRegistered<FeedBloc>()) configureDependencies();
  });

  // The Feed tab and a community's feed must not share a bloc: entering a
  // community would otherwise reload the tab's posts with that communityId
  // and lose its scroll position.
  test('FeedBloc is a factory, so each screen scopes its own', () {
    final a = locator<FeedBloc>();
    final b = locator<FeedBloc>();
    expect(identical(a, b), isFalse);
    a.close();
    b.close();
  });

  test('FeedFilterBloc is a factory too, so search text does not leak', () {
    final a = locator<FeedFilterBloc>();
    final b = locator<FeedFilterBloc>();
    expect(identical(a, b), isFalse);
    a.add(const FeedFilterEvent.queryChanged('reliance'));
    expect(b.state.query, isEmpty);
    a.close();
    b.close();
  });

  test('loadFeed carries communityId onto the state for paging and retry', () {
    final bloc = locator<FeedBloc>();
    bloc.add(const FeedEvent.loadFeed(communityId: 'abc-123'));
    // The handler sets communityId before the request resolves, which is
    // what `loadMore`, `refreshFeed` and the error retry all read back.
    return Future<void>.delayed(Duration.zero, () {
      expect(bloc.state.communityId, 'abc-123');
      bloc.close();
    });
  });
}
