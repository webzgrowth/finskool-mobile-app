@Tags(['golden'])
library;

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/datasource/transactions_demo_datasource.dart';
import 'package:finskool/src/domain/usecases/transactions/get_transactions.dart';
import 'package:finskool/src/domain/usecases/community/download_invoice.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/repository/transactions_repository_impl.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/bloc/transactions/list/transactions_bloc.dart';
import 'package:finskool/src/presentation/pages/transactions/detail/transaction_detail_screen.dart';
import 'package:finskool/src/presentation/pages/transactions/transactions_screen.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

/// Renders the list and a detail to `build/transaction_goldens/` for a
/// side-by-side look with Figma's `1809:5414`. Eyeballing, not CI:
/// `flutter test --update-goldens test/transactions_goldens_test.dart`.
void main() {
  setUpAll(loadAppFonts);

  Future<void> shot(WidgetTester t, Widget home, String name, double h) async {
    t.view.physicalSize = Size(375 * 2, h * 2);
    t.view.devicePixelRatio = 2;
    addTearDown(t.view.reset);
    await t.pumpWidget(MaterialApp(theme: AppTheme.light, home: home));
    await t.pump(const Duration(milliseconds: 200));
    await expectLater(
      find.byType(MaterialApp),
      matchesGoldenFile('../build/transaction_goldens/$name.png'),
    );
  }

  testWidgets('list', (t) async {
    final repo = TransactionsRepositoryImpl(TransactionsDemoDatasource());
    final bloc = TransactionsBloc(GetTransactions(repo))
      ..add(const TransactionsEvent.load());
    addTearDown(bloc.close);
    await t.runAsync(() => Future<void>.delayed(Duration.zero));
    await shot(
      t,
      MultiBlocProvider(
        providers: [
          BlocProvider.value(value: bloc),
          BlocProvider<InvoiceDownloadBloc>(create: (_) => _fakeInvoiceBloc()),
        ],
        child: const TransactionsView(),
      ),
      'list',
      1238,
    );
  });

  for (final id in ['txn-0511', 'txn-failed']) {
    testWidgets('detail $id', (t) async {
      final rows = await TransactionsDemoDatasource().getTransactions();
      final row = rows.firstWhere((r) => r.id == id);
      await shot(
        t,
        BlocProvider<InvoiceDownloadBloc>(
          create: (_) => _fakeInvoiceBloc(),
          child: TransactionDetailView(transaction: row),
        ),
        'detail_$id',
        812,
      );
    });
  }
}

class _NoInvoices implements InvoiceRepository {
  @override
  Future<Either<Failure, InvoiceFile>> download(String invoiceId) async =>
      const Left(ServerFailure('No invoice.'));
}

InvoiceDownloadBloc _fakeInvoiceBloc() =>
    InvoiceDownloadBloc(DownloadInvoice(_NoInvoices()));
