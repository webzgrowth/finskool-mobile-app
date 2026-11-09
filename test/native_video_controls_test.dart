import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/presentation/pages/feed/widgets/native_video_controls.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

void main() {
  test('formatVideoTime', () {
    expect(formatVideoTime(Duration.zero), '0:00');
    expect(formatVideoTime(const Duration(seconds: 65)), '1:05');
    expect(formatVideoTime(const Duration(minutes: 12, seconds: 9)), '12:09');
    expect(formatVideoTime(const Duration(seconds: -3)), '0:00');
  });

  Future<Map<String, int>> pump(
    WidgetTester tester, {
    bool playing = true,
    bool muted = true,
    Duration position = const Duration(seconds: 10),
    Duration duration = const Duration(seconds: 40),
    ValueChanged<Duration>? onSeekEnd,
  }) async {
    final calls = {'play': 0, 'mute': 0, 'start': 0};
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Center(
            child: SizedBox(
              width: 320,
              child: NativeVideoControls(
                position: position,
                duration: duration,
                playing: playing,
                muted: muted,
                onTogglePlay: () => calls['play'] = calls['play']! + 1,
                onToggleMute: () => calls['mute'] = calls['mute']! + 1,
                onSeekStart: () => calls['start'] = calls['start']! + 1,
                onSeekEnd: onSeekEnd ?? (_) {},
              ),
            ),
          ),
        ),
      ),
    );
    return calls;
  }

  testWidgets('shows the times and the right play/pause + speaker state', (
    tester,
  ) async {
    await pump(tester);
    expect(find.text('0:10'), findsOneWidget);
    expect(find.text('0:40'), findsOneWidget);
    expect(find.bySemanticsLabel('Pause'), findsOneWidget);
    expect(find.bySemanticsLabel('Unmute'), findsOneWidget);
    await pump(tester, playing: false, muted: false);
    expect(find.bySemanticsLabel('Play'), findsOneWidget);
    expect(find.bySemanticsLabel('Mute'), findsOneWidget);
  });

  testWidgets('the buttons report taps', (tester) async {
    final calls = await pump(tester);
    await tester.tap(find.bySemanticsLabel('Pause'));
    await tester.tap(find.bySemanticsLabel('Unmute'));
    expect(calls['play'], 1);
    expect(calls['mute'], 1);
  });

  testWidgets(
    'dragging the thumb seeks once, on release, to where it was left',
    (tester) async {
      Duration? sought;
      final calls = await pump(tester, onSeekEnd: (d) => sought = d);
      final slider = find.byType(Slider);
      final rect = tester.getRect(slider);
      await tester.dragFrom(rect.center, Offset(rect.width * 0.4, 0));
      await tester.pump();
      expect(calls['start'], 1);
      expect(sought, isNotNull);
      // Dragged right of where it started (10 s of 40 s).
      expect(sought! > const Duration(seconds: 10), isTrue);
      expect(sought! <= const Duration(seconds: 40), isTrue);
    },
  );

  testWidgets('a zero-length clip does not divide by zero', (tester) async {
    await pump(tester, position: Duration.zero, duration: Duration.zero);
    expect(tester.takeException(), isNull);
  });
}
