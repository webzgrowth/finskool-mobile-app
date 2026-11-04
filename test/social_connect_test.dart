import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/model/auth/user_model.dart';
import 'package:finskool/src/domain/usecases/social/connect_social_account.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_connect/social_connect_bloc.dart';
import 'package:finskool/src/presentation/pages/dashboard/profile/widgets/connect_account_row.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _Repo implements SocialAuthRepository {
  Either<Failure, List<String>> result = const Right(['google']);
  final connected = <SocialProvider>[];

  @override
  Future<Either<Failure, List<String>>> connect(SocialProvider provider) async {
    connected.add(provider);
    return result;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

const _userJson = {
  'id': 'u1',
  'name': 'Asha',
  'email': 'a@b.co',
  'phone': '+91',
  'role': 'member',
};

Future<void> pump() => Future<void>.delayed(const Duration(milliseconds: 20));

void main() {
  setUpAll(loadAppFonts);

  group('linkedProviders on the user', () {
    test('reads the list, and absent means none', () {
      expect(UserModel.fromJson(_userJson).linkedProviders, isEmpty);
      final u = UserModel.fromJson({
        ..._userJson,
        'linkedProviders': ['google', 'apple'],
      });
      expect(u.hasLinked('google'), isTrue);
      expect(u.hasLinked('apple'), isTrue);
    });

    test('survives the prefs cache and a copyWith', () {
      final u = UserModel.fromJson({
        ..._userJson,
        'linkedProviders': ['google'],
      });
      final back = UserModel.fromJson(u.toJson());
      expect(back.linkedProviders, ['google']);
      expect(back.copyWith(name: 'New').linkedProviders, ['google']);
    });
  });

  group('SocialConnectBloc', () {
    late _Repo repo;
    late SocialConnectBloc bloc;

    setUp(() {
      repo = _Repo();
      bloc = SocialConnectBloc(ConnectSocialAccount(repo));
      addTearDown(bloc.close);
    });

    test('a connect succeeds for the provider that was tapped', () async {
      bloc.add(const SocialConnectEvent.requested(SocialProvider.google));
      await pump();
      expect(repo.connected, [SocialProvider.google]);
      expect(bloc.state.state, RequestState.loaded);
      expect(bloc.state.provider, SocialProvider.google);
    });

    test('the server\'s refusal comes through in its own words', () async {
      repo.result = const Left(
        ServerFailure(
          'That Google account belongs to another member.',
          code: 'SOCIAL_ALREADY_LINKED',
        ),
      );
      bloc.add(const SocialConnectEvent.requested(SocialProvider.google));
      await pump();
      expect(bloc.state.state, RequestState.error);
      expect(bloc.state.message, contains('another member'));
    });

    test('closing the provider sheet is silent', () async {
      repo.result = const Left(CancelledFailure());
      bloc.add(const SocialConnectEvent.requested(SocialProvider.apple));
      await pump();
      expect(bloc.state.state, RequestState.empty);
      expect(bloc.state.message, isEmpty);
    });

    test('reset clears the outcome', () async {
      bloc.add(const SocialConnectEvent.requested(SocialProvider.google));
      await pump();
      bloc.add(const SocialConnectEvent.reset());
      await pump();
      expect(bloc.state, SocialConnectState.initial());
    });
  });

  group('the Connect row', () {
    Future<void> pumpRow(
      WidgetTester tester, {
      required bool connected,
      bool busy = false,
      VoidCallback? onConnect,
    }) => tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: ConnectAccountRow(
            provider: SocialProvider.google,
            connected: connected,
            busy: busy,
            onConnect: onConnect ?? () {},
          ),
        ),
      ),
    );

    testWidgets('not linked: a Connect pill that asks', (tester) async {
      var taps = 0;
      await pumpRow(tester, connected: false, onConnect: () => taps++);
      expect(find.text('Google account'), findsOneWidget);
      await tester.tap(find.text('Connect'));
      expect(taps, 1);
    });

    testWidgets('linked: says Connected and offers nothing', (tester) async {
      await pumpRow(tester, connected: true);
      expect(find.text('Connected'), findsOneWidget);
      expect(find.text('Connect'), findsNothing);
    });

    testWidgets('in flight: a spinner instead of the pill', (tester) async {
      await pumpRow(tester, connected: false, busy: true);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Connect'), findsNothing);
    });
  });
}
