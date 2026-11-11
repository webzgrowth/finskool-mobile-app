import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/repository/password_reset_repository.dart';
import 'package:finskool/src/domain/usecases/password_reset/reset_password.dart';
import 'package:finskool/src/domain/usecases/password_reset/send_reset_code.dart';
import 'package:finskool/src/domain/usecases/password_reset/verify_reset_code.dart';
import 'package:finskool/src/presentation/bloc/authentication/password_reset/password_reset_bloc.dart';
import 'package:finskool/src/presentation/pages/authentication/reset_password/reset_password_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _NoRepo implements PasswordResetRepository {
  @override
  dynamic noSuchMethod(Invocation i) => throw StateError('not called');
}

void main() {
  setUpAll(loadAppFonts);

  Future<PasswordResetBloc> open(WidgetTester tester) async {
    final repo = _NoRepo();
    final bloc = PasswordResetBloc(
      SendResetCode(repo),
      VerifyResetCode(repo),
      ResetPassword(repo),
    );
    addTearDown(bloc.close);
    tester.view.physicalSize = const Size(750, 1600);
    tester.view.devicePixelRatio = 2;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider.value(
          value: bloc,
          child: const ResetPasswordScreen(),
        ),
      ),
    );
    await tester.pump(const Duration(seconds: 1));
    return bloc;
  }

  Future<void> send(WidgetTester tester) async {
    await tester.ensureVisible(find.text('Send Reset Code'));
    await tester.tap(find.text('Send Reset Code'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
  }

  testWidgets('no email: the first tap says "Email is required."', (
    tester,
  ) async {
    await open(tester);
    await send(tester);
    expect(find.text('Email is required.'), findsOneWidget);
  });

  testWidgets('typed then cleared: tapping again says it again', (
    tester,
  ) async {
    await open(tester);
    await send(tester);
    await tester.enterText(find.byType(TextField), 'a');
    await tester.pump();
    expect(find.text('Email is required.'), findsNothing);
    await tester.enterText(find.byType(TextField), '');
    await tester.pump();
    await send(tester);
    expect(find.text('Email is required.'), findsOneWidget);
  });
}
