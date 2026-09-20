import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/community/compliance_details_model.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Submits the one-time SEBI details (DOB + PAN).
@lazySingleton
class SubmitCompliance {
  SubmitCompliance(this._repository);

  final CommunitiesRepository _repository;

  Future<Either<Failure, Unit>> execute(ComplianceDetailsModel details) =>
      _repository.submitCompliance(details);
}
