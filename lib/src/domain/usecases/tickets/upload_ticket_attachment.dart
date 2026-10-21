import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// Presigns and uploads one file, returning the `{objectKey, fileName}` the
/// ticket or message is then submitted with.
///
/// [fileName] is the name the member knows the file by; the file on disk is a
/// picker cache copy (`image_picker_<UUID>.jpg`) and must not become the
/// ticket's attachment name.
///
/// Limits the caller must enforce *before* calling: 5 MB, and one of
/// JPG/JPEG/PNG/WebP/PDF. The server also checks the file's real first
/// bytes on submit, so a renamed file is rejected there regardless.
@lazySingleton
class UploadTicketAttachment {
  UploadTicketAttachment(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, TicketUploadModel>> execute(
    File file, {
    String? fileName,
  }) => _repository.uploadAttachment(file, fileName: fileName);
}
