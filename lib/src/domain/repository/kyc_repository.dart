import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';

/// The member's date of birth + PAN, kept by the server. Implemented by
/// `data/repository/kyc_repository_impl.dart`.
abstract class KycRepository {
  /// Whether the details have been given, and the non-secret part of them.
  Future<Either<Failure, KycStatus>> getStatus();

  /// Sends the details for the first time. A second call is answered `409
  /// KYC_ALREADY_SUBMITTED` and changes nothing.
  Future<Either<Failure, Unit>> submit(KycDetails details);
}
