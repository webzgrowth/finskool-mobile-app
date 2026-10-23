import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';

import 'tickets_remote_datasource.dart';

/// The services module's **REST** half. Chat, history and read are
/// socket-only and live behind `ServicesRepository`'s socket methods.
///
/// Like every datasource these *throw*; catching happens once, in the
/// repository, via `handleErrors`.
@lazySingleton
class ServicesRemoteDatasource {
  ServicesRemoteDatasource(this._client, this._tickets);

  final ApiClient _client;

  /// Borrowed for the presign-then-PUT upload, which is identical for both
  /// modules apart from the presign path.
  final TicketsRemoteDatasource _tickets;

  Future<List<ServiceModel>> getCatalog() async {
    final rows = await _client.getList(Api.serviceCatalog);
    return (rows ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(ServiceModel.fromJson)
        .toList();
  }

  Future<ServiceRequestPage> getRequests({
    ServiceStatus? status,
    String? cursor,
    int limit = 20,
  }) async {
    final data = await _client.get(
      Api.services,
      query: {
        'limit': limit,
        'status': ?status == null ? null : _wire(status),
        'cursor': ?cursor,
      },
    );
    return ServiceRequestPage.fromJson(_require(data, Api.services));
  }

  Future<ServiceRequestModel> getRequest(String id) async {
    final path = Api.service(id);
    return ServiceRequestModel.fromJson(
      _require(await _client.get(path), path),
    );
  }

  Future<int> getUnreadCount() async {
    final data = await _client.get(Api.serviceUnreadCount);
    return (data?['unreadCount'] as num?)?.toInt() ?? 0;
  }

  /// [idempotencyKey] is minted **once per tap and reused on retry**: a repeat
  /// returns the original request instead of opening a second.
  Future<ServiceRequestModel> createRequest({
    required String idempotencyKey,
    required String serviceId,
    required String needs,
    List<TicketUploadModel> attachments = const [],
  }) async {
    final data = await _client.post(
      Api.services,
      headers: {'Idempotency-Key': idempotencyKey},
      body: {
        'serviceId': serviceId,
        'needs': needs,
        if (attachments.isNotEmpty)
          'attachments': attachments.map((a) => a.toJson()).toList(),
      },
    );
    return ServiceRequestModel.fromJson(_require(data, Api.services));
  }

  Future<ServiceRequestModel> cancel(String id) async {
    final path = Api.serviceCancel(id);
    return ServiceRequestModel.fromJson(
      _require(await _client.post(path), path),
    );
  }

  Future<List<GstState>> getGstStates() async {
    final rows = await _client.getList(Api.serviceGstStates);
    return (rows ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(GstState.fromJson)
        .toList();
  }

  Future<PaymentOrder> startPayment({
    required String requestId,
    required String quoteId,
    required BillingDetails billing,
  }) async {
    final path = Api.servicePay(requestId, quoteId);
    final data = await _client.post(path, body: {'billing': billing.toJson()});
    return PaymentOrder.fromJson(_require(data, path));
  }

  Future<ServiceRequestModel> verifyPayment({
    required String requestId,
    required PaymentProof proof,
  }) async {
    final path = Api.serviceVerify(requestId);
    final data = await _client.post(path, body: proof.toJson());
    return ServiceRequestModel.fromJson(_require(data, path));
  }

  Future<InvoiceLink> getInvoice(String requestId) async {
    final path = Api.serviceInvoice(requestId);
    return InvoiceLink.fromJson(_require(await _client.get(path), path));
  }

  Future<ServiceRequestModel> rate({
    required String requestId,
    required int rating,
    String? comment,
  }) async {
    final path = Api.serviceRating(requestId);
    final data = await _client.post(
      path,
      body: {
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      },
    );
    return ServiceRequestModel.fromJson(_require(data, path));
  }

  Future<String> refreshAttachmentUrl({
    required String requestId,
    required String attachmentId,
  }) async {
    final data = await _client.get(
      Api.serviceAttachmentUrl(requestId, attachmentId),
    );
    final url = data?['url'] as String?;
    if (url == null || url.isEmpty) {
      throw ApiException('That file is no longer available.');
    }
    return url;
  }

  Future<TicketUploadModel> upload(File file, {String? fileName}) =>
      _tickets.uploadAttachment(
        file,
        fileName: fileName,
        presignPath: Api.servicePresign,
      );

  static String _wire(ServiceStatus s) => switch (s) {
    ServiceStatus.requested => 'requested',
    ServiceStatus.quoteSent => 'quote_sent',
    ServiceStatus.paid => 'paid',
    ServiceStatus.closed => 'closed',
  };

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
