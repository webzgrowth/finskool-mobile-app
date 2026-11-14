import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/community/invoice_file.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';

/// `GET /payments/receipts/{id}/download`, then the PDF itself from the signed
/// link it returns. Throws; the repository catches.
@lazySingleton
class InvoiceRemoteDatasource {
  InvoiceRemoteDatasource(this._client);

  final ApiClient _client;

  /// A signed link valid for a few minutes — request it on the tap and open it
  /// at once. A `404` means it is not this member's receipt.
  Future<InvoiceLink> getLink(String invoiceId) =>
      getLinkAt(Api.receiptDownload(invoiceId));

  /// The same call, for a path the server handed over itself — a transaction's
  /// `invoice.downloadPath` — which is used as sent.
  Future<InvoiceLink> getLinkAt(String hostRootedPath) =>
      _fetchLink(Api.fromHostRoot(hostRootedPath));

  Future<InvoiceLink> _fetchLink(String path) async {
    final data = await _client.get(path);
    final link = data == null ? null : InvoiceLink.fromJson(data);
    if (link == null || link.url.isEmpty) {
      throw ApiException('The server returned no invoice link.');
    }
    return link;
  }

  /// The invoice's PDF bytes: a fresh signed link, fetched at once (it lives a
  /// few minutes) without our cookie — see [ApiClient.downloadBytes].
  Future<InvoiceFile> download(String invoiceId) =>
      _download(getLink(invoiceId));

  /// [download] for a server-supplied `downloadPath`.
  Future<InvoiceFile> downloadFromPath(String hostRootedPath) =>
      _download(getLinkAt(hostRootedPath));

  Future<InvoiceFile> _download(Future<InvoiceLink> pending) async {
    final link = await pending;
    final bytes = await ApiClient.downloadBytes(link.url);
    return InvoiceFile(fileName: link.fileName, bytes: bytes);
  }
}
