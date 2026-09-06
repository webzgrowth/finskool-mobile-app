/// Shared form-field validation used by the auth blocs.
class Validators {
  Validators._();

  static final RegExp _emailRegex =
      RegExp(r'^[\w.+-]+@[\w-]+\.[a-zA-Z]{2,}$');

  static String? required(String value, String fieldLabel) {
    if (value.trim().isEmpty) return '$fieldLabel is required.';
    return null;
  }

  static String? email(String value) {
    if (value.trim().isEmpty) return 'Email is required.';
    if (!_emailRegex.hasMatch(value.trim())) {
      return 'Enter a valid email address.';
    }
    return null;
  }

  static String? password(String value) {
    if (value.isEmpty) return 'Password is required.';
    if (value.length < 8) {
      return 'Use at least 8 characters with a number and a symbol.';
    }
    return null;
  }

  static String? confirmPassword(String password, String confirmPassword) {
    if (confirmPassword.isEmpty) return 'Confirm your password.';
    if (confirmPassword != password) return 'Passwords do not match.';
    return null;
  }

  /// Validates against the selected country's actual digit count rather
  /// than a fixed guess, so e.g. a Singapore number (8 digits) and an
  /// Indian number (10 digits) are each checked correctly.
  static String? phone(String value, {required int expectedDigits}) {
    final digits = value.trim();
    if (digits.isEmpty) return 'Phone number is required.';
    if (!RegExp(r'^\d+$').hasMatch(digits)) {
      return 'Phone number must contain digits only.';
    }
    if (digits.length != expectedDigits) {
      return 'Enter a valid $expectedDigits-digit phone number.';
    }
    return null;
  }
}
