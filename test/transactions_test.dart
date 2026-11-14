import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/transactions_demo_datasource.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';
import 'package:finskool/src/domain/usecases/community/download_invoice.dart';
import 'package:finskool/src/domain/usecases/transactions/get_transactions.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/bloc/transactions/list/transactions_bloc.dart';
import 'package:finskool/src/presentation/pages/transactions/transactions_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

class _NoInvoices implements InvoiceRepository {
  @override
  Future<Either<Failure, InvoiceFile>> download(String invoiceId) async =>
      const Left(ServerFailure('No invoice.'));
}

class _Repo implements TransactionsRepository {
  _Repo(this.result);
  Either<Failure, List<TransactionModel>> result;

  @override
  Future<Either<Failure, List<TransactionModel>>> getTransactions() async =>
      result;
}

TransactionModel _t({
  TransactionStatus status = TransactionStatus.paid,
  int amount = 14999,
}) => TransactionModel(
  id: 'a',
  kind: TransactionKind.community,
  glyph: TransactionGlyph.investor,
  title: 'Investor Community',
  descriptor: 'Yearly',
  date: DateTime(2026, 5, 12),
  amount: amount,
  status: status,
  invoiceNumber: 'INV-2026-0189',
);

void main() {
  setUpAll(loadAppFonts);

  group('TransactionModel', () {
    test('amount and subtitle read the way Figma draws them', () {
      expect(_t().amountLabel, '₹14,999');
      expect(_t(amount: 750).amountLabel, '₹750');
      expect(_t(amount: 25000).amountLabel, '₹25,000');
      expect(_t().subtitle, 'Yearly  ·  12 May 2026');
    });

    test('fromJson is the shape the real endpoint should map onto', () {
      final m = TransactionModel.fromJson({
        'id': 'x',
        'kind': 'service',
        'glyph': 'briefcase',
        'title': 'Intelligent Model Portfolio',
        'descriptor': 'Quote Q-0987',
        'date': '2026-06-20',
        'amount': 25000,
        'status': 'failed',
        'failureReason': 'Declined by bank. No money was deducted.',
      });
      expect(m.kind, TransactionKind.service);
      expect(m.glyph, TransactionGlyph.briefcase);
      expect(m.isFailed, isTrue);
      expect(m.invoiceNumber, isNull);
    });

    test('an unknown glyph falls back instead of failing the list', () {
      final m = TransactionModel.fromJson({
        'id': 'x',
        'glyph': 'spaceship',
        'date': '2026-06-20',
        'amount': 1,
      });
      expect(m.glyph, TransactionGlyph.pie);
    });
  });

  test("the demo data is Figma's seven rows, one of them failed", () async {
    final rows = await TransactionsDemoDatasource().getTransactions();
    expect(rows, hasLength(7));
    expect(rows.where((r) => r.isFailed), hasLength(1));
    expect(rows.first.invoiceNumber, 'INV-2026-0511');
    expect(rows.every((r) => r.invoiceId == null), isTrue);
  });

  group('TransactionsBloc', () {
    Future<void> pump() => Future<void>.delayed(Duration.zero);

    test('loads, then fails with the server\'s words', () async {
      final repo = _Repo(Right([_t()]));
      final bloc = TransactionsBloc(GetTransactions(repo));
      addTearDown(bloc.close);
      bloc.add(const TransactionsEvent.load());
      await pump();
      await pump();
      expect(bloc.state.state.isLoaded, isTrue);
      expect(bloc.state.transactions, hasLength(1));

      repo.result = const Left(ServerFailure('Down for maintenance.'));
      bloc.add(const TransactionsEvent.load());
      await pump();
      await pump();
      expect(bloc.state.state.isError, isTrue);
      expect(bloc.state.message, 'Down for maintenance.');
    });

    test('a failed refresh keeps the rows already on screen', () async {
      final repo = _Repo(Right([_t()]));
      final bloc = TransactionsBloc(GetTransactions(repo));
      addTearDown(bloc.close);
      bloc.add(const TransactionsEvent.load());
      await pump();
      await pump();
      repo.result = const Left(ServerFailure('No internet connection.'));
      bloc.add(const TransactionsEvent.refresh());
      await pump();
      await pump();
      expect(bloc.state.state.isLoaded, isTrue);
      expect(bloc.state.transactions, hasLength(1));
      expect(bloc.state.message, 'No internet connection.');
    });
  });

  group('screen', () {
    Future<void> show(WidgetTester tester, List<TransactionModel> rows) async {
      final bloc = TransactionsBloc(GetTransactions(_Repo(Right(rows))))
        ..add(const TransactionsEvent.load());
      final invoices = InvoiceDownloadBloc(DownloadInvoice(_NoInvoices()));
      addTearDown(bloc.close);
      addTearDown(invoices.close);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: MultiBlocProvider(
            providers: [
              BlocProvider.value(value: bloc),
              BlocProvider.value(value: invoices),
            ],
            child: const TransactionsView(),
          ),
        ),
      );
      await tester.pump();
      await tester.pump();
    }

    testWidgets('a paid row shows the invoice, a failed one the reason', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(750, 2000);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await show(tester, [
        _t(),
        TransactionModel(
          id: 'f',
          kind: TransactionKind.community,
          glyph: TransactionGlyph.education,
          title: 'Finskool21 Academy Community',
          descriptor: 'Quarterly',
          date: DateTime(2026, 8, 14),
          amount: 4999,
          status: TransactionStatus.failed,
          failureReason: 'Declined by bank. No money was deducted.',
        ),
      ]);
      expect(find.text('Transaction history'), findsOneWidget);
      expect(find.text('Paid'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
      expect(find.text('INV-2026-0189'), findsOneWidget);
      expect(find.text('Download'), findsOneWidget);
      expect(
        find.text('Declined by bank. No money was deducted.'),
        findsOneWidget,
      );
      expect(
        find.text('Invoices are also sent to your registered email.'),
        findsOneWidget,
      );
    });

    testWidgets('no payments says so', (tester) async {
      await show(tester, const []);
      expect(find.text('You have no payments yet.'), findsOneWidget);
    });
  });
}
