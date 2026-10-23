import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';

/// One page of a request's chat history, **newest first**.
class ServiceHistoryPage {
  const ServiceHistoryPage({
    required this.items,
    this.quotes = const {},
    this.nextCursor,
  });

  final List<TicketMessageModel> items;

  /// The quotes the `kind: "quote"` messages carry, by id. Their `status` is
  /// current as of this fetch.
  final Map<String, ServiceQuoteModel> quotes;
  final String? nextCursor;

  factory ServiceHistoryPage.fromJson(Map<String, dynamic> json) {
    final rows = ((json['items'] as List?) ?? const [])
        .whereType<Map<String, dynamic>>()
        .toList();
    return ServiceHistoryPage(
      items: rows.map(serviceMessageFromJson).toList(),
      quotes: quotesIn(rows),
      nextCursor: json['nextCursor'] as String?,
    );
  }
}

/// Pulls the embedded quote out of each `kind: "quote"` message row.
Map<String, ServiceQuoteModel> quotesIn(List<Map<String, dynamic>> rows) => {
  for (final row in rows)
    if (row['kind'] == 'quote' && row['quote'] is Map<String, dynamic>)
      (row['quote'] as Map<String, dynamic>)['id'] as String:
          ServiceQuoteModel.fromJson(row['quote'] as Map<String, dynamic>),
};

/// The services module's contract: REST first, then the **socket-only** chat
/// (there are no REST chat endpoints).
abstract class ServicesRepository {
  Future<Either<Failure, List<ServiceModel>>> getCatalog();

  Future<Either<Failure, ServiceRequestPage>> getRequests({
    ServiceStatus? status,
    String? cursor,
  });

  Future<Either<Failure, ServiceRequestModel>> getRequest(String id);

  Future<Either<Failure, int>> getUnreadCount();

  Future<Either<Failure, ServiceRequestModel>> createRequest({
    required String idempotencyKey,
    required String serviceId,
    required String needs,
    List<TicketUploadModel> attachments = const [],
  });

  Future<Either<Failure, ServiceRequestModel>> cancel(String id);

  Future<Either<Failure, List<GstState>>> getGstStates();

  Future<Either<Failure, PaymentOrder>> startPayment({
    required String requestId,
    required String quoteId,
    required BillingDetails billing,
  });

  Future<Either<Failure, ServiceRequestModel>> verifyPayment({
    required String requestId,
    required PaymentProof proof,
  });

  Future<Either<Failure, InvoiceLink>> getInvoice(String requestId);

  Future<Either<Failure, ServiceRequestModel>> rate({
    required String requestId,
    required int rating,
    String? comment,
  });

  Future<Either<Failure, String>> refreshAttachmentUrl({
    required String requestId,
    required String attachmentId,
  });

  Future<Either<Failure, TicketUploadModel>> upload(
    File file, {
    String? fileName,
  });

  // ── Socket ──────────────────────────────────────────────────────────
  Future<Either<Failure, TicketMessageModel>> sendMessage({
    required String requestId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  });

  Future<Either<Failure, ServiceHistoryPage>> getHistory({
    required String requestId,
    String? before,
  });

  Future<Either<Failure, int>> markRead(String requestId);
}
