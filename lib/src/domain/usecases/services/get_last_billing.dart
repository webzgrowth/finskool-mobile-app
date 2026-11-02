import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// The billing details the member last paid with, to pre-fill the sheet.
@lazySingleton
class GetLastBilling {
  GetLastBilling(this._repository);

  final ServicesRepository _repository;

  BillingDetails? execute() => _repository.lastBilling;
}
