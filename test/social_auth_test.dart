import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/failure.dart';
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

const _user = {
  'id': 'u1',
  'name': 'Asha Rao',
  'email': 'asha@example.com',
  'phone': '+919876543210',
  'role': 'member',
};

class _FakeSocial implements SocialAuthRepository {
  Either<Failure, SocialLoginResult> signInResult = const Right(
    SocialLoginResult(status: SocialStatus.phoneRequired, signupToken: 'su'),
  );
  Either<Failure, AuthSessionModel>? linkResult;
  Either<Failure, SocialOtpChallenge> phoneResult = const Right(
    SocialOtpChallenge(
      otpToken: 'ot',
      phone: '+919876543210',
      expiresInSeconds: 600,
    ),
  );
  Either<Failure, AuthSessionModel>? verifyResult;
  final calls = <String>[];
  String? lastPhone;
  String? lastName;

  @override
  Future<Either<Failure, SocialLoginResult>> signIn(
    SocialProvider provider,
  ) async {
    calls.add('signIn:${provider.name}');
    return signInResult;
  }

  @override
  Future<Either<Failure, AuthSessionModel>> link({
    required String linkToken,
    required String password,
  }) async {
    calls.add('link:$linkToken:$password');
    return linkResult!;
  }

  @override
  Future<Either<Failure, SocialOtpChallenge>> requestPhone({
    required String signupToken,
    required String phone,
    String? fullName,
  }) async {
    calls.add('phone');
    lastPhone = phone;
    lastName = fullName;
    return phoneResult;
  }

  @override
  Future<Either<Failure, AuthSessionModel>> verifyOtp({
    required String otpToken,
    required String otp,
  }) async {
    calls.add('verify:$otpToken:$otp');
    return verifyResult!;
  }
}

class _FakeAuth implements AuthRepository {
  Either<Failure, Unit> resendResult = const Right(unit);
  String? resentTo;

