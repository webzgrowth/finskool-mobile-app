import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';

/// A fresh signed link; the first one lasts about five minutes.
@lazySingleton
class RefreshServiceAttachmentUrl {
  RefreshServiceAttachmentUrl(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, String>> execute({
    required String requestId,
    required String attachmentId,
  }) => _repository.refreshAttachmentUrl(
    requestId: requestId,
    attachmentId: attachmentId,
  );
}
