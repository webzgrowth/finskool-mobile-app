import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// The PDF has no standalone refund policy. This is its "5. No refunds" clause
/// of the Terms & Conditions (section 3 of "Finskool21 App – Compliance
/// Documents", 7 Nov 2026), verbatim, so members can open it on its own.
const refundDocument = PolicyDocument(
  kind: PolicyKind.refund,
  title: 'Refund policy',
  subtitle: 'Cancellations and refunds',
  blocks: [
    PolicyBullets([
      'All payments are final. Once a subscription is purchased, it cannot be '
          'cancelled and no refund will be issued.',
      'No refund will be provided irrespective of your satisfaction with the '
          'recommendations or the outcome of trades. Complaints or '
          'dissatisfaction about the quality of services during the paid '
          'period shall not entitle you to any refund or compensation.',
      'By making a payment in the app, you acknowledge that you have read and '
          'understood this refund policy.',
    ]),
  ],
);
