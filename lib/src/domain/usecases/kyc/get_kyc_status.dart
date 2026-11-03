import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';
import 'package:finskool/src/domain/repository/kyc_repository.dart';

/// Whether the member has already given their DOB and PAN.
@lazySingleton
class GetKycStatus {
  GetKycStatus(this._repository);

  final KycRepository _repository;

  Future<Either<Failure, KycStatus>> execute() => _repository.getStatus();
}
