import 'package:finskool/src/domain/model/performance/performance_report.dart';

/// A community's trading performance. Synchronous on purpose — it is demo
/// data today. When a backend serves it, this becomes a
/// `Future<Either<Failure, …>>` and the screen gains a bloc.
abstract class PerformanceRepository {
  PerformanceReport reportFor(String communityName);
}
