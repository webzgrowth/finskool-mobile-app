import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Section 4 of "Finskool21 App – Compliance Documents" (7 Nov 2026).
const privacyDocument = PolicyDocument(
  kind: PolicyKind.privacy,
  title: 'Privacy policy',
  subtitle: 'What we collect and how we use it',
  blocks: [
    PolicyParagraph(
      'Welcome to Finskool21. We understand and respect your privacy, and we '
      'are committed to protecting it. This policy explains what information '
      'the Finskool21 app collects, how we use it, and the choices you have.',
    ),
    PolicyHeading('1. Information we collect'),
    PolicyBullets([
      'Account details: your name, mobile number and email address.',
      'KYC details: the details required by SEBI to complete KYC for '
          'fee-paying clients, such as your PAN, date of birth and address.',
      'Subscription and payment records: the community and plan you buy, '
          'dates, amount, invoice number and payment reference IDs. Payments '
          'are processed by our payment gateway (Razorpay). We do not see or '
          'store your card, UPI PIN or net banking credentials.',
      'Device and notification data: device model, operating system, app '
          'version and a notification token, so we can send you post '
          'notifications.',
      'Usage and diagnostics: basic in-app activity and crash reports, used '
          'to keep the app working and improve it.',
      'Support communication: messages you send to our support team.',
    ]),
    PolicyHeading('2. How we use your information'),
    PolicyBullets([
      'To create and manage your account and complete KYC.',
      'To give you access to the communities you subscribe to and send '
          'notifications about new posts.',
      'To process payments, issue invoices and send service emails (for '
          'example login codes, payment confirmations and renewal reminders).',
      'To answer your queries and resolve grievances.',
      'To meet our obligations under SEBI regulations and other applicable '
          'laws.',
      'To send you updates about new services, newsletters or surveys that we '
          'believe may be useful to you. You can opt out of these at any time '
          'by writing to support@finskool21.com.',
    ]),
    PolicyParagraph(
      'By signing up, you consent to us contacting you by phone call, SMS, '
      'WhatsApp or email on the details you provided, even if your number is '
      'registered on the National ‘Do Not Disturb’ registry.',
    ),
    PolicyHeading('3. Who we share it with'),
    PolicyParagraph(
      'We do not sell your personal information. We share it only with:',
    ),
    PolicyBullets([
      'Service providers who help us run the app, such as our payment '
          'gateway, hosting, email and notification services, only as needed '
          'to provide their service.',
      'SEBI, RAASB and other regulatory or law enforcement authorities, when '
          'required by law.',
    ]),
    PolicyHeading('4. Data retention'),
    PolicyParagraph(
      'We keep your information for as long as your account is active. '
      'Records that SEBI regulations require us to maintain (such as KYC, '
      'subscription and communication records) are kept for the period those '
      'regulations require, even after your account is closed.',
    ),
    PolicyHeading('5. Deleting your account'),
    PolicyParagraph(
      'You can delete your account from the app under Profile > Delete '
      'account, or by writing to support@finskool21.com. We will delete your '
      'personal information, except records we must keep by law, as '
      'described above.',
    ),
    PolicyHeading('6. Security'),
    PolicyParagraph(
      'We take reasonable measures to protect your information and keep it '
      'confidential. However, no method of transmission or storage is 100% '
      'secure, and we cannot guarantee absolute security.',
    ),
    PolicyHeading('7. Age'),
    PolicyParagraph('The app is meant for users aged 18 and above.'),
    PolicyHeading('8. Changes to this policy'),
    PolicyParagraph(
      'We may update this policy from time to time. We will notify you in the '
      'app when it changes.',
    ),
    PolicyHeading('9. Contact'),
    PolicyParagraph(
      'For any privacy questions or requests, write to '
      'support@finskool21.com or call +91 92113 09647.',
    ),
    PolicyParagraph(
      'Finskool21, C9 803, Srs Residency, Sector 88, Faridabad, Haryana '
      '121002',
    ),
  ],
);
