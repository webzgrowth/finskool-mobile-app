import 'package:finskool/src/domain/model/profile/profile_info.dart';

/// **Placeholder content** for the Profile info screens. About & SEBI and the
/// Terms of use copy are transcribed from Figma (`1554:8149`, `1554:8682`);
/// the Privacy policy and the Help FAQs have no design, so their text here is
/// written to look right and **must be replaced with approved copy** (the
/// legal text especially) before release.
class ProfileInfoDemoDatasource {
  ProfileInfoDemoDatasource._();

  static const sebi = SebiInfo(
    brandName: 'Finskool21',
    role: 'Research Analyst  ·  Proprietorship',
    registrationNo: 'INH000022987',
    analystName: 'Ritesh Kumar',
    designation: 'Proprietor',
    about:
        'Finskool21 shares stock market research, trade calls and learning '
        'content with members through its communities and services.',
    phone: '+91 92113 09647',
    email: 'support@finskool21.com',
    address: 'C9 803, Srs Residency, Sector 88, Faridabad, Haryana 121002',
    mapsUrl:
        'https://www.google.com/maps/search/?api=1&query='
        'C9+803+Srs+Residency+Sector+88+Faridabad+Haryana+121002',
    documents: [
      InfoDocument(title: 'Disclosures', url: 'https://www.sebi.gov.in/'),
      InfoDocument(title: 'Investor charter', url: 'https://www.sebi.gov.in/'),
      InfoDocument(
        title: 'Terms & conditions',
        route: '/profile/terms-privacy',
      ),
      InfoDocument(
        title: 'Privacy policy',
        route: '/profile/terms-privacy?tab=privacy',
      ),
    ],
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
    lastUpdated: '1 Oct 2026',
    minutes: 6,
    sections: [
      LegalSection(
        title: 'Using the app',
        body:
            'By creating an account you agree to these terms. The app is '
            'meant for your personal use. Do not share your login or the '
            'content of paid communities with others.',
      ),
      LegalSection(
        title: 'Subscriptions and payments',
        body:
            'Plans are billed for the period you choose at checkout. Prices '
            'include applicable taxes. Your access starts once the payment '
            'is confirmed.',
      ),
      LegalSection(
        title: 'Research and trade calls',
        body:
            'Research and trade calls are shared for information. Investment '
            'in securities market are subject to market risks. Read all the '
            'related documents carefully before investing.',
      ),
      LegalSection(
        title: 'Refunds and cancellations',
        body:
            'You can cancel renewal at any time from My subscription. Refund '
            'requests are reviewed as per the refund policy shared at the '
            'time of purchase.',
      ),
    ],
  );

  static const privacy = LegalDocument(
    tabLabel: 'Privacy policy',
    lastUpdated: '1 Oct 2026',
    minutes: 5,
    sections: [
      LegalSection(
        title: 'What we collect',
        body:
            'Your name, email and phone number when you sign up, the '
            'communities you join, and the details needed to verify your '
            'identity as required by SEBI.',
      ),
      LegalSection(
        title: 'How we use it',
        body:
            'To run your account, deliver research and notifications you '
            'asked for, process payments and keep the service secure. We do '
            'not sell your personal data.',
      ),
      LegalSection(
        title: 'Sharing and storage',
        body:
            'We share data only with providers that help us operate — '
            'payments, messaging and hosting — under strict confidentiality, '
            'or where the law requires it. Data is stored securely in India.',
      ),
      LegalSection(
        title: 'Your choices',
        body:
            'You can update your details from Edit Profile, turn off '
            'notifications, or write to us to access or delete your data.',
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
