import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/comman/failure.dart';
import 'package:finskool/src/comman/min_skeleton.dart';

void main() {
  setUp(() => MinSkeleton.duration = const Duration(milliseconds: 300));
  tearDown(() => MinSkeleton.duration = Duration.zero);

  test(
    'a failure that comes back instantly is held so the skeleton shows',
    () async {
      final sw = Stopwatch()..start();
      final r = await holdSkeletonOnFailure<int>(
        () async => const Left(ConnectionFailure('No internet connection.')),
      );
      expect(r.isLeft(), isTrue);
      expect(sw.elapsedMilliseconds, greaterThanOrEqualTo(280));
    },
  );

  test('a success is never delayed', () async {
    final sw = Stopwatch()..start();
    final r = await holdSkeletonOnFailure<int>(() async => const Right(1));
    expect(r, const Right<Failure, int>(1));
    expect(sw.elapsedMilliseconds, lessThan(150));
  });

  test('a failure that already took long adds nothing', () async {
    final sw = Stopwatch()..start();
    await holdSkeletonOnFailure<int>(() async {
      await Future<void>.delayed(const Duration(milliseconds: 350));
      return const Left(ServerFailure('timeout'));
    });
    expect(sw.elapsedMilliseconds, lessThan(450));
  });
}
