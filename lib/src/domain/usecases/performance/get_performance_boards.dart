import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/domain/model/performance/performance_board_entry.dart';
import 'package:finskool/src/domain/repository/performance_repository.dart';

/// Which communities have a Performance screen.
@lazySingleton
class GetPerformanceBoards {
  GetPerformanceBoards(this._repository);

  final PerformanceRepository _repository;

  Future<Either<Failure, List<PerformanceBoardEntry>>> execute() =>
      _repository.getBoards();
}
