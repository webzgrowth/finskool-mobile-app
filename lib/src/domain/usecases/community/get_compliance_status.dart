import 'package:injectable/injectable.dart';
import 'package:finskool/src/domain/repository/communities_repository.dart';

/// Whether compliance is already done, so a second purchase can skip it.
/// Offline and synchronous — it's a local flag (see `StorageKeys`).
@lazySingleton
class GetComplianceStatus {
  GetComplianceStatus(this._repository);

  final CommunitiesRepository _repository;

  bool get isCompleted => _repository.isComplianceCompleted;
}
