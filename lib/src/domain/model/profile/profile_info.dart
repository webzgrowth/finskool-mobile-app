/// Static company/help content shown under Profile → About & SEBI info, Terms
/// & privacy policy and Help & support.
///
/// **No endpoint describes any of this yet**, so `ProfileInfoDemoDatasource`
/// supplies placeholder copy behind `ProfileInfoRepository`. These are plain
/// models so the screens won't change when a backend replaces the source.
class SebiInfo {
  const SebiInfo({
    required this.brandName,
    required this.role,
    required this.registrationNo,
    required this.analystName,
    required this.designation,
    required this.about,
    required this.phone,
    required this.email,
    required this.address,
    required this.mapsUrl,
    required this.documents,
    required this.disclaimer,
  });

  final String brandName;

  /// "Research Analyst  ·  Proprietorship"
  final String role;
  final String registrationNo;
  final String analystName;
  final String designation;
  final String about;
  final String phone;
  final String email;
  final String address;
  final String mapsUrl;
  final List<InfoDocument> documents;

  /// One paragraph per entry.
  final List<String> disclaimer;
}

/// A row under "Documents". [route] opens an in-app screen; [url] an external
/// page; both null leaves the row inert rather than a dead link.
class InfoDocument {
  const InfoDocument({required this.title, this.route, this.url});

  final String title;
  final String? route;
  final String? url;
}

/// One legal text — Terms of use, or the Privacy policy.
class LegalDocument {
  const LegalDocument({
    required this.tabLabel,
    required this.lastUpdated,
    required this.minutes,
    required this.sections,
  });

  final String tabLabel;
  final String lastUpdated;
  final int minutes;
  final List<LegalSection> sections;
}

class LegalSection {
  const LegalSection({required this.title, required this.body});

  final String title;
  final String body;
}

class HelpContent {
  const HelpContent({
    required this.faqs,
    required this.phone,
    required this.email,
    required this.hours,
  });

  final List<Faq> faqs;
  final String phone;
  final String email;

  /// "Mon – Sat, 10 AM – 6 PM IST"
  final String hours;
}

class Faq {
  const Faq({required this.question, required this.answer});

  final String question;
  final String answer;
}
