import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/community/payment_outcome.dart';

void main() {
  String msg(String status) => '{"type":"payment","status":"$status"}';

  test('parses the three statuses the checkout page sends', () {
    expect(PaymentOutcome.parse(msg('paid')), PaymentOutcome.paid);
    expect(PaymentOutcome.parse(msg('closed')), PaymentOutcome.closed);
    expect(PaymentOutcome.parse(msg('error')), PaymentOutcome.error);
  });

  test('anything else is ignored rather than breaking the flow', () {
    expect(PaymentOutcome.parse(msg('refunded')), isNull);
    expect(PaymentOutcome.parse('{"type":"other","status":"paid"}'), isNull);
    expect(PaymentOutcome.parse('not json'), isNull);
    expect(PaymentOutcome.parse('[1,2]'), isNull);
    expect(PaymentOutcome.parse(''), isNull);
  });
}
