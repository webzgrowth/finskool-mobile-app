import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';

/// Opens a request. The key is minted once per tap and reused on retry.
@lazySingleton
class CreateServiceRequest {
  CreateServiceRequest(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestModel>> execute({
    required String idempotencyKey,
    required String serviceId,
    required String needs,
    List<TicketUploadModel> attachments = const [],
  }) => _repository.createRequest(
    idempotencyKey: idempotencyKey,
    serviceId: serviceId,
    needs: needs,
    attachments: attachments,
  );
}
