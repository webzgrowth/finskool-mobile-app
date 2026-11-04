import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';

/// Implemented by `data/repository/performance_repository_impl.dart`.
abstract class PerformanceRepository {
  /// The communities that have a Performance screen.
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards();

  /// One page of a board. See `PerformanceRemoteDatasource.getBoard`.
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  });
}
