import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/repository/tickets_repository.dart';

/// A fresh signed link for an attachment.
///
/// Links last about 5 minutes, so a conversation left open accumulates dead
/// ones. Call this when an image fails to load or a file is tapped — **once
/// per attachment, never in a retry loop**.
@lazySingleton
class RefreshAttachmentUrl {
  RefreshAttachmentUrl(this._repository);
  final TicketsRepository _repository;

  Future<Either<Failure, String>> execute({
    required String ticketId,
    required String attachmentId,
  }) => _repository.refreshAttachmentUrl(
    ticketId: ticketId,
    attachmentId: attachmentId,
  );
}
