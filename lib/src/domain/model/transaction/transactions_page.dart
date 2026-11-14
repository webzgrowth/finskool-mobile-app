import 'transaction_model.dart';

/// One page of `GET /mobile/transactions`.
class TransactionsPage {
  const TransactionsPage({
    required this.items,
    required this.page,
    required this.totalPages,
  });

  final List<TransactionModel> items;
  final int page;
  final int totalPages;

  bool get hasMore => page < totalPages;

  factory TransactionsPage.fromJson(Map<String, dynamic> json) =>
      TransactionsPage(
        items: [
          for (final row in json['items'] as List? ?? const [])
            if (row is Map<String, dynamic>) TransactionModel.fromJson(row),
        ],
        page: (json['page'] as num?)?.toInt() ?? 1,
        totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
      );
}
