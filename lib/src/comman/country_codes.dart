/// A country's dialing code, flag, and expected national mobile-number
/// length — used to validate phone numbers against the actually-selected
/// country instead of a hardcoded assumption.
class Country {
  const Country({
    required this.name,
    required this.dialCode,
    required this.flag,
    required this.digits,
  });

  final String name;
  final String dialCode;
  final String flag;

  /// Expected number of digits in the national number (typical mobile
  /// length — approximate for countries with variable-length numbers).
  final int digits;
}

/// A practical set of common countries — not the full ISO 3166 list, but
/// enough to cover the app's real userbase without bundling a dependency.
class CountryCodes {
  CountryCodes._();

  static const List<Country> all = [
    Country(name: 'India', dialCode: '+91', flag: '🇮🇳', digits: 10),
    Country(name: 'United States', dialCode: '+1', flag: '🇺🇸', digits: 10),
    Country(name: 'United Kingdom', dialCode: '+44', flag: '🇬🇧', digits: 10),
    Country(name: 'Canada', dialCode: '+1', flag: '🇨🇦', digits: 10),
    Country(name: 'Australia', dialCode: '+61', flag: '🇦🇺', digits: 9),
    Country(name: 'Germany', dialCode: '+49', flag: '🇩🇪', digits: 10),
    Country(name: 'France', dialCode: '+33', flag: '🇫🇷', digits: 9),
    Country(name: 'Italy', dialCode: '+39', flag: '🇮🇹', digits: 10),
    Country(name: 'Spain', dialCode: '+34', flag: '🇪🇸', digits: 9),
    Country(name: 'Brazil', dialCode: '+55', flag: '🇧🇷', digits: 11),
    Country(name: 'China', dialCode: '+86', flag: '🇨🇳', digits: 11),
    Country(name: 'Japan', dialCode: '+81', flag: '🇯🇵', digits: 10),
    Country(name: 'South Korea', dialCode: '+82', flag: '🇰🇷', digits: 10),
    Country(name: 'Russia', dialCode: '+7', flag: '🇷🇺', digits: 10),
    Country(name: 'South Africa', dialCode: '+27', flag: '🇿🇦', digits: 9),
    Country(name: 'Nigeria', dialCode: '+234', flag: '🇳🇬', digits: 10),
    Country(name: 'UAE', dialCode: '+971', flag: '🇦🇪', digits: 9),
    Country(name: 'Saudi Arabia', dialCode: '+966', flag: '🇸🇦', digits: 9),
    Country(name: 'Singapore', dialCode: '+65', flag: '🇸🇬', digits: 8),
    Country(name: 'Malaysia', dialCode: '+60', flag: '🇲🇾', digits: 9),
    Country(name: 'Indonesia', dialCode: '+62', flag: '🇮🇩', digits: 10),
    Country(name: 'Pakistan', dialCode: '+92', flag: '🇵🇰', digits: 10),
    Country(name: 'Bangladesh', dialCode: '+880', flag: '🇧🇩', digits: 10),
    Country(name: 'Nepal', dialCode: '+977', flag: '🇳🇵', digits: 10),
    Country(name: 'Sri Lanka', dialCode: '+94', flag: '🇱🇰', digits: 9),
  ];

  static Country byDialCode(String dialCode) => all.firstWhere(
        (c) => c.dialCode == dialCode,
        orElse: () => all.first,
      );
}