  @override
  Future<Either<Failure, Unit>> resendOtp(String userId) async {
    resentTo = userId;
    return resendResult;
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

AuthSessionModel _session() =>
    AuthSessionModel.fromJson({'user': _user, 'communities': []});

Future<void> pump([int ms = 30]) =>
    Future<void>.delayed(Duration(milliseconds: ms));

void main() {
  group('SocialLoginResult.fromJson', () {
    test('logged_in carries the same session body as a password login', () {
      final r = SocialLoginResult.fromJson({
        'status': 'logged_in',
        'user': _user,
        'communities': [],
      });
      expect(r.status, SocialStatus.loggedIn);
      expect(r.session!.user.email, 'asha@example.com');
    });

    test('phone_required and link_required carry their tokens', () {
      final phone = SocialLoginResult.fromJson({
        'status': 'phone_required',
        'signupToken': 'su',
        'email': 'a@b.co',
        'name': null,
      });
      expect(phone.status, SocialStatus.phoneRequired);
      expect(phone.signupToken, 'su');
      expect(phone.name, isNull);

      final link = SocialLoginResult.fromJson({
        'status': 'link_required',
        'linkToken': 'li',
        'email': 'a@b.co',
      });
      expect(link.status, SocialStatus.linkRequired);
      expect(link.linkToken, 'li');
    });

    test('a blank name counts as no name; an unknown status is an error', () {
      expect(
        SocialLoginResult.fromJson({'status': 'phone_required', 'name': '  '})
            .name,
        isNull,
      );
      expect(
        () => SocialLoginResult.fromJson({'status': 'teleport'}),
        throwsA(isA<ApiException>()),
      );
    });
  });

  group('SocialAuthBloc', () {
    late _FakeSocial social;
    late _FakeAuth auth;
    late SocialAuthBloc bloc;

    setUp(() {
      social = _FakeSocial();
      auth = _FakeAuth();
      bloc = SocialAuthBloc(
        SocialSignIn(social),
        LinkSocialAccount(social),
        RequestSocialPhone(social),
        VerifySocialOtp(social),
        ResendOtp(auth),
      );
      addTearDown(bloc.close);
    });

    Future<void> send(SocialAuthEvent e) async {
      bloc.add(e);
      await pump();
    }

    test('already linked: logged in, nothing else asked', () async {
      social.signInResult = Right(
        SocialLoginResult(status: SocialStatus.loggedIn, session: _session()),
      );
      await send(const SocialAuthEvent.signIn(SocialProvider.google));
      expect(bloc.state.step, SocialStep.done);
      expect(social.calls, ['signIn:google']);
    });

    test('closing the sheet is silent', () async {
      social.signInResult = const Left(CancelledFailure());
      await send(const SocialAuthEvent.signIn(SocialProvider.apple));
      expect(bloc.state.step, SocialStep.idle);
      expect(bloc.state.state, RequestState.empty);
      expect(bloc.state.message, isEmpty);
    });

    test('a failed sign-in shows the server\'s own words', () async {
      social.signInResult = const Left(
        ServerFailure('Social login is not available.', code: 'X'),
      );
      await send(const SocialAuthEvent.signIn(SocialProvider.google));
      expect(bloc.state.state, RequestState.error);
      expect(bloc.state.message, 'Social login is not available.');
    });

    group('new member', () {
      setUp(() async {
        social.signInResult = const Right(
          SocialLoginResult(
            status: SocialStatus.phoneRequired,
            signupToken: 'su',
            email: 'asha@example.com',
          ),
        );
        await send(const SocialAuthEvent.signIn(SocialProvider.google));
      });

      test('asks for the name only when the provider gave none', () {
        expect(bloc.state.step, SocialStep.phoneRequired);
        expect(bloc.state.needsName, isTrue);
      });

      test('a bad number or missing name never reaches the API', () async {
        await send(const SocialAuthEvent.phoneChanged('123'));
        await send(const SocialAuthEvent.sendCode());
        expect(bloc.state.phoneError, isNotNull);
        expect(bloc.state.nameError, isNotNull);
        expect(social.calls, ['signIn:google']);
      });

      test('sends the code, then confirms it and logs in', () async {
        await send(const SocialAuthEvent.nameChanged('Asha Rao'));
        await send(const SocialAuthEvent.phoneChanged('9876543210'));
        await send(const SocialAuthEvent.sendCode());
        expect(social.lastPhone, '+919876543210');
        expect(social.lastName, 'Asha Rao');
        expect(bloc.state.step, SocialStep.codeSent);
        expect(bloc.state.resendSeconds, 60);
        expect(bloc.state.otpToken, 'ot');

        social.verifyResult = Right(_session());
        await send(const SocialAuthEvent.otpChanged('123456'));
        await send(const SocialAuthEvent.verify());
        expect(social.calls.last, 'verify:ot:123456');
        expect(bloc.state.step, SocialStep.done);
        // Everything sensitive goes with the finished flow.
        expect(bloc.state.otpToken, isNull);
        expect(bloc.state.signupToken, isNull);
        expect(bloc.state.phone, isEmpty);
      });

      test(
        'a wrong code is drawn under the boxes, not as a snackbar',
        () async {
          await send(const SocialAuthEvent.nameChanged('Asha'));
          await send(const SocialAuthEvent.phoneChanged('9876543210'));
          await send(const SocialAuthEvent.sendCode());
          social.verifyResult = const Left(
            ServerFailure('That code is wrong.', code: 'OTP_INVALID'),
          );
          await send(const SocialAuthEvent.otpChanged('000000'));
          await send(const SocialAuthEvent.verify());
          expect(bloc.state.step, SocialStep.codeSent);
          expect(bloc.state.otpError, 'That code is wrong.');
          expect(bloc.state.message, isEmpty);
        },
      );

      test(
        'sending again after coming back is a visible step change',
        () async {
          await send(const SocialAuthEvent.nameChanged('Asha'));
          await send(const SocialAuthEvent.phoneChanged('9876543210'));
          final steps = <SocialStep>[];
          final sub = bloc.stream.listen((s) => steps.add(s.step));
          addTearDown(sub.cancel);
          await send(const SocialAuthEvent.sendCode());
          await send(const SocialAuthEvent.sendCode());
          // phoneRequired → codeSent, then back to phoneRequired → codeSent:
          // the listener only pushes the code screen on a change.
          expect(steps.where((s) => s == SocialStep.codeSent).length, 2);
          expect(steps, contains(SocialStep.phoneRequired));
        },
      );

      test('NAME_REQUIRED puts the error on the name field', () async {
        social.phoneResult = const Left(
          ServerFailure('Full name is required.', code: 'NAME_REQUIRED'),
        );
        await send(const SocialAuthEvent.nameChanged('A'));
        await send(const SocialAuthEvent.phoneChanged('9876543210'));
        await send(const SocialAuthEvent.sendCode());
        expect(bloc.state.nameRequired, isTrue);
        expect(bloc.state.nameError, 'Full name is required.');
      });

      test('an expired step starts again from login', () async {
        social.phoneResult = const Left(
          ServerFailure('Took too long.', code: 'SOCIAL_STEP_EXPIRED'),
        );
        await send(const SocialAuthEvent.nameChanged('Asha'));
        await send(const SocialAuthEvent.phoneChanged('9876543210'));
        await send(const SocialAuthEvent.sendCode());
        expect(bloc.state.step, SocialStep.restart);
        expect(bloc.state.message, 'Took too long.');
        expect(bloc.state.signupToken, isNull);
      });

      test('resend uses the otpToken and waits for the countdown', () async {
        await send(const SocialAuthEvent.nameChanged('Asha'));
        await send(const SocialAuthEvent.phoneChanged('9876543210'));
        await send(const SocialAuthEvent.sendCode());
        await send(const SocialAuthEvent.resend());
        expect(auth.resentTo, isNull, reason: 'still counting down');
      });
    });

    group('existing account', () {
      setUp(() async {
        social.signInResult = const Right(
          SocialLoginResult(
            status: SocialStatus.linkRequired,
            linkToken: 'li',
            email: 'asha@example.com',
          ),
        );
        await send(const SocialAuthEvent.signIn(SocialProvider.google));
      });

      test('needs a password before it calls', () async {
        await send(const SocialAuthEvent.link());
        expect(bloc.state.passwordError, isNotNull);
        expect(social.calls, ['signIn:google']);
      });

      test('wrong password shows under the field and keeps the step', () async {
        social.linkResult = const Left(
          ServerFailure(
            'Wrong password.',
            code: 'SOCIAL_LINK_PASSWORD_INVALID',
          ),
        );
        await send(const SocialAuthEvent.passwordChanged('nope'));
        await send(const SocialAuthEvent.link());
        expect(bloc.state.step, SocialStep.linkRequired);
        expect(bloc.state.passwordError, 'Wrong password.');
        expect(bloc.state.message, isEmpty);
      });

      test('five wrong passwords lock the token: start again', () async {
        social.linkResult = const Left(
          ServerFailure('Locked.', code: 'SOCIAL_LINK_LOCKED'),
        );
        await send(const SocialAuthEvent.passwordChanged('nope'));
        await send(const SocialAuthEvent.link());
        expect(bloc.state.step, SocialStep.restart);
        expect(bloc.state.password, isEmpty);
      });

      test('the right password logs in', () async {
        social.linkResult = Right(_session());
        await send(const SocialAuthEvent.passwordChanged('secret123'));
        await send(const SocialAuthEvent.link());
        expect(social.calls.last, 'link:li:secret123');
        expect(bloc.state.step, SocialStep.done);
        expect(bloc.state.password, isEmpty);
      });
    });

    test('reset wipes the flow', () async {
      await send(const SocialAuthEvent.signIn(SocialProvider.google));
      await send(const SocialAuthEvent.reset());
      expect(bloc.state, SocialAuthState.initial());
    });
  });
}
