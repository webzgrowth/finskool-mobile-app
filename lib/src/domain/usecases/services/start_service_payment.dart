import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// Creates (or returns the same) Razorpay order for a quote. Amount is paise.
@lazySingleton
class StartServicePayment {
  StartServicePayment(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, PaymentOrder>> execute({
    required String requestId,
    required String quoteId,
    required BillingDetails billing,
  }) => _repository.startPayment(
    requestId: requestId,
    quoteId: quoteId,
    billing: billing,
  );
}
