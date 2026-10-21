import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:finskool/src/comman/widgets/search_top_bar.dart';

/// The bar lives inside a fixed-height `SliverAppBar`, so anything taller
/// than its `toolbarHeight` is a RenderFlex overflow, not a scroll.
Widget _harness({
  required double height,
  String? title,
  double textScale = 1.0,
  bool showNotifications = true,
}) => MaterialApp(
  home: MediaQuery(
    data: MediaQueryData(textScaler: TextScaler.linear(textScale)),
    child: Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            snap: true,
            toolbarHeight: height,
            automaticallyImplyLeading: false,
            flexibleSpace: SearchTopBar(
              hintText: 'Search posts, stocks or tags...',
              onQueryChanged: (_) {},
              onFilterTap: () {},
              onBack: title == null ? null : () {},
              title: title,
              showNotifications: showNotifications,
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 2000)),
        ],
      ),
    ),
  ),
);

void main() {
  testWidgets('the tab bar fits its default height', (tester) async {
    await tester.pumpWidget(_harness(height: SearchTopBar.baseHeight));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  testWidgets('a titled bar fits the height heightFor() reports', (
    tester,
  ) async {
    late double height;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            height = SearchTopBar.heightFor(context, hasTitle: true);
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpWidget(
      _harness(height: height, title: 'Intraday Community'),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(height, greaterThan(SearchTopBar.baseHeight));
  });

  testWidgets('and still fits at a large system font scale', (tester) async {
    const scale = 1.8;
    late double height;
    await tester.pumpWidget(
      MaterialApp(
        home: MediaQuery(
          data: const MediaQueryData(textScaler: TextScaler.linear(scale)),
          child: Builder(
            builder: (context) {
              height = SearchTopBar.heightFor(context, hasTitle: true);
              return const SizedBox();
            },
          ),
        ),
      ),
    );
    await tester.pumpWidget(
      _harness(height: height, title: 'Intraday Community', textScale: scale),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
  });

  // Regression: the flag was plumbed through but the widget never read it,
  // so the bell kept rendering inside a community. The bell is the only
  // SvgPicture in this bar.
  testWidgets('the tab bar keeps its notification bell', (tester) async {
    await tester.pumpWidget(_harness(height: SearchTopBar.baseHeight));
    await tester.pumpAndSettle();
    expect(find.byType(SvgPicture), findsOneWidget);
  });

  testWidgets('a community bar drops it', (tester) async {
    late double height;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            height = SearchTopBar.heightFor(context, hasTitle: true);
            return const SizedBox();
          },
        ),
      ),
    );
    await tester.pumpWidget(
      _harness(
        height: height,
        title: 'Intraday Community',
        showNotifications: false,
      ),
    );
    await tester.pumpAndSettle();
    expect(find.byType(SvgPicture), findsNothing);
    expect(find.text('Intraday Community'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  // Regression: the title row was added without raising toolbarHeight, which
  // overflowed the bar by ~30px on the community screen.
  testWidgets('a titled bar at the default height DOES overflow', (
    tester,
  ) async {
    await tester.pumpWidget(
      _harness(height: SearchTopBar.baseHeight, title: 'Intraday Community'),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNotNull);
  });
}
