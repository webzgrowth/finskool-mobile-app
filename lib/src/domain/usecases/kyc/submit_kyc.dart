import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/repository/kyc_repository.dart';

/// Submits the one-time SEBI details (DOB + PAN).
@lazySingleton
class SubmitKyc {
  SubmitKyc(this._repository);

  final KycRepository _repository;

  Future<Either<Failure, Unit>> execute(KycDetails details) =>
      _repository.submit(details);
}
