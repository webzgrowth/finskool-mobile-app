/// The three fixed vocabularies `GET /mobile/tickets` uses.
///
/// Every `fromName` is **nullable on purpose**, the same call this app
/// already makes for `ReactionTypeX.fromName`: these values arrive from the
/// server, so one the build doesn't recognise must drop a single datum
/// rather than throw and take the whole screen down. Callers fall back to a
/// sensible default or skip the row.
library;

/// `open` nobody has picked it up · `in_progress` an admin owns it ·
/// `resolved` final, and **read-only for good** — there is no reopen (§10),
/// whatever the design shows.
enum TicketStatus { open, inProgress, resolved }

enum TicketCategory { payments, subscription, account, content, appBug, other }

enum TicketType { issue, question, featureRequest, refundRequest }

/// The API spells these `in_progress`, `app_bug`, `feature_request` — snake
/// case, where Dart wants lower camel. One map each rather than a
/// `name`-based lookup, which would silently fail on exactly those three.
const _statusNames = {
  TicketStatus.open: 'open',
  TicketStatus.inProgress: 'in_progress',
  TicketStatus.resolved: 'resolved',
};

const _categoryNames = {
  TicketCategory.payments: 'payments',
  TicketCategory.subscription: 'subscription',
  TicketCategory.account: 'account',
  TicketCategory.content: 'content',
  TicketCategory.appBug: 'app_bug',
  TicketCategory.other: 'other',
};

const _typeNames = {
  TicketType.issue: 'issue',
  TicketType.question: 'question',
  TicketType.featureRequest: 'feature_request',
  TicketType.refundRequest: 'refund_request',
};

extension TicketStatusX on TicketStatus {
  String get wire => _statusNames[this]!;

  /// Figma's pill copy.
  String get label => switch (this) {
    TicketStatus.open => 'Open',
    TicketStatus.inProgress => 'In progress',
    TicketStatus.resolved => 'Resolved',
  };

  bool get isResolved => this == TicketStatus.resolved;

  static TicketStatus? fromName(String? name) => _lookup(_statusNames, name);
}

extension TicketCategoryX on TicketCategory {
  String get wire => _categoryNames[this]!;

  /// Figma's meta line reads "Billing & payments", not "payments".
  String get label => switch (this) {
    TicketCategory.payments => 'Billing & payments',
    TicketCategory.subscription => 'Subscription',
    TicketCategory.account => 'Account',
    TicketCategory.content => 'Content',
    TicketCategory.appBug => 'App issue',
    TicketCategory.other => 'Other',
  };

  /// The list card's meta line is terser than the detail screen's:
  /// "Billing  ·  Raised 05 Oct" versus "Billing & payments  ·  Intraday".
  String get shortLabel => switch (this) {
    TicketCategory.payments => 'Billing',
    TicketCategory.subscription => 'Subscription',
    TicketCategory.account => 'Account',
    TicketCategory.content => 'Content',
    TicketCategory.appBug => 'App issue',
    TicketCategory.other => 'Other',
  };

  static TicketCategory? fromName(String? name) =>
      _lookup(_categoryNames, name);
}

extension TicketTypeX on TicketType {
  String get wire => _typeNames[this]!;

  String get label => switch (this) {
    TicketType.issue => 'Issue',
    TicketType.question => 'Question',
    TicketType.featureRequest => 'Feature request',
    TicketType.refundRequest => 'Refund request',
  };

  static TicketType? fromName(String? name) => _lookup(_typeNames, name);
}

T? _lookup<T>(Map<T, String> names, String? wire) {
  if (wire == null) return null;
  for (final entry in names.entries) {
    if (entry.value == wire) return entry.key;
  }
  return null;
}
