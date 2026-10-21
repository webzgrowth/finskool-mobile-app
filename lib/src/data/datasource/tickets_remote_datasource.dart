import 'dart:io';

import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/ticket/ticket_attachment_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';

/// The ticket module's **REST** half: tickets, communities, uploads, rating
/// and attachment links. The chat itself is socket-only (§1) and lives in
/// `TicketsSocket`.
///
/// Like every datasource these *throw*; catching happens once in the
/// repository, via `handleErrors`.
@lazySingleton
class TicketsRemoteDatasource {
  TicketsRemoteDatasource(this._client);

  final ApiClient _client;

  /// An empty list means the member can't raise a ticket at all — disable
  /// the form rather than showing an empty picker.
  Future<List<TicketCommunityModel>> getCommunities() async {
    final rows = await _client.getList(Api.ticketCommunities);
    return (rows ?? const [])
        .whereType<Map<String, dynamic>>()
        .map(TicketCommunityModel.fromJson)
        .toList();
  }

  Future<TicketPageModel> getTickets({
    TicketStatus? status,
    String? cursor,
    int limit = 20,
  }) async {
    final data = await _client.get(
      Api.tickets,
      query: {'limit': limit, 'status': ?status?.wire, 'cursor': ?cursor},
    );
    return TicketPageModel.fromJson(_require(data, Api.tickets));
  }

  Future<TicketModel> getTicket(String ticketId) async {
    final path = Api.ticket(ticketId);
    return TicketModel.fromJson(_require(await _client.get(path), path));
  }

  Future<int> getUnreadCount() async {
    final data = await _client.get(Api.ticketUnreadCount);
    return (data?['unreadCount'] as num?)?.toInt() ?? 0;
  }

  /// [idempotencyKey] must be **generated once per form submission and
  /// reused on every retry** — that is what makes a timeout or a double tap
  /// safe. A repeated key returns the original ticket and creates nothing.
  Future<TicketModel> createTicket({
    required String idempotencyKey,
    required String communityId,
    required TicketCategory category,
    required TicketType type,
    required String subject,
    required String description,
    List<TicketUploadModel> attachments = const [],
  }) async {
    final data = await _client.post(
      Api.tickets,
      headers: {'Idempotency-Key': idempotencyKey},
      body: {
        'communityId': communityId,
        'category': category.wire,
        'type': type.wire,
        'subject': subject,
        'description': description,
        if (attachments.isNotEmpty)
          'attachments': attachments.map((a) => a.toJson()).toList(),
      },
    );
    return TicketModel.fromJson(_require(data, Api.tickets));
  }

  Future<TicketModel> rateTicket({
    required String ticketId,
    required int rating,
    String? comment,
  }) async {
    final path = Api.ticketRating(ticketId);
    final data = await _client.post(
      path,
      body: {
        'rating': rating,
        if (comment != null && comment.isNotEmpty) 'comment': comment,
      },
    );
    return TicketModel.fromJson(_require(data, path));
  }

  /// A fresh signed link for an attachment whose earlier one expired.
  Future<String> refreshAttachmentUrl({
    required String ticketId,
    required String attachmentId,
  }) async {
    final path = Api.ticketAttachmentUrl(ticketId, attachmentId);
    final data = await _client.get(path);
    final url = data?['url'] as String?;
    if (url == null || url.isEmpty) {
      throw ApiException('That file is no longer available.');
    }
    return url;
  }

  /// Presign, then PUT the bytes straight to storage.
  ///
  /// Presigning happens **here, immediately before the upload**, not when
  /// the form opens: the link is only valid for 5 minutes.
  Future<TicketUploadModel> uploadAttachment(
    File file, {
    String? fileName,
  }) async {
    fileName ??= file.uri.pathSegments.last;
    final bytes = await file.readAsBytes();

    final data = await _client.post(
      Api.ticketPresign,
      body: {'fileName': fileName, 'sizeBytes': bytes.length},
    );
    final presigned = _require(data, Api.ticketPresign);
    final uploadUrl = presigned['uploadUrl'] as String?;
    final objectKey = presigned['objectKey'] as String?;
    if (uploadUrl == null || objectKey == null) {
      throw ApiException('Could not prepare that file for upload.');
    }

    await ApiClient.putBytes(
      uploadUrl,
      bytes,
      contentType: _contentType(fileName),
    );
    return TicketUploadModel(
      objectKey: objectKey,
      fileName: fileName,
      sizeBytes: bytes.length,
      localPath: file.path,
    );
  }

  /// The server checks the file's real first bytes on submit, so a renamed
  /// file is rejected however we label it here. This only has to be right
  /// for the four accepted kinds.
  static String _contentType(String fileName) {
    final ext = fileName.toLowerCase().split('.').last;
    return switch (ext) {
      'png' => 'image/png',
      'jpg' || 'jpeg' => 'image/jpeg',
      'webp' => 'image/webp',
      'pdf' => 'application/pdf',
      _ => 'application/octet-stream',
    };
  }

  Map<String, dynamic> _require(Map<String, dynamic>? data, String path) {
    if (data == null) {
      throw ApiException('The server returned no data for $path.');
    }
    return data;
  }
}
