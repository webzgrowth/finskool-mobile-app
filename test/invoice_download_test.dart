import 'dart:async';
import 'dart:typed_data';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/enum.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/community_model.dart';
import 'package:finskool/src/domain/model/community/subscription_info.dart';
import 'package:finskool/src/domain/model/community/subscription_invoice.dart';
import 'package:finskool/src/domain/model/community/community_plan_model.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/repository/invoice_repository.dart';
import 'package:finskool/src/domain/usecases/community/download_invoice.dart';
import 'package:finskool/src/presentation/bloc/communities/invoice/invoice_download_bloc.dart';
import 'package:finskool/src/presentation/pages/communities/subscription_detail/widgets/subscription_transaction_section.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

import 'support/ticket_fakes.dart';

final _file = InvoiceFile(
  fileName: 'a.pdf',
  bytes: Uint8List.fromList([37, 80, 68, 70]),
);

class _Repo implements InvoiceRepository {
  Future<Either<Failure, InvoiceFile>> Function(String) answer = (_) async =>
      Right(_file);
  final asked = <String>[];

  @override
  Future<Either<Failure, InvoiceFile>> download(String invoiceId) {
    asked.add(invoiceId);
    return answer(invoiceId);
  }
}

/// The `invoice` object on a `/auth/mobile/me` community row.
const _row = {
  'id': 'inv-1',
  'number': 'FS/2026-27/0184',
  'issuedAt': '2026-10-04T09:30:00.000Z',
  'amount': 1178.82,
  'currency': 'INR',
  'downloadUrl': 'https://files.test/signed',
  'fileName': 'FS-2026-27-0184.pdf',
};

Future<void> pump() => Future<void>.delayed(const Duration(milliseconds: 20));

