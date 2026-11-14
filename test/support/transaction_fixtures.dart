import 'package:finskool/src/domain/model/transaction/transaction_model.dart';

/// Rows shaped exactly like `GET /mobile/transactions` items.
Map<String, dynamic> txnJson({
  String id = 'plan:1',
  String kind = 'community',
  String status = 'paid',
  String occurredAt = '2026-11-13T04:54:00.000Z',
  num amount = 11999,
  String title = 'Intraday Community',
  int? planMonths = 12,
  String? planName = 'Yearly',
  String? reference,
  String? paymentId = 'pay_Qx1',
  String? method,
  String? failureReason,
  bool invoice = true,
}) => {
  'id': id,
  'kind': kind,
  'status': status,
  'occurredAt': occurredAt,
  'amount': amount,
  'currency': 'INR',
  'title': title,
  'planMonths': planMonths,
  'planName': planName,
  'reference': reference,
  'paymentId': paymentId,
  'method': method,
  'failureReason': failureReason,
  'invoice': invoice && status == 'paid'
      ? {
          'number': 'FS/2026-27/0184',
          'downloadPath': '/api/v1/payments/receipts/a127b/download',
        }
      : null,
};

TransactionModel txn({
  String id = 'plan:1',
  String status = 'paid',
  String kind = 'community',
  num amount = 11999,
  String? reference,
  String? planName = 'Yearly',
  String? failureReason,
}) => TransactionModel.fromJson(
  txnJson(
    id: id,
    status: status,
    kind: kind,
    amount: amount,
    reference: reference,
    planName: planName,
    planMonths: kind == 'service' ? null : 12,
    failureReason: failureReason,
  ),
);

/// The doc's two sample rows plus an under-review one.
List<TransactionModel> sampleTransactions() => [
  TransactionModel.fromJson(txnJson()),
  TransactionModel.fromJson(
    txnJson(
      id: 'svc:55d2',
      kind: 'service',
      status: 'failed',
      occurredAt: '2026-11-12T09:12:00.000Z',
      amount: 25000,
      title: 'Intelligent Model Portfolio',
      planMonths: null,
      planName: null,
      reference: 'SR-12 · Quote 1',
      paymentId: 'pay_Rt1',
      method: 'card',
      failureReason: 'Card expired',
    ),
  ),
  TransactionModel.fromJson(
    txnJson(
      id: 'svc:77aa',
      kind: 'service',
      status: 'flagged',
      occurredAt: '2026-11-10T15:00:00.000Z',
      amount: 7500,
      title: 'Portfolio Analysis',
      planMonths: null,
      planName: null,
      reference: 'SR-9 · Quote 2',
      method: 'upi',
    ),
  ),
];
