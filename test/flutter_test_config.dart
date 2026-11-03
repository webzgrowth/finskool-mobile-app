import 'dart:async';

import 'package:finskool/src/comman/min_skeleton.dart';

/// Runs before every test file. A load that fails is normally held for a couple
/// of seconds so its skeleton is seen (`MinSkeleton`); tests of failing loads
/// must not wait that long. `min_skeleton_test.dart` sets its own value.
Future<void> testExecutable(FutureOr<void> Function() testMain) async {
  MinSkeleton.duration = Duration.zero;
  await testMain();
}
