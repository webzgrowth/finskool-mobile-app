import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';
import 'package:finskool/src/domain/model/transaction/transactions_page.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';
import 'package:finskool/src/domain/repository/transactions_repository.dart';
import 'package:finskool/src/domain/usecases/community/download_invoice.dart';
import 'package:finskool/src/domain/usecases/transactions/get_transactions.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/bloc/transactions/list/transactions_bloc.dart';
import 'package:finskool/src/presentation/pages/transactions/detail/transaction_detail_screen.dart';
import 'package:finskool/src/presentation/pages/transactions/transactions_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';
import 'support/transaction_fixtures.dart';

class _NoInvoices implements InvoiceRepository {
  @override
  Future<Either<Failure, InvoiceFile>> download(String invoiceId) async =>
      const Left(ServerFailure('No invoice.'));

  @override
  Future<Either<Failure, InvoiceFile>> downloadFromPath(String path) async =>
      const Left(ServerFailure('No invoice.'));
}

/// Answers each page number from [pages]; a missing one fails.
class _Repo implements TransactionsRepository {
  _Repo(this.pages);
  Map<int, Either<Failure, TransactionsPage>> pages;
  final asked = <int>[];

  @override
  Future<Either<Failure, TransactionsPage>> getTransactions(int page) async {
    asked.add(page);
    return pages[page] ?? const Left(ServerFailure('No such page.'));
  }
}

TransactionsPage _page(int page, int of, List<TransactionModel> items) =>
    TransactionsPage(items: items, page: page, totalPages: of);

/// The subtitle holds no-break spaces so it wraps before the date.
String _plain(String s) => s.replaceAll('\u00A0', ' ');

