

class Validators {
  /// Check if email is valid
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  /// Check if passwords match
  static bool passwordsMatch(String password, String confirmedPassword) {
    return password == confirmedPassword;
  }

  /// Check if a string is not empty
  static bool isNotEmpty(String value) {
    return value.trim().isNotEmpty;
  }

/// Add other custom validations as needed...
}
