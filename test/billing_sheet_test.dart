import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/domain/usecases/services/get_gst_states.dart';
import 'package:finskool/src/domain/usecases/services/get_last_billing.dart';
import 'package:finskool/src/domain/usecases/services/remember_billing.dart';
import 'package:finskool/src/domain/usecases/services/start_service_payment.dart';
import 'package:finskool/src/domain/usecases/services/verify_service_payment.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/presentation/bloc/services/payment/service_payment_bloc.dart';
import 'package:finskool/src/presentation/pages/services/chat/widgets/billing_sheet.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _Repo implements ServicesRepository {
  BillingDetails? remembered;
  @override
  Future<Either<Failure, List<GstState>>> getGstStates() async => const Right([
    GstState(code: '27', name: 'Maharashtra'),
    GstState(code: '29', name: 'Karnataka'),
  ]);
  @override
  BillingDetails? get lastBilling => remembered;
  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

void main() {
  setUpAll(loadAppFonts);

  final quote = ServiceQuoteModel(
    id: 'q',
    requestId: 'r',
    version: 1,
    baseAmount: 10000,
    gstRatePercent: 18,
    gstAmount: 1800,
    totalAmount: 11800,
    status: ServiceQuoteStatus.active,
    expiresAt: DateTime(2030),
  );

  Future<Future<BillingDetails?> Function()> open(
    WidgetTester tester,
    _Repo repo,
    Map<String, String> errors,
  ) async {
    final bloc = ServicePaymentBloc(
      GetGstStates(repo),
      StartServicePayment(repo),
      VerifyServicePayment(repo),
      GetLastBilling(repo),
      RememberBilling(repo),
    );
    addTearDown(bloc.close);
    BillingDetails? result;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: BlocProvider.value(
          value: bloc,
          child: Builder(
            builder: (context) => Scaffold(
              body: TextButton(
                onPressed: () async => result = await showBillingSheet(
                  context,
                  quote: quote,
                  initialName: 'Priya',
                  initial: repo.remembered,
                  errors: errors,
                ),
                child: const Text('open'),
              ),
            ),
          ),
        ),
      ),
    );
    return () async => result;
  }

  Future<void> pickState(WidgetTester tester, String name) async {
    await tester.tap(find.text('State').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text(name).last);
    await tester.pumpAndSettle();
  }

  testWidgets(
    'a GSTIN whose first two digits differ from the state is refused',
    (tester) async {
      final result = await open(tester, _Repo(), const {});
      await tester.pump();
      await tester.tap(find.text('open'));
      await tester.pumpAndSettle();
      await pickState(tester, 'Maharashtra');
      await tester.enterText(
        find.widgetWithText(TextField, 'GSTIN (optional)'),
        '29AABCT1332L1ZA', // Karnataka's code, state is Maharashtra (27)
      );
      await tester.tap(find.textContaining('Pay ₹11,800'));
      await tester.pumpAndSettle();
      expect(
        find.textContaining('first two digits must match'),
        findsOneWidget,
      );
      expect(await result(), isNull);
    },
  );

  testWidgets('an empty name and no state each show an error', (tester) async {
    await open(tester, _Repo(), const {});
    await tester.pump();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Name'), '');
    await tester.tap(find.textContaining('Pay ₹11,800'));
    await tester.pumpAndSettle();
    expect(find.text('Enter the billing name.'), findsOneWidget);
    expect(find.text('Choose your state.'), findsOneWidget);
  });

  testWidgets('the server\'s per-field errors are shown when reopened', (
    tester,
  ) async {
    await open(tester, _Repo(), const {'gstin': 'GSTIN is not valid'});
    await tester.pump();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('GSTIN is not valid'), findsOneWidget);
  });

  testWidgets('last-used details are pre-filled', (tester) async {
    final repo = _Repo()
      ..remembered = const BillingDetails(
        name: 'Remembered Name',
        stateCode: '27',
        gstin: '27AABCT1332L1ZA',
        address: '12 MG Road',
      );
    await open(tester, repo, const {});
    await tester.pump();
    await tester.tap(find.text('open'));
    await tester.pumpAndSettle();
    expect(find.text('Remembered Name'), findsOneWidget);
    expect(find.text('27AABCT1332L1ZA'), findsOneWidget);
    expect(find.text('12 MG Road'), findsOneWidget);
    expect(find.text('Maharashtra'), findsOneWidget);
  });
}
