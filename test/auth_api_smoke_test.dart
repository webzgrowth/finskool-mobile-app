@Tags(['network'])
library;

import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/storage_keys.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/data/datasource/auth_remote_datasource.dart';
import 'package:finskool/src/data/datasource/password_reset_remote_datasource.dart';
import 'package:finskool/src/data/repository/auth_repository_impl.dart';
import 'package:finskool/src/data/repository/password_reset_repository_impl.dart';
import 'package:finskool/src/utilities/shared_pref_helper.dart';

/// Hits the real backend. Run explicitly:
///   flutter test test/auth_api_smoke_test.dart
void main() {
  late AuthRepositoryImpl auth;
  late PasswordResetRepositoryImpl reset;

  setUp(() async {
    TestWidgetsFlutterBinding.ensureInitialized();
    // flutter_test installs an HttpClient that refuses real requests; this
    // suite deliberately talks to the live backend.
    HttpOverrides.global = null;
    SharedPreferences.setMockInitialValues({});
    await SharedPreferenceHelper().init();
    final client = ApiClient();
    auth = AuthRepositoryImpl(AuthRemoteDatasource(client));
    reset = PasswordResetRepositoryImpl(PasswordResetRemoteDatasource(client));
  });

  test('bad credentials surface the server message, not a generic one',
      () async {
    final result = await auth.login(
      email: 'no-such-user-check@example.com',
      password: 'WrongPass123!',
    );
    final failure = result.fold((l) => l, (r) => null);
    expect(failure, isA<ServerFailure>());
    expect(failure!.message, contains('Invalid email or password'));
    expect(auth.hasSession, isFalse, reason: 'no cookie on a failed login');
  });

  test('422 becomes a ValidationFailure with per-field messages', () async {
    final result = await auth.login(email: 'not-an-email', password: '');
    final failure = result.fold((l) => l, (r) => null);
    expect(failure, isA<ValidationFailure>());
    expect((failure! as ValidationFailure).forField('email'), isNotNull);
  });

  test('unknown userId on verify-otp fails without throwing', () async {
    final result = await auth.verifyOtp(
      userId: '00000000-0000-0000-0000-000000000000',
      otp: '000000',
    );
    expect(result.isLeft(), isTrue);
  });

  test('forgot-password succeeds even for an unknown email', () async {
    final result = await reset.sendResetCode('no-such-user-check@example.com');
    expect(result.isRight(), isTrue,
        reason: 'documented anti-enumeration behaviour');
  });

  test('no session cookie is stored anywhere along the way', () async {
    await auth.login(email: 'a@b.com', password: 'x');
    expect(
      SharedPreferenceHelper().getdata(StorageKeys.sessionCookie),
      isNull,
    );
  });
}
