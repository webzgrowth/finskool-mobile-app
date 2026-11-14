import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/transaction/transactions_page.dart';

/// `GET /mobile/transactions`. Throws; the repository catches once.
@lazySingleton
class TransactionsRemoteDatasource {
  TransactionsRemoteDatasource(this._client);

  final ApiClient _client;

  /// Newest first. `pageSize` is capped at 50 by the server.
  Future<TransactionsPage> getPage(int page, {int pageSize = 20}) async {
    final data = await _client.get(
      Api.transactions,
      query: {'page': page, 'pageSize': pageSize},
    );
    if (data == null) throw ApiException('The server returned no payments.');
    return TransactionsPage.fromJson(data);
  }
}
