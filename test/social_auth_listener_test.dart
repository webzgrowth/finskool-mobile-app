import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/routes.dart';
import 'package:finskool/src/domain/model/auth/auth_session_model.dart';
import 'package:finskool/src/domain/model/auth/social_models.dart';
import 'package:finskool/src/domain/repository/auth_repository.dart';
import 'package:finskool/src/domain/repository/social_auth_repository.dart';
import 'package:finskool/src/domain/usecases/auth/resend_otp.dart';
import 'package:finskool/src/domain/usecases/social/link_social_account.dart';
import 'package:finskool/src/domain/usecases/social/request_social_phone.dart';
import 'package:finskool/src/domain/usecases/social/social_sign_in.dart';
import 'package:finskool/src/domain/usecases/social/verify_social_otp.dart';
import 'package:finskool/src/presentation/bloc/authentication/social_auth/social_auth_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/widgets/social_auth_listener.dart';

class _Social implements SocialAuthRepository {
  _Social(this.login);
  Either<Failure, SocialLoginResult> login;

  @override
  Future<Either<Failure, SocialLoginResult>> signIn(SocialProvider p) async =>
      login;

  @override
  Future<Either<Failure, AuthSessionModel>> link({
    required String linkToken,
    required String password,
  }) async => throw UnimplementedError();

  @override
  Future<Either<Failure, SocialOtpChallenge>> requestPhone({
    required String signupToken,
    required String phone,
    String? fullName,
  }) async => const Right(
    SocialOtpChallenge(otpToken: 'ot', phone: '+91', expiresInSeconds: 600),
  );

  @override
  Future<Either<Failure, AuthSessionModel>> verifyOtp({
    required String otpToken,
    required String otp,
  }) async => throw UnimplementedError();
}

class _Auth implements AuthRepository {
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

/// Pins the navigation a social sign-in produces, in particular that "send
/// again" from the code screen doesn't stack a second phone screen.
void main() {
  Future<(SocialAuthBloc, GoRouter)> pumpApp(
    WidgetTester tester,
    SocialLoginResult login,
  ) async {
    final repo = _Social(Right(login));
    final bloc = SocialAuthBloc(
      SocialSignIn(repo),
      LinkSocialAccount(repo),
      RequestSocialPhone(repo),
      VerifySocialOtp(repo),
      ResendOtp(_Auth()),
    );
    addTearDown(bloc.close);
    final router = GoRouter(
      routes: [
        GoRoute(
          path: '/',
          // Mounted inside the route, like `AuthScreen`: it needs a GoRouter.
          builder: (_, _) => const SocialAuthListener(
            child: Scaffold(body: Text('login screen')),
          ),
        ),
        for (final (path, text) in [
          (AppRoutes.GOOGLE_LAST_STEP_ROUTE_PATH, 'phone screen'),
          (AppRoutes.SOCIAL_LINK_ROUTE_PATH, 'link screen'),
          (AppRoutes.SOCIAL_VERIFY_ROUTE_PATH, 'code screen'),
          (AppRoutes.DASHBOARD_ROUTE_PATH, 'dashboard'),
        ])
          GoRoute(
            path: path,
            builder: (_, _) => Scaffold(body: Text(text)),
          ),
      ],
    );
    await tester.pumpWidget(
      BlocProvider.value(
        value: bloc,
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    return (bloc, router);
  }

  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 4; i++) {
      await tester.pump(const Duration(milliseconds: 100));
    }
  }

  testWidgets('already linked goes straight to the dashboard', (tester) async {
    final (bloc, _) = await pumpApp(
      tester,
      SocialLoginResult(
        status: SocialStatus.loggedIn,
        session: AuthSessionModel.fromJson({
          'user': {
            'id': 'u',
            'name': 'A',
            'email': 'a@b.co',
            'phone': '+91',
            'role': 'member',
          },
        }),
      ),
    );
    bloc.add(const SocialAuthEvent.signIn(SocialProvider.google));
    await settle(tester);
    expect(find.text('dashboard'), findsOneWidget);
    expect(bloc.state.step, SocialStep.idle, reason: 'wiped after finishing');
    // `reset` also cancels the resend timer; `close()` itself can't be
    // awaited under the test's fake clock.
    bloc.add(const SocialAuthEvent.reset());
    await tester.pump();
  });

  testWidgets('an existing account opens the password screen', (tester) async {
    final (bloc, _) = await pumpApp(
      tester,
      const SocialLoginResult(
        status: SocialStatus.linkRequired,
        linkToken: 'li',
        email: 'a@b.co',
      ),
    );
    bloc.add(const SocialAuthEvent.signIn(SocialProvider.google));
    await settle(tester);
    expect(find.text('link screen'), findsOneWidget);
    // `reset` also cancels the resend timer; `close()` itself can't be
    // awaited under the test's fake clock.
    bloc.add(const SocialAuthEvent.reset());
    await tester.pump();
  });

  testWidgets('send again from the code screen opens it once more, and the '
      'phone screen is not stacked twice', (tester) async {
    final (bloc, router) = await pumpApp(
      tester,
      const SocialLoginResult(
        status: SocialStatus.phoneRequired,
        signupToken: 'su',
        name: 'Asha',
      ),
    );
    bloc
      ..add(const SocialAuthEvent.signIn(SocialProvider.google))
      ..add(const SocialAuthEvent.phoneChanged('9876543210'));
    await settle(tester);
    expect(find.text('phone screen'), findsOneWidget);

    bloc.add(const SocialAuthEvent.sendCode());
    await settle(tester);
    expect(find.text('code screen'), findsOneWidget);

    // "Change": back to the phone screen, then send again.
    router.pop();
    await settle(tester);
    expect(find.text('phone screen'), findsOneWidget);
    bloc.add(const SocialAuthEvent.sendCode());
    await settle(tester);
    expect(find.text('code screen'), findsOneWidget);

    router.pop();
    await settle(tester);
    expect(find.text('phone screen'), findsOneWidget);
    router.pop();
    await settle(tester);
    expect(find.text('login screen'), findsOneWidget);
    // `reset` also cancels the resend timer; `close()` itself can't be
    // awaited under the test's fake clock.
    bloc.add(const SocialAuthEvent.reset());
    await tester.pump();
  });
}
