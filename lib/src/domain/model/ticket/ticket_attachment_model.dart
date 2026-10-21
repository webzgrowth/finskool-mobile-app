/// One file on a ticket or a chat message.
///
/// [url] is a **signed link that expires in about 5 minutes** (§4), so a
/// conversation left open will accumulate dead ones. When an image fails to
/// load, or a file is tapped and the link may be stale, fetch a fresh one
/// from `GET /:ticketId/attachments/:attachmentId/url` — once per
/// attachment, never in a loop.
class TicketAttachmentModel {
  const TicketAttachmentModel({
    required this.id,
    required this.fileName,
    required this.mimeType,
    required this.sizeBytes,
    this.url,
  });

  final String id;
  final String fileName;
  final String mimeType;
  final int sizeBytes;

  /// Nullable because a refreshed link replaces it, and because a message
  /// echoed straight back from a send may not carry one yet.
  final String? url;

  bool get isImage => mimeType.startsWith('image/');

  /// "PNG" / "PDF" — the tag Figma puts on the attachment chip.
  String get typeTag {
    final dot = fileName.lastIndexOf('.');
    if (dot == -1 || dot == fileName.length - 1) return 'FILE';
    return fileName.substring(dot + 1).toUpperCase();
  }

  TicketAttachmentModel withUrl(String fresh) => TicketAttachmentModel(
    id: id,
    fileName: fileName,
    mimeType: mimeType,
    sizeBytes: sizeBytes,
    url: fresh,
  );

  factory TicketAttachmentModel.fromJson(Map<String, dynamic> json) =>
      TicketAttachmentModel(
        id: json['id'] as String,
        fileName: json['fileName'] as String? ?? '',
        mimeType: json['mimeType'] as String? ?? '',
        sizeBytes: (json['sizeBytes'] as num?)?.toInt() ?? 0,
        url: json['url'] as String?,
      );

  static List<TicketAttachmentModel> listFrom(Object? raw) =>
      ((raw as List?) ?? const [])
          .whereType<Map<String, dynamic>>()
          .map(TicketAttachmentModel.fromJson)
          .toList();
}

/// A file the member picked and uploaded but hasn't submitted yet — the
/// `{objectKey, fileName}` pair `POST /` and `message.send` want.
///
/// An upload that is never submitted is swept after 24 hours, so there is
/// no delete call to make.
class TicketUploadModel {
  const TicketUploadModel({
    required this.objectKey,
    required this.fileName,
    required this.sizeBytes,
    this.localPath,
  });

  final String objectKey;
  final String fileName;
  final int sizeBytes;

  /// Kept so the form can show a thumbnail before the ticket exists.
  final String? localPath;

  Map<String, dynamic> toJson() => {
    'objectKey': objectKey,
    'fileName': fileName,
  };
}
