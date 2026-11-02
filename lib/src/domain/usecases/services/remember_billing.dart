import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// Keeps the billing details locally once the server has accepted them.
@lazySingleton
class RememberBilling {
  RememberBilling(this._repository);

  final ServicesRepository _repository;

  Future<void> execute(BillingDetails billing) =>
      _repository.rememberBilling(billing);
}
