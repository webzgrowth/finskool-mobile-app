import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Section 3 of "Finskool21 App – Compliance Documents" (7 Nov 2026).
const termsDocument = PolicyDocument(
  kind: PolicyKind.terms,
  title: 'Terms & conditions',
  subtitle: 'The full terms of using Finskool21',
  blocks: [
    PolicyParagraph(
      'By creating an account on, accessing or using the Finskool21 app, you '
      'agree to be bound by the following terms and conditions. If you do not '
      'agree, please do not use the app.',
    ),
    PolicyHeading('1. Our services'),
    PolicyBullets([
      'Finskool21 is a SEBI Registered Research Analyst (Registration No. '
          'INH000022987). Research and recommendations are shared inside the '
          'app through its communities: Intraday Community, Swing Alpha '
          'Community and Investor Community.',
      'Our research recommendations are based on the community and plan you '
          'subscribe to. Our research analysts conduct comprehensive analysis '
          'to generate these recommendations. However, the final decision to '
          'follow or avoid these recommendations is yours.',
      'Content shown to free members, such as past trades in the Performance '
          'section, is intended solely for demonstration purposes. The '
          'decision to act upon or disregard it rests entirely with you.',
    ]),
    PolicyHeading('2. Your account'),
    PolicyBullets([
      'You must provide accurate details when you sign up and keep them up to '
          'date.',
      'As required by SEBI, KYC must be completed for fee-paying clients '
          'before research services are provided.',
      'Your account is for your personal use only. Do not share your login or '
          'let others use your account.',
    ]),
    PolicyHeading('3. Subscriptions and payments'),
    PolicyBullets([
      'Each subscription gives access to one community for the plan period '
          'shown at checkout. The start and end dates are shown in the app '
          'under Profile > My subscription.',
      'Plans do not renew automatically. You will be reminded before your '
          'plan ends and can renew from the app.',
      'All payments must be made only through the checkout in the Finskool21 '
          'app or to the official account listed on finskool21.com, and never '
          'to any individual’s account. An invoice is issued for every '
          'payment.',
      'No employee or associate of Finskool21 is permitted to accept gifts or '
          'personal benefits from clients.',
    ]),
    PolicyHeading('4. Risk and no guarantee'),
    PolicyBullets([
      'Investing and trading in the stock market involves inherent risks. You '
          'accept full responsibility for the outcomes of your trading '
          'decisions, including any potential loss of capital.',
      'We do not offer any guaranteed returns or commit to guaranteed '
          'profits on our recommendations.',
      'Finskool21 will not be held liable for any gains or losses resulting '
          'from your decisions based on our recommendations.',
      'Finskool21 does not accept responsibility for any losses arising from '
          'market fluctuations, delays in receiving recommendations or '
          'notifications, technical issues with the app, your device or '
          'network, or any inaccuracies in the information provided.',
      'The information and recommendations in the app should not be '
          'considered a solicitation to buy or sell any securities.',
    ]),
    PolicyHeading('5. No refunds'),
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
    PolicyHeading('6. Your trading and demat accounts'),
    PolicyParagraph(
      'We do not manage demat or trading accounts. Never share your account '
      'credentials, including user ID, password, security question answers or '
      'OTPs, with any of our staff members. We will not be held responsible '
      'for any issues arising from the sharing of such details.',
    ),
    PolicyHeading('7. Confidentiality and personal use'),
    PolicyBullets([
      'All content, research and recommendations in the app are for your '
          'personal use only.',
      'Sharing, forwarding, screenshotting for distribution, reproducing or '
          'distributing any content from the app without prior written '
          'consent from Finskool21 is strictly prohibited. This applies to '
          'all employees, associates and clients.',
      'Legal action will be pursued in cases of non-compliance, and we may '
          'suspend or close the account involved.',
    ]),
    PolicyHeading('8. Changes to these terms'),
    PolicyParagraph(
      'Finskool21 reserves the right to modify these terms and conditions at '
      'any time. Changes become effective when they are published in the app, '
      'and we will notify you in the app when they change. Continuing to use '
      'the app after a change means you accept the updated terms.',
    ),
    PolicyHeading('9. Contact and grievances'),
    PolicyParagraph(
      'For any questions, write to support@finskool21.com or call +91 92113 '
      '09647. For complaints, see section D of the Investor Charter in this '
      'app.',
    ),
    PolicyParagraph(
      'By continuing to use the app, you confirm your acceptance of these '
      'terms and conditions.',
    ),
  ],
);
