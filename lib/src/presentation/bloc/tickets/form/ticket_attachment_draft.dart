import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';

enum DraftStatus { uploading, uploaded, failed }

/// A file the member picked, on its way to (or already in) storage, before
/// the ticket or message it belongs to exists.
///
/// A plain class: freezed is for bloc events and state only, never models.
/// [id] is local — the server only learns of the file as an `objectKey`
/// once the upload finishes.
class TicketAttachmentDraft {
  const TicketAttachmentDraft({
    required this.id,
    required this.fileName,
    required this.sizeBytes,
    required this.status,
    this.localPath,
    this.upload,
    this.error,
  });

  final String id;
  final String fileName;
  final int sizeBytes;
  final DraftStatus status;
  final String? localPath;

  /// Present once `status` is [DraftStatus.uploaded].
  final TicketUploadModel? upload;
  final String? error;

  bool get isUploading => status == DraftStatus.uploading;
  bool get isReady => status == DraftStatus.uploaded && upload != null;

  /// "240 KB" / "1.2 MB" — the size line under the file name.
  String get sizeLabel {
    if (sizeBytes < 1024) return '$sizeBytes B';
    if (sizeBytes < 1024 * 1024) return '${(sizeBytes / 1024).round()} KB';
    return '${(sizeBytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }

  /// A picture we can preview from the local file.
  bool get isImage =>
      localPath != null && !const ['pdf'].contains(typeTag.toLowerCase());

  /// "PNG" / "PDF" — the tag in the file tile.
  String get typeTag {
    final dot = fileName.lastIndexOf('.');
    return dot == -1 ? 'FILE' : fileName.substring(dot + 1).toUpperCase();
  }

  TicketAttachmentDraft copyWith({
    DraftStatus? status,
    TicketUploadModel? upload,
    String? error,
  }) => TicketAttachmentDraft(
    id: id,
    fileName: fileName,
    sizeBytes: sizeBytes,
    localPath: localPath,
    status: status ?? this.status,
    upload: upload ?? this.upload,
    error: error ?? this.error,
  );
}

/// The limits §5 puts on uploads, checked **locally first** so a doomed file
/// never costs a round-trip. The server still re-checks the file's real
/// first bytes on submit, so a renamed file is caught there regardless.
class UploadRules {
  UploadRules._();

  static const int maxFiles = 5;
  static const int maxBytes = 5 * 1024 * 1024;
  static const allowedExtensions = ['jpg', 'jpeg', 'png', 'webp', 'pdf'];

  /// The message to show, or null when the file is acceptable.
  static String? check({
    required String fileName,
    required int sizeBytes,
    required int currentCount,
  }) {
    if (currentCount >= maxFiles)
      return 'You can attach up to $maxFiles files.';
    final ext = fileName.toLowerCase().split('.').last;
    if (!allowedExtensions.contains(ext)) {
      return 'Only PNG, JPG, WebP or PDF files can be attached.';
    }
    if (sizeBytes > maxBytes) return 'Each file must be 5 MB or smaller.';
    return null;
  }
}