void main() {
  setUpAll(loadAppFonts);

  group('TransactionModel', () {
    test('a paid community plan reads the way Figma draws it', () {
      final t = txn();
      expect(t.kind, TransactionKind.community);
      expect(t.isPaid, isTrue);
      expect(t.amountLabel, '₹11,999');
      expect(_plain(t.subtitle), 'Yearly  ·  13 Nov 2026');
      expect(t.invoiceNumber, 'FS/2026-27/0184');
      expect(t.planDuration, '12 months');
    });

    test("the invoice's downloadPath is kept as the server sent it", () {
      expect(txn().invoicePath, '/api/v1/payments/receipts/a127b/download');
      expect(txn(status: 'failed').invoicePath, isNull);
    });

    test('a host-rooted path is not given the /api/v1 prefix twice', () {
      final url = Api.fromHostRoot(txn().invoicePath!);
      expect(url, endsWith('/api/v1/payments/receipts/a127b/download'));
      expect(url, isNot(contains('/api/v1/api/v1')));
      expect(Uri.parse(url).host, Uri.parse(Api.baseUrl).host);
    });

    test('the date is shown in IST, not UTC', () {
      // 20:30 UTC is already the next day in India.
      final t = TransactionModel.fromJson(
        txnJson(occurredAt: '2026-11-13T20:30:00.000Z'),
      );
      expect(_plain(t.subtitle), 'Yearly  ·  14 Nov 2026');
    });

    test('a service shows its request and quote', () {
      final t = txn(kind: 'service', reference: 'SR-12 · Quote 1');
      expect(t.descriptor, 'SR-12 · Quote 1');
      expect(_plain(t.subtitle), 'SR-12 · Quote 1  ·  13 Nov 2026');
    });

    test('with no plan name the duration stands in, and with neither, only the date', () {
      expect(_plain(txn(planName: null).subtitle), '12 months  ·  13 Nov 2026');
      final bare = TransactionModel.fromJson(
        txnJson(planName: null, planMonths: null),
      );
      expect(_plain(bare.subtitle), '13 Nov 2026');
    });

    test('paise appear only when there are some', () {
      expect(txn(amount: 1180.5).amountLabel, '₹1,180.50');
      expect(txn(amount: 750).amountLabel, '₹750');
    });

    test('payment methods get a label; none stays none', () {
      String? label(String? m) =>
          TransactionModel.fromJson(txnJson(method: m)).methodLabel;
      expect(label('card'), 'Card');
      expect(label('upi'), 'UPI');
      expect(label('netbanking'), 'Net banking');
      expect(label(null), isNull);
    });

    test('flagged is its own status and an unknown one is not a success', () {
      expect(txn(status: 'flagged').isFlagged, isTrue);
      expect(txn(status: 'refunded').isFlagged, isTrue);
      expect(txn(status: 'failed').isFailed, isTrue);
    });

    test('a page knows whether another follows', () {
      final p = TransactionsPage.fromJson({
        'items': [txnJson()],
        'page': 1,
        'pageSize': 20,
        'total': 42,
        'totalPages': 3,
      });
      expect(p.items, hasLength(1));
      expect(p.hasMore, isTrue);
      expect(_page(3, 3, const []).hasMore, isFalse);
    });
  });

  group('TransactionsBloc', () {
    Future<void> pump() => Future<void>.delayed(Duration.zero);
    Future<void> settle() async {
      for (var i = 0; i < 4; i++) {
        await pump();
      }
    }

    TransactionsBloc make(_Repo repo) {
      final bloc = TransactionsBloc(GetTransactions(repo));
      addTearDown(bloc.close);
      return bloc;
    }

    test('loads, then fails with the server\'s words', () async {
      final repo = _Repo({
        1: Right(_page(1, 1, [txn()])),
      });
      final bloc = make(repo)..add(const TransactionsEvent.load());
      await settle();
      expect(bloc.state.state.isLoaded, isTrue);
      expect(bloc.state.transactions, hasLength(1));
      expect(bloc.state.hasMore, isFalse);

      repo.pages = {1: const Left(ServerFailure('Down for maintenance.'))};
      bloc.add(const TransactionsEvent.load());
      await settle();
      expect(bloc.state.state.isError, isTrue);
      expect(bloc.state.message, 'Down for maintenance.');
    });

    test('loadMore appends the next page and skips a repeated row', () async {
      final repo = _Repo({
        1: Right(_page(1, 2, [txn(id: 'a'), txn(id: 'b')])),
        // 'b' slid down a page because a payment arrived meanwhile.
        2: Right(_page(2, 2, [txn(id: 'b'), txn(id: 'c')])),
      });
      final bloc = make(repo)..add(const TransactionsEvent.load());
      await settle();
      expect(bloc.state.hasMore, isTrue);

      bloc.add(const TransactionsEvent.loadMore());
      await settle();
      expect(bloc.state.transactions.map((t) => t.id), ['a', 'b', 'c']);
      expect(bloc.state.hasMore, isFalse);

      // Nothing further to ask for.
      bloc.add(const TransactionsEvent.loadMore());
      await settle();
      expect(repo.asked, [1, 2]);
    });

    test('a failed next page keeps the rows and says why', () async {
      final repo = _Repo({
        1: Right(_page(1, 2, [txn(id: 'a')])),
      });
      final bloc = make(repo)..add(const TransactionsEvent.load());
      await settle();
      bloc.add(const TransactionsEvent.loadMore());
      await settle();
      expect(bloc.state.state.isLoaded, isTrue);
      expect(bloc.state.transactions, hasLength(1));
      expect(bloc.state.message, 'No such page.');
      expect(bloc.state.hasMore, isTrue);
      expect(bloc.state.isLoadingMore, isFalse);
    });

    test('a failed refresh keeps the rows already on screen', () async {
      final repo = _Repo({
        1: Right(_page(1, 1, [txn()])),
      });
      final bloc = make(repo)..add(const TransactionsEvent.load());
      await settle();
      repo.pages = {1: const Left(ServerFailure('No internet connection.'))};
      bloc.add(const TransactionsEvent.refresh());
      await settle();
      expect(bloc.state.state.isLoaded, isTrue);
      expect(bloc.state.transactions, hasLength(1));
      expect(bloc.state.message, 'No internet connection.');
      expect(bloc.state.isRefreshing, isFalse);
    });

    test('a refresh starts again from page one', () async {
      final repo = _Repo({
        1: Right(_page(1, 2, [txn(id: 'a')])),
        2: Right(_page(2, 2, [txn(id: 'b')])),
      });
      final bloc = make(repo)..add(const TransactionsEvent.load());
      await settle();
      bloc.add(const TransactionsEvent.loadMore());
      await settle();
      expect(bloc.state.transactions, hasLength(2));
      bloc.add(const TransactionsEvent.refresh());
      await settle();
      expect(bloc.state.transactions.map((t) => t.id), ['a']);
      expect(bloc.state.page, 1);
      expect(bloc.state.hasMore, isTrue);
    });
  });

  group('screen', () {
    Future<void> show(WidgetTester tester, List<TransactionModel> rows) async {
      final bloc = TransactionsBloc(
        GetTransactions(_Repo({1: Right(_page(1, 1, rows))})),
      )..add(const TransactionsEvent.load());
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

    testWidgets('paid, failed and under-review rows each say what they are', (
      tester,
    ) async {
      tester.view.physicalSize = const Size(750, 2400);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      await show(tester, sampleTransactions());
      expect(find.text('Transaction history'), findsOneWidget);
      expect(find.text('Paid'), findsOneWidget);
      expect(find.text('Failed'), findsOneWidget);
      expect(find.text('Under review'), findsOneWidget);
      expect(find.text('FS/2026-27/0184'), findsOneWidget);
      expect(find.text('Download'), findsOneWidget);
      expect(find.text('Card expired'), findsOneWidget);
      expect(
        find.textContaining('You do not need to pay again'),
        findsOneWidget,
      );
      expect(find.text('₹25,000'), findsOneWidget);
    });

    testWidgets('no payments says so', (tester) async {
      await show(tester, const []);
      expect(find.text('You have no payments yet.'), findsOneWidget);
    });

    testWidgets('the detail shows only fields the API sent', (tester) async {
      tester.view.physicalSize = const Size(750, 1800);
      tester.view.devicePixelRatio = 2;
      addTearDown(tester.view.reset);
      final failed = sampleTransactions()[1];
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: BlocProvider(
            create: (_) => InvoiceDownloadBloc(DownloadInvoice(_NoInvoices())),
            child: TransactionDetailView(transaction: failed),
          ),
        ),
      );
      await tester.pump();
      expect(find.text('Attempted on'), findsOneWidget);
      expect(find.text('Request'), findsOneWidget);
      expect(find.text('Card'), findsOneWidget);
      expect(find.text('pay_Rt1'), findsOneWidget);
      // A failed payment has no invoice, plan or duration.
      expect(find.text('Invoice'), findsNothing);
      expect(find.text('Plan'), findsNothing);
      expect(find.text('Duration'), findsNothing);
      expect(find.text('Download Invoice'), findsNothing);
    });
  });
}
