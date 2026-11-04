import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/performance/performance_board.dart';
import 'package:finskool/src/domain/model/performance/performance_filter.dart';
import 'package:finskool/src/domain/model/performance/performance_kind.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';

/// One page of a community's board: summary, banner and trades.
@lazySingleton
class GetPerformanceBoard {
  GetPerformanceBoard(this._repository);

  final PerformanceRepository _repository;

  Future<Either<Failure, PerformanceBoard>> execute({
    required String communityId,
    PerformanceSegment? segment,
    PerformanceMonthFilter? filter,
    String? cursor,
  }) => _repository.getBoard(
    communityId: communityId,
    segment: segment,
    filter: filter,
    cursor: cursor,
  );
}