void main() {
  setUpAll(loadAppFonts);

  group('SubscriptionInvoice', () {
    test('reads every field of the /me invoice', () {
      final i = SubscriptionInvoice.fromJson(_row)!;
      expect(i.id, 'inv-1');
      expect(i.number, 'FS/2026-27/0184');
      expect(i.amount, 1178.82);
      expect(i.currency, 'INR');
      expect(i.fileName, 'FS-2026-27-0184.pdf');
      expect(i.issuedAt, isNotNull);
      expect(i.downloadUrl, 'https://files.test/signed');
    });

    test(
      'null (an admin-added member) and a row with no id are no invoice',
      () {
        expect(SubscriptionInvoice.fromJson(null), isNull);
        expect(SubscriptionInvoice.fromJson({'number': 'X'}), isNull);
        expect(SubscriptionInvoice.fromJson({'id': ''}), isNull);
      },
    );

    test('the signed link is never written out', () {
      final json = SubscriptionInvoice.fromJson(_row)!.toJson();
      expect(json.containsKey('downloadUrl'), isFalse);
      expect(json['id'], 'inv-1');
    });

    test('a /me community row carries it onto the CommunityModel', () {
      final c = CommunityModel.fromMembershipJson({
        'id': 'c1',
        'name': 'Swing Alpha',
        'expiresAt': '2026-12-01',
        'invoice': _row,
      });
      expect(c.invoice!.number, 'FS/2026-27/0184');
      final none = CommunityModel.fromMembershipJson({
        'id': 'c2',
        'name': 'Free',
        'invoice': null,
      });
      expect(none.invoice, isNull);
    });

    test('copyWith keeps the invoice unless a new one is given', () {
      final c = CommunityModel.fromMembershipJson({
        'id': 'c1',
        'name': 'A',
        'invoice': _row,
      });
      expect(c.copyWith(subscribedUntil: DateTime(2027)).invoice, isNotNull);
    });
  });

  group('InvoiceDownloadBloc', () {
    late _Repo repo;
    late InvoiceDownloadBloc bloc;

    setUp(() {
      repo = _Repo();
      bloc = InvoiceDownloadBloc(DownloadInvoice(repo));
      addTearDown(bloc.close);
    });

    test(
      'downloads the file by invoice id and holds it for the screen',
      () async {
        bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
        await pump();
        expect(repo.asked, ['inv-1']);
        expect(bloc.state.state, RequestState.loaded);
        expect(bloc.state.file!.fileName, 'a.pdf');
        expect(bloc.state.file!.bytes, isNotEmpty);
      },
    );

    test('every tap downloads again — nothing is reused', () async {
      bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
      await pump();
      bloc.add(const InvoiceDownloadEvent.reset());
      bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
      await pump();
      expect(repo.asked, ['inv-1', 'inv-1']);
    });

    test('a failure carries the server\'s words and no file', () async {
      repo.answer = (_) async =>
          const Left(ServerFailure('Receipt not found.', code: 'NOT_FOUND'));
      bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
      await pump();
      expect(bloc.state.state, RequestState.error);
      expect(bloc.state.message, 'Receipt not found.');
      expect(bloc.state.file, isNull);
    });

    test(
      'a second tap while the first is in flight asks for nothing',
      () async {
        final slow = Completer<Either<Failure, InvoiceFile>>();
        repo.answer = (_) => slow.future;
        bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
        await pump();
        expect(bloc.state.state, RequestState.loading);
        bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
        await pump();
        expect(repo.asked, hasLength(1));
        slow.complete(Right(_file));
        await pump();
      },
    );

    test('reset drops the file', () async {
      bloc.add(const InvoiceDownloadEvent.requested('inv-1'));
      await pump();
      bloc.add(const InvoiceDownloadEvent.reset());
      await pump();
      expect(bloc.state.file, isNull);
      expect(bloc.state.state, RequestState.empty);
    });
  });

  group('the button', () {
    final info = SubscriptionInfo(
      plan: const CommunityPlanModel(id: 'p', label: '3 months', price: 999),
      startedOn: DateTime(2026, 9, 1),
      transactionId: 'TXN1',
      paidOn: DateTime(2026, 9, 1),
      paymentMethod: 'UPI',
    );

    Future<_Repo> pumpSection(
      WidgetTester tester, {
      required SubscriptionInvoice? invoice,
      Future<Either<Failure, InvoiceFile>> Function(String)? answer,
    }) async {
      final repo = _Repo();
      if (answer != null) repo.answer = answer;
      final bloc = InvoiceDownloadBloc(DownloadInvoice(repo));
      addTearDown(bloc.close);
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          home: Scaffold(
            body: BlocProvider.value(
              value: bloc,
              child: SingleChildScrollView(
                child: SubscriptionTransactionSection(
                  info: info,
                  invoice: invoice,
                ),
              ),
            ),
          ),
        ),
      );
      return repo;
    }

    testWidgets(
      'no invoice: the button is still there, dimmed, and asks for nothing',
      (tester) async {
        final repo = await pumpSection(tester, invoice: null);
        expect(find.text('Download Invoice'), findsOneWidget);
        final dimmed = tester.widget<Opacity>(
          find.ancestor(
            of: find.text('Download Invoice'),
            matching: find.byType(Opacity),
          ),
        );
        expect(dimmed.opacity, lessThan(1));
        await tester.tap(find.text('Download Invoice'));
        await tester.pump();
        expect(repo.asked, isEmpty);
      },
    );

    testWidgets('a tap downloads that invoice, and shows progress', (
      tester,
    ) async {
      final slow = Completer<Either<Failure, InvoiceFile>>();
      final repo = await pumpSection(
        tester,
        invoice: SubscriptionInvoice.fromJson(_row),
        answer: (_) => slow.future,
      );
      expect(find.text('Download Invoice'), findsOneWidget);
      await tester.tap(find.text('Download Invoice'));
      await tester.pump();
      expect(repo.asked, ['inv-1']);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Download Invoice'), findsNothing);
      // A tap while it's fetching does nothing.
      await tester.tap(find.byType(CircularProgressIndicator));
      await tester.pump();
      expect(repo.asked, hasLength(1));

      // Answer it inside the test, so nothing is left in flight when the bloc
      // is closed (`close()` would wait on it). The screen then hands the file
      // to the save dialog — there is no platform dialog in a test, so it
      // reports that quietly and the button comes back.
      slow.complete(Right(_file));
      await tester.pump();
      await tester.pump();
      expect(find.text('Download Invoice'), findsOneWidget);
    });
  });
}
