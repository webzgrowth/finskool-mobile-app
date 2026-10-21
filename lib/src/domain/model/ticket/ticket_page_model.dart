import 'ticket_model.dart';

/// One cursor-paged page of `GET /mobile/tickets`.
///
/// Paging here is **cursor based, not page numbers** (§2): send the
/// `nextCursor` you were handed back as `cursor`. Treat it as opaque — a
/// cursor that has been altered comes back `400 INVALID_CURSOR`, and the
/// only recovery is to restart from the first page.
class TicketPageModel {
  const TicketPageModel({required this.items, this.nextCursor});

  final List<TicketModel> items;

  /// `null` means there are no more pages.
  final String? nextCursor;

  bool get hasMore => nextCursor != null;

  factory TicketPageModel.fromJson(Map<String, dynamic> json) =>
      TicketPageModel(
        items: ((json['items'] as List?) ?? const [])
            .whereType<Map<String, dynamic>>()
            .map(TicketModel.fromJson)
            .toList(),
        nextCursor: json['nextCursor'] as String?,
      );
}

/// A community the member may raise a ticket against — every one they hold
/// or ever held a subscription for, the free community included (§5).
///
/// An **empty list means they cannot raise a ticket at all**, and the form
/// must disable submit rather than show an empty picker.
class TicketCommunityModel {
  const TicketCommunityModel({
    required this.id,
    required this.name,
    this.isFree = false,
  });

  final String id;
  final String name;
  final bool isFree;

  factory TicketCommunityModel.fromJson(Map<String, dynamic> json) =>
      TicketCommunityModel(
        id: json['id'] as String,
        name: json['name'] as String? ?? '',
        isFree: json['isFree'] as bool? ?? false,
      );
}
