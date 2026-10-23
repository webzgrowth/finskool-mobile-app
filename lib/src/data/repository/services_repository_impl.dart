import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/services_remote_datasource.dart';
import 'package:finskool/src/data/socket/socket_frames.dart';
import 'package:finskool/src/data/socket/tickets_socket.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_message_model.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// Everything below here throws; everything above gets an `Either`. The
/// socket half maps [SocketError] onto a `ServerFailure` that **keeps its
/// `code`** — the chat branches on `SERVICE_CLOSED`.
@LazySingleton(as: ServicesRepository)
class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl(this._remote, this._sock);

  final ServicesRemoteDatasource _remote;
  final TicketsSocket _sock;

  @override
  Future<Either<Failure, List<ServiceModel>>> getCatalog() =>
      handleErrors(_remote.getCatalog);

  @override
  Future<Either<Failure, ServiceRequestPage>> getRequests({
    ServiceStatus? status,
    String? cursor,
  }) => handleErrors(() => _remote.getRequests(status: status, cursor: cursor));

  @override
  Future<Either<Failure, ServiceRequestModel>> getRequest(String id) =>
      handleErrors(() => _remote.getRequest(id));

  @override
  Future<Either<Failure, int>> getUnreadCount() =>
      handleErrors(_remote.getUnreadCount);

  @override
  Future<Either<Failure, ServiceRequestModel>> createRequest({
    required String idempotencyKey,
    required String serviceId,
    required String needs,
    List<TicketUploadModel> attachments = const [],
  }) => handleErrors(
    () => _remote.createRequest(
      idempotencyKey: idempotencyKey,
      serviceId: serviceId,
      needs: needs,
      attachments: attachments,
    ),
  );

  @override
  Future<Either<Failure, ServiceRequestModel>> cancel(String id) =>
      handleErrors(() => _remote.cancel(id));

  @override
  Future<Either<Failure, List<GstState>>> getGstStates() =>
      handleErrors(_remote.getGstStates);

  @override
  Future<Either<Failure, PaymentOrder>> startPayment({
    required String requestId,
    required String quoteId,
    required BillingDetails billing,
  }) => handleErrors(
    () => _remote.startPayment(
      requestId: requestId,
      quoteId: quoteId,
      billing: billing,
    ),
  );

  @override
  Future<Either<Failure, ServiceRequestModel>> verifyPayment({
    required String requestId,
    required PaymentProof proof,
  }) => handleErrors(
    () => _remote.verifyPayment(requestId: requestId, proof: proof),
  );

  @override
  Future<Either<Failure, InvoiceLink>> getInvoice(String requestId) =>
      handleErrors(() => _remote.getInvoice(requestId));

  @override
  Future<Either<Failure, ServiceRequestModel>> rate({
    required String requestId,
    required int rating,
    String? comment,
  }) => handleErrors(
    () => _remote.rate(requestId: requestId, rating: rating, comment: comment),
  );

  @override
  Future<Either<Failure, String>> refreshAttachmentUrl({
    required String requestId,
    required String attachmentId,
  }) => handleErrors(
    () => _remote.refreshAttachmentUrl(
      requestId: requestId,
      attachmentId: attachmentId,
    ),
  );

  @override
  Future<Either<Failure, TicketUploadModel>> upload(
    File file, {
    String? fileName,
  }) => handleErrors(() => _remote.upload(file, fileName: fileName));

  @override
  Future<Either<Failure, TicketMessageModel>> sendMessage({
    required String requestId,
    required String clientMessageId,
    String? body,
    List<TicketUploadModel> attachments = const [],
  }) => _socket(() async {
    final data = await _sock.send('service.message.send', {
      'requestId': requestId,
      'clientMessageId': clientMessageId,
      if (body != null && body.isNotEmpty) 'body': body,
      if (attachments.isNotEmpty)
        'attachments': attachments.map((a) => a.toJson()).toList(),
    });
    return serviceMessageFromJson(_require(data));
  });

  @override
  Future<Either<Failure, ServiceHistoryPage>> getHistory({
    required String requestId,
    String? before,
  }) => _socket(() async {
    final data = await _sock.send('service.history.get', {
      'requestId': requestId,
      'before': ?before,
    });
    return ServiceHistoryPage.fromJson(_require(data));
  });

  @override
  Future<Either<Failure, int>> markRead(String requestId) => _socket(() async {
    final data = await _sock.send('service.read', {'requestId': requestId});
    return (data?['unreadCount'] as num?)?.toInt() ?? 0;
  });

  Future<Either<Failure, T>> _socket<T>(Future<T> Function() action) async {
    try {
      return Right(await action());
    } on SocketError catch (e) {
      return Left(ServerFailure(e.message, code: e.code));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Map<String, dynamic> _require(Map<String, dynamic>? data) {
    if (data == null) throw ApiException('The server sent back no data.');
    return data;
  }
}
