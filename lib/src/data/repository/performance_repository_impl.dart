import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/error_handler.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/data/datasource/performance_remote_datasource.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';

@LazySingleton(as: PerformanceRepository)
class PerformanceRepositoryImpl implements PerformanceRepository {
  PerformanceRepositoryImpl(this._remote);

  final PerformanceRemoteDatasource _remote;

  @override
  Future<Either<Failure, List<PerformanceBoardEntry>>> getBoards() =>
      handleErrors(_remote.getBoards);

  @override
  Future<Either<Failure, PerformanceBoard>> getBoard({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) => handleErrors(
    () => _remote.getBoard(
      communityId: communityId,
      segment: segment,
      filter: filter,
      cursor: cursor,
    ),
  );
}
