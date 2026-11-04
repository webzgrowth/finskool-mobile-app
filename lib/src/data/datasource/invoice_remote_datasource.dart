import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// `GET /payments/receipts/{id}/download`. Throws; the repository catches.
@lazySingleton
class InvoiceRemoteDatasource {
  InvoiceRemoteDatasource(this._client);

  final ApiClient _client;

  /// A signed link valid for a few minutes — request it on the tap and open it
  /// at once. A `404` means it is not this member's receipt.
  Future<InvoiceLink> getLink(String invoiceId) async {
    final data = await _client.get(Api.receiptDownload(invoiceId));
    final link = data == null ? null : InvoiceLink.fromJson(data);
    if (link == null || link.url.isEmpty) {
      throw ApiException('The server returned no invoice link.');
    }
    return link;
  }
}
