import 'package:injectable/injectable.dart';
import 'package:finskool/src/data/datasource/performance_demo_datasource.dart';
import 'package:finskool/src/domain/model/performance/performance_report.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';

@LazySingleton(as: PerformanceRepository)
class PerformanceRepositoryImpl implements PerformanceRepository {
  @override
  PerformanceReport reportFor(String communityName) =>
      PerformanceDemoDatasource.report(communityName);
}
