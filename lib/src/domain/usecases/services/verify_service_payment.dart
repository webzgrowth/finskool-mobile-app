import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_request_model.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// Confirms a payment with Razorpay's signature. Safe to repeat.
@lazySingleton
class VerifyServicePayment {
  VerifyServicePayment(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, ServiceRequestModel>> execute({
    required String requestId,
    required PaymentProof proof,
  }) => _repository.verifyPayment(requestId: requestId, proof: proof);
}
