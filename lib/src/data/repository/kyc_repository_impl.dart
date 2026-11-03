import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/kyc_remote_datasource.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';
import 'package:finskool/src/domain/repository/kyc_repository.dart';

@LazySingleton(as: KycRepository)
class KycRepositoryImpl implements KycRepository {
  KycRepositoryImpl(this._remote);

  final KycRemoteDatasource _remote;

  @override
  Future<Either<Failure, KycStatus>> getStatus() =>
      handleErrors(_remote.getStatus);

  @override
  Future<Either<Failure, Unit>> submit(KycDetails details) =>
      handleErrors(() async {
        await _remote.submit(details);
        return unit;
      });
}
