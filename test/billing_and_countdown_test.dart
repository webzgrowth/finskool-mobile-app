import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/service/service_payment_model.dart';
import 'package:finskool/src/presentation/pages/services/chat/widgets/quote_countdown.dart';

void main() {
  test('billing omits empty optional fields from the request body', () {
    const b = BillingDetails(
      name: 'Priya Sharma',
      stateCode: '27',
      gstin: '',
      address: null,
    );
    expect(b.toJson(), {'name': 'Priya Sharma', 'stateCode': '27'});
    const full = BillingDetails(
      name: 'P',
      stateCode: '29',
      gstin: '29AABCT1332L1ZA',
      address: '12 MG Road',
    );
    expect(full.toJson()['gstin'], '29AABCT1332L1ZA');
  });

  test('remembered billing round-trips and rejects an unusable copy', () {
    const b = BillingDetails(name: 'P', stateCode: '27', gstin: 'X');
    final back = BillingDetails.fromJson(b.toJson());
    expect(back?.name, 'P');
    expect(back?.gstin, 'X');
    expect(BillingDetails.fromJson({'name': 'only'}), isNull);
  });

  test(
    'the proof sent to /verify carries exactly the three Razorpay values',
    () {
      const p = PaymentProof(orderId: 'o', paymentId: 'p', signature: 's');
      expect(p.toJson(), {
        'razorpayOrderId': 'o',
        'razorpayPaymentId': 'p',
        'razorpaySignature': 's',
      });
    },
  );

  test('the order amount is paise, taken straight from /pay', () {
    final o = PaymentOrder.fromJson({
      'orderId': 'order_1',
      'amount': 1416000,
      'currency': 'INR',
      'keyId': 'rzp_test_x',
      'quoteId': 'q',
      'requestId': 'r',
    });
    expect(o.amountPaise, 1416000);
  });

  test('countdown wording by how long is left', () {
    expect(
      QuoteCountdown.label(const Duration(days: 4, hours: 3)),
      'Expires in 4d 3h',
    );
    expect(
      QuoteCountdown.label(const Duration(hours: 2, minutes: 10)),
      'Expires in 2h 10m',
    );
    expect(
      QuoteCountdown.label(const Duration(minutes: 12, seconds: 5)),
      'Expires in 12:05',
    );
    expect(QuoteCountdown.label(Duration.zero), 'Expiring now');
    expect(QuoteCountdown.label(const Duration(seconds: -5)), 'Expiring now');
  });
}
