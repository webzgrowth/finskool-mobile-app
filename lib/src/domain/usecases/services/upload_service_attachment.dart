import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/services_repository.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';

import 'dart:io';

/// Presigns and uploads one file (JPG/PNG/WebP/PDF, 5 MB).
@lazySingleton
class UploadServiceAttachment {
  UploadServiceAttachment(this._repository);
  final ServicesRepository _repository;

  Future<Either<Failure, TicketUploadModel>> execute(
    File file, {
    String? fileName,
  }) => _repository.upload(file, fileName: fileName);
}
