import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/transaction/transaction_model.dart';

/// Stand-in payment history: Figma's seven rows (`Profile / Transaction
/// History – V1`, `1809:5414`).
///
/// **Temporary, and for demos.** No endpoint returns a member's payments — the
/// only transactions Figma draws on the server side are the admin's. Same
/// category as `DemoSubscriptionDatasource`: it exists so the screen can be
/// built and reviewed against the design, and it is replaced by a remote
/// datasource behind the same `TransactionsRepository`. The payment method and
/// payment ids are invented; `invoiceId` is null on purpose, so Download says
/// no invoice is available rather than calling the receipts API with an id the
/// server never issued.
@lazySingleton
class TransactionsDemoDatasource {
  Future<List<TransactionModel>> getTransactions() async => _rows;

  static final List<TransactionModel> _rows = [
    TransactionModel(
      id: 'txn-0511',
      kind: TransactionKind.service,
      glyph: TransactionGlyph.pie,
      title: 'Portfolio Analysis',
      descriptor: 'Quote Q-1042',
      date: DateTime(2026, 10, 2),
      amount: 7500,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0511',
      paymentMethod: 'UPI',
      paymentId: 'pay_demo0511',
    ),
    TransactionModel(
      id: 'txn-0418',
      kind: TransactionKind.community,
      glyph: TransactionGlyph.education,
      title: 'Finskool21 Academy Community',
      descriptor: 'Quarterly',
      date: DateTime(2026, 8, 14),
      amount: 4999,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0418',
      paymentMethod: 'Card',
      paymentId: 'pay_demo0418',
    ),
    TransactionModel(
      id: 'txn-failed',
      kind: TransactionKind.community,
      glyph: TransactionGlyph.education,
      title: 'Finskool21 Academy Community',
      descriptor: 'Quarterly',
      date: DateTime(2026, 8, 14),
      amount: 4999,
      status: TransactionStatus.failed,
      failureReason: 'Declined by bank. No money was deducted.',
      paymentMethod: 'Card',
    ),
    TransactionModel(
      id: 'txn-0296',
      kind: TransactionKind.service,
      glyph: TransactionGlyph.briefcase,
      title: 'Intelligent Model Portfolio',
      descriptor: 'Quote Q-0987',
      date: DateTime(2026, 6, 20),
      amount: 25000,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0296',
      paymentMethod: 'Net banking',
      paymentId: 'pay_demo0296',
    ),
    TransactionModel(
      id: 'txn-0207',
      kind: TransactionKind.community,
      glyph: TransactionGlyph.education,
      title: 'Finskool21 Academy Community',
      descriptor: 'Quarterly',
      date: DateTime(2026, 5, 14),
      amount: 4999,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0207',
      paymentMethod: 'UPI',
      paymentId: 'pay_demo0207',
    ),
    TransactionModel(
      id: 'txn-0189',
      kind: TransactionKind.community,
      glyph: TransactionGlyph.investor,
      title: 'Investor Community',
      descriptor: 'Yearly',
      date: DateTime(2026, 5, 12),
      amount: 14999,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0189',
      paymentMethod: 'Card',
      paymentId: 'pay_demo0189',
    ),
    TransactionModel(
      id: 'txn-0188',
      kind: TransactionKind.community,
      glyph: TransactionGlyph.chart,
      title: 'Intraday Community',
      descriptor: 'Yearly',
      date: DateTime(2026, 5, 12),
      amount: 11999,
      status: TransactionStatus.paid,
      invoiceNumber: 'INV-2026-0188',
      paymentMethod: 'UPI',
      paymentId: 'pay_demo0188',
    ),
  ];
}
