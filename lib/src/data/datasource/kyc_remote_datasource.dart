import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/exception.dart';
import 'package:finskool/src/data/api/api.dart';
import 'package:finskool/src/data/api/api_client.dart';
import 'package:finskool/src/domain/model/kyc/kyc_details.dart';
import 'package:finskool/src/domain/model/kyc/kyc_status.dart';

/// `/auth/mobile/me/kyc`. Throws; the repository catches.
///
/// `PUT` (edit) exists on the server and is not used by the app yet.
@lazySingleton
class KycRemoteDatasource {
  KycRemoteDatasource(this._client);

  final ApiClient _client;

  Future<KycStatus> getStatus() async {
    final data = await _client.get(Api.kyc);
    if (data == null) throw ApiException('The server returned no KYC status.');
    return KycStatus.fromJson(data);
  }

  Future<void> submit(KycDetails details) =>
      _client.post(Api.kyc, body: details.toJson());
}
