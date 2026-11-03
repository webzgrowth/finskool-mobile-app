import 'package:dartz/dartz.dart';
import 'package:finskool/src/comman/failure.dart';

/// How long a screen's skeleton stays up when a load **fails fast**.
///
/// With the network off a request fails in a few milliseconds, so a refresh or
/// "Try again" flipped skeleton → error inside a frame and the skeleton never
/// registered — it looked as though nothing had been tried. Holding it for a
/// couple of seconds shows the app really did attempt the load.
///
/// Only *failures* are held. A success returns at its real speed, and a
/// failure that already took longer than this (a timeout) adds nothing.
/// Static so tests can set it to zero.
class MinSkeleton {
  MinSkeleton._();

  static Duration duration = const Duration(seconds: 2);
}

/// Runs [load] and, if it fails sooner than [MinSkeleton.duration], waits out
/// the rest of that time before returning the failure.
Future<Either<Failure, T>> holdSkeletonOnFailure<T>(
  Future<Either<Failure, T>> Function() load,
) async {
  final started = DateTime.now();
  final result = await load();
  if (result.isLeft()) {
    final left = MinSkeleton.duration - DateTime.now().difference(started);
    if (left > Duration.zero) await Future<void>.delayed(left);
  }
  return result;
}
