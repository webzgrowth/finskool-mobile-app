import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/data/datasource/performance_demo_datasource.dart';
import 'package:finskool/src/presentation/pages/dashboard/performance/performance_format.dart';

void main() {
  final report = PerformanceDemoDatasource.report('Intraday Community');

  test('headline figures match Figma', () {
    expect(report.trades.length, 27);
    expect(report.overallPnl, -186);
    expect(report.profitCount, 14);
    expect((report.profitShare * 100).toStringAsFixed(2), '51.85');
    expect((report.lossShare * 100).toStringAsFixed(2), '48.15');
  });

  test('bars scale to the larger magnitude', () {
    expect(report.chargesFraction, 1);
    expect(report.grossFraction, closeTo(0.951, 0.001));
  });

  test('trade one reproduces the expanded row', () {
    final t = report.trades.first;
    expect([t.entry, t.exit, t.perShare], [3158.68, 3176.0, 17.32]);
    expect([t.grossPnl, t.charges, t.netPnl], [1371, -140, 1231]);
    expect(t.initials, 'MF');
  });

  test('formatAmount groups thousands and keeps the sign', () {
    expect(formatAmount(-3780), '-3,780');
    expect(formatAmount(50000), '50,000');
    expect(formatAmount(562), '562');
  });
}
