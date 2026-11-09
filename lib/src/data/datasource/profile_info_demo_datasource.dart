import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// Content for the Profile info screens. The About copy, the short Terms /
/// Privacy tabs and the long documents (`policy_texts/`) come from
/// "Finskool21 App – Compliance Documents" (7 Nov 2026). The **Help FAQs are
/// still invented** and must be replaced with approved copy before release.
class ProfileInfoDemoDatasource {
  ProfileInfoDemoDatasource._();

  static const sebi = SebiInfo(
    brandName: 'Finskool21',
    role: 'Research Analyst  ·  Proprietorship',
    registrationNo: 'INH000022987',
    analystName: 'Ritesh Kumar',
    designation: 'Proprietor',
    about:
        'Finskool21 is a SEBI Registered Research Analyst. Research and '
        'recommendations are shared with subscribers inside the app through '
        'its communities — Intraday, Swing Alpha and Investor.',
    phone: '+91 92113 09647',
    email: 'support@finskool21.com',
    address: 'C9 803, Srs Residency, Sector 88, Faridabad, Haryana 121002',
    mapsUrl:
        'https://www.google.com/maps/search/?api=1&query='
        'C9+803+Srs+Residency+Sector+88+Faridabad+Haryana+121002',
    disclaimer: [
      'Investment in securities market are subject to market risks. Read all '
          'the related documents carefully before investing.',
      'Registration granted by SEBI and certification from NISM in no way '
          'guarantee performance of the intermediary or provide any assurance '
          'of returns to investors.',
    ],
  );

  static const terms = LegalDocument(
    tabLabel: 'Terms of use',
    lastUpdated: '7 Nov 2026',
    minutes: 2,
    sections: [
      LegalSection(
        title: 'Using the app',
        body:
            'By creating an account you agree to these terms. The '
            'app is meant for your personal use. Do not share your '
            'login or the content of paid communities with others.',
      ),
      LegalSection(
        title: 'Subscriptions and payments',
        body:
            'Plans are billed for the period you choose at checkout. '
            'Prices include applicable taxes. Your access starts '
            'once the payment is confirmed. Plans do not renew '
            'automatically. Pay only through the app checkout, never '
            'to an individual’s account.',
      ),
      LegalSection(
        title: 'Research and recommendations',
        body:
            'Research and recommendations are shared in the '
            'communities for information. Investment in securities '
            'market are subject to market risks. Read all the '
            'related documents carefully before investing.',
      ),
      LegalSection(
        title: 'No guaranteed returns',
        body:
            'We do not promise or guarantee any returns. The '
            'decision to act on a recommendation is yours, and '
            'Finskool21 is not liable for any gains or losses from '
            'it.',
      ),
      LegalSection(
        title: 'No refunds',
        body:
            'All payments are final. Once a subscription is '
            'purchased, it cannot be cancelled and no refund will be '
            'issued.',
      ),
      LegalSection(
        title: 'Your trading account',
        body:
            'We do not manage demat or trading accounts. Never share '
            'your login, password or OTP with anyone, including our '
            'staff.',
      ),
      LegalSection(
        title: 'Changes to these terms',
        body:
            'We may update these terms from time to time. We will '
            'notify you in the app when they change.',
      ),
      LegalSection(
        title: 'Contact',
        body:
            'Write to support@finskool21.com or call +91 92113 '
            '09647. For complaints, see the Investor charter.',
      ),
    ],
  );

  static const privacy = LegalDocument(
    tabLabel: 'Privacy policy',
    lastUpdated: '7 Nov 2026',
    minutes: 2,
    sections: [
      LegalSection(
        title: 'What we collect',
        body:
            'Your name, mobile number and email, the KYC details '
            'SEBI requires, your subscription and payment records, '
            'and basic device details used to send you '
            'notifications.',
      ),
      LegalSection(
        title: 'How we use it',
        body:
            'To run your account, give you access to your '
            'communities, send post notifications, invoices and '
            'reminders, and meet our obligations under SEBI '
            'regulations.',
      ),
      LegalSection(
        title: 'Payments',
        body:
            'Payments are processed by our payment gateway, '
            'Razorpay. We do not see or store your card, UPI PIN or '
            'bank login details.',
      ),
      LegalSection(
        title: 'Who we share it with',
        body:
            'We never sell your data. We share it only with service '
            'providers who help us run the app, and with regulators '
            'when the law requires it.',
      ),
      LegalSection(
        title: 'Updates from us',
        body:
            'We may contact you by call, SMS, WhatsApp or email '
            'about our services. To stop promotional messages, write '
            'to support@finskool21.com.',
      ),
      LegalSection(
        title: 'How long we keep it',
        body:
            'We keep your data while your account is active. Records '
            'SEBI requires us to maintain are kept for the period '
            'the regulations require.',
      ),
      LegalSection(
        title: 'Deleting your account',
        body:
            'Delete your account from Profile > Delete account, or '
            'write to support@finskool21.com.',
      ),
      LegalSection(
        title: 'Contact',
        body:
            'For privacy questions, write to support@finskool21.com '
            'or call +91 92113 09647.',
      ),
    ],
  );

  static const help = HelpContent(
    phone: '+91 92113 09647',
    email: 'support@finskool21.com',
    hours: 'Mon – Sat, 10 AM – 6 PM IST',
    faqs: [
      Faq(
        question: 'How do I join a paid community?',
        answer:
            'Open the Communities tab, pick a community and choose a plan. '
            'Your access starts as soon as the payment is confirmed.',
      ),
      Faq(
        question: 'Where can I see my subscription and invoice?',
        answer:
            'Go to Profile → My Subscription and open a plan to see its '
            'dates, transaction details and invoice.',
      ),
      Faq(
        question: 'How do I cancel or renew a plan?',
        answer:
            'Open the plan under My Subscription. You can turn off renewal '
            'there, or tap Renew before it expires to extend it.',
      ),
      Faq(
        question: 'I paid but my access has not started.',
        answer:
            'Payments can take a few minutes to confirm. If it is still '
            'missing after that, raise a ticket with your payment ID and we '
            'will sort it out.',
      ),
      Faq(
        question: 'How do I change my phone number or email?',
        answer:
            'Edit them from Profile → Edit Profile. A changed phone number '
            'needs to be verified again.',
      ),
      Faq(
        question: 'How do I reach support?',
        answer:
            'Raise a ticket from My tickets and our team will reply in the '
            'chat, or call or email us using the details below.',
      ),
    ],
  );
}
