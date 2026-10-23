import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:finskool/src/domain/model/service/service_model.dart';
import 'package:finskool/src/domain/model/service/service_quote_model.dart';
import 'package:finskool/src/presentation/pages/services/chat/widgets/quote_card.dart';
import 'package:finskool/src/presentation/pages/services/widgets/service_card.dart';
import 'package:finskool/src/utilities/theme/theme.dart';

ServiceQuoteModel _quote(ServiceQuoteStatus status) => ServiceQuoteModel(
  id: 'q1',
  requestId: 'r1',
  version: 2,
  baseAmount: 10000,
  gstRatePercent: 18,
  gstAmount: 1800,
  totalAmount: 11800,
  status: status,
  expiresAt: DateTime.now().toUtc().add(const Duration(days: 2)),
);

Widget _host(Widget child) => MaterialApp(
  theme: AppTheme.light,
  home: Scaffold(body: SingleChildScrollView(child: child)),
);

void main() {
  test('rupees groups Indian-style and drops empty decimals', () {
    expect(rupees(11800), '₹11,800');
    expect(rupees(1382.71), '₹1,382.71');
    expect(rupees(500000), '₹5,00,000');
  });

  testWidgets('an active quote offers Pay; a superseded one does not', (t) async {
    var paid = 0;
    await t.pumpWidget(
      _host(
        QuoteCard(
          quote: _quote(ServiceQuoteStatus.active),
          canPay: true,
          onPay: () => paid++,
        ),
      ),
    );
    expect(find.text('Pay ₹11,800'), findsOneWidget);
    await t.tap(find.text('Pay ₹11,800'));
    expect(paid, 1);

    await t.pumpWidget(
      _host(
        QuoteCard(
          quote: _quote(ServiceQuoteStatus.superseded),
          canPay: true,
          onPay: () => paid++,
        ),
      ),
    );
    expect(find.textContaining('Pay '), findsNothing);
    expect(find.text('Replaced by a newer quote'), findsOneWidget);
  });

  testWidgets('service card shows pricing-on-request and Enquire now', (t) async {
    var tapped = 0;
    await t.pumpWidget(
      _host(
        ServiceCard(
          service: const ServiceModel(
            id: 's1',
            title: 'Portfolio Analysis',
            description: 'A review of your holdings.',
          ),
          onEnquire: () => tapped++,
        ),
      ),
    );
    expect(find.text('Pricing on request'), findsOneWidget);
    expect(find.text('Portfolio Analysis'), findsOneWidget);
    await t.tap(find.text('Enquire now'));
    expect(tapped, 1);
  });
}
