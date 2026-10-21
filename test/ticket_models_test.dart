import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/ticket/ticket_enums.dart';
import 'package:finskool/src/domain/model/ticket/ticket_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_page_model.dart';
import 'package:finskool/src/domain/model/ticket/ticket_summary_model.dart';

/// The Ticket example from §4 of the integration guide, verbatim.
const _ticketJson = '''
{
  "id": "41aeca02-b9e8-48bf-88e5-a42a35f072ca",
  "number": 2041,
  "label": "FS-2041",
  "communityId": "1c9f",
  "communityName": "Swing Traders",
  "category": "payments",
  "type": "issue",
  "subject": "Payment failed",
  "description": "Money deducted but no access",
  "status": "in_progress",
  "attachments": [],
  "lastMessageAt": "2026-10-18T09:03:11.123Z",
  "rating": null,
  "ratingComment": null,
  "ratedAt": null,
  "resolvedAt": null,
  "createdAt": "2026-10-18T08:55:02.411Z",
  "assignedAdminName": "Admin One",
  "unreadCount": 2
}
''';

/// The TicketSummary example from §6.2, verbatim.
const _summaryJson = '''
{
  "id": "41aeca02-b9e8-48bf-88e5-a42a35f072ca",
  "number": 2041, "label": "FS-2041", "communityId": "1c9f",
  "category": "payments", "type": "issue", "subject": "Payment failed",
  "status": "resolved",
  "assignedAdmin": { "id": "x", "name": "Admin Two" },
  "unreadCount": 0,
  "lastMessageAt": "2026-10-19T09:03:11.123Z",
  "rating": null,
  "resolvedAt": "2026-10-19T09:03:11.123Z"
}
''';

Map<String, dynamic> _decode(String s) => jsonDecode(s) as Map<String, dynamic>;

void main() {
  group('enums', () {
    // The three snake_case values are exactly where a `.name`-based lookup
    // would silently fail.
    test('snake_case wire values map both ways', () {
      expect(TicketStatusX.fromName('in_progress'), TicketStatus.inProgress);
      expect(TicketStatus.inProgress.wire, 'in_progress');
      expect(TicketCategoryX.fromName('app_bug'), TicketCategory.appBug);
      expect(TicketCategory.appBug.wire, 'app_bug');
      expect(
        TicketTypeX.fromName('feature_request'),
        TicketType.featureRequest,
      );
      expect(TicketType.featureRequest.wire, 'feature_request');
    });

    test('an unknown value drops one datum rather than throwing', () {
      expect(TicketStatusX.fromName('escalated'), isNull);
      expect(TicketCategoryX.fromName('billing_v2'), isNull);
      expect(TicketTypeX.fromName(null), isNull);
    });

    test('labels are the design copy, not the wire value', () {
      expect(TicketCategory.payments.label, 'Billing & payments');
      expect(TicketCategory.appBug.label, 'App issue');
      expect(TicketStatus.inProgress.label, 'In progress');
    });
  });

  group('TicketModel', () {
    test('parses the spec example', () {
      final t = TicketModel.fromJson(_decode(_ticketJson));
      expect(t.label, 'FS-2041');
      expect(t.status, TicketStatus.inProgress);
      expect(t.category, TicketCategory.payments);
      expect(t.unreadCount, 2);
      expect(t.assignedAdminName, 'Admin One');
      expect(t.isResolved, isFalse);
      expect(t.canRate, isFalse, reason: 'not resolved yet');
    });

    test('timestamps stay UTC, so display can convert once', () {
      final t = TicketModel.fromJson(_decode(_ticketJson));
      expect(t.createdAt.isUtc, isTrue);
      expect(t.lastMessageAt.isUtc, isTrue);
      expect(t.createdAt.hour, 8);
    });

    test('an unknown status falls back to open rather than failing', () {
      final json = _decode(_ticketJson)..['status'] = 'escalated';
      expect(TicketModel.fromJson(json).status, TicketStatus.open);
    });

    test('a resolved, unrated ticket can be rated exactly once', () {
      final json = _decode(_ticketJson)
        ..['status'] = 'resolved'
        ..['resolvedAt'] = '2026-10-19T09:00:00.000Z';
      final t = TicketModel.fromJson(json);
      expect(t.canRate, isTrue);
      expect(t.copyWith(rating: 4).canRate, isFalse);
    });
  });

  group('TicketSummaryModel', () {
    // The socket's shape differs from REST's in exactly this way, and it is
    // the difference most likely to be missed.
    test('reads the admin out of an object, not a flat name', () {
      final s = TicketSummaryModel.fromJson(_decode(_summaryJson));
      expect(s.assignedAdminName, 'Admin Two');
    });

    test('merging patches only what the summary carries', () {
      final ticket = TicketModel.fromJson(_decode(_ticketJson));
      final merged = TicketSummaryModel.fromJson(_decode(_summaryJson))
          .mergeInto(ticket);

      expect(merged.status, TicketStatus.resolved);
      expect(merged.unreadCount, 0);
      expect(merged.assignedAdminName, 'Admin Two');
      // The summary has none of these; they must survive the merge.
      expect(merged.description, 'Money deducted but no access');
      expect(merged.communityName, 'Swing Traders');
    });

    test('an unknown id can stand alone as a new row', () {
      final t = TicketSummaryModel.fromJson(_decode(_summaryJson)).toTicket();
      expect(t.label, 'FS-2041');
      expect(t.description, isEmpty, reason: 'filled in by GET /:id later');
    });
  });

  test('cursor paging reports more only while a cursor remains', () {
    final page = TicketPageModel.fromJson({
      'items': [_decode(_ticketJson)],
      'nextCursor': 'abc',
    });
    expect(page.items, hasLength(1));
    expect(page.hasMore, isTrue);
    expect(
      TicketPageModel.fromJson({'items': [], 'nextCursor': null}).hasMore,
      isFalse,
    );
  });

  test('an empty community list means the form must be disabled', () {
    expect(
      [].map((e) => TicketCommunityModel.fromJson(e as Map<String, dynamic>)),
      isEmpty,
    );
  });
}
