enum PasswordStrength {
  weak,
  medium,
  strong,
  veryStrong,
}

class PasswordValidationResult {
  final bool isValid;
  final PasswordStrength strength;
  final List<String> errorsAr;

  const PasswordValidationResult({
    required this.isValid,
    required this.strength,
    required this.errorsAr,
  });
}

class PasswordValidator {
  static const int minLength = 8;
  static const int maxLength = 64;

  static final RegExp _upperCaseRegex = RegExp(r'[A-Z]');
  static final RegExp _lowerCaseRegex = RegExp(r'[a-z]');
  static final RegExp _digitRegex = RegExp(r'[0-9]');
  static final RegExp _specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>_\-+=\[\]\\/`~]');

  static PasswordValidationResult validate(String password) {
    final List<String> errors = [];

    if (password.length < minLength) {
      errors.add("يجب ألا تقل كلمة المرور عن $minLength أحرف.");
    }
    if (password.length > maxLength) {
      errors.add("يجب ألا تتجاوز كلمة المرور $maxLength حرفاً.");
    }
    if (!_upperCaseRegex.hasMatch(password)) {
      errors.add("يجب تضمين حرف كبير واحد على الأقل (A-Z).");
    }
    if (!_lowerCaseRegex.hasMatch(password)) {
      errors.add("يجب تضمين حرف صغير واحد على الأقل (a-z).");
    }
    if (!_digitRegex.hasMatch(password)) {
      errors.add("يجب تضمين رقم واحد على الأقل (0-9).");
    }
    if (!_specialCharRegex.hasMatch(password)) {
      errors.add("يجب تضمين رمز خاص واحد على الأقل (!@#\$%^&*).");
    }

    int score = 0;
    if (password.length >= 8) score++;
    if (password.length >= 12) score++;
    if (_upperCaseRegex.hasMatch(password) && _lowerCaseRegex.hasMatch(password)) score++;
    if (_digitRegex.hasMatch(password)) score++;
    if (_specialCharRegex.hasMatch(password)) score++;

    PasswordStrength strength;
    if (score <= 2) {
      strength = PasswordStrength.weak;
    } else if (score == 3) {
      strength = PasswordStrength.medium;
    } else if (score == 4) {
      strength = PasswordStrength.strong;
    } else {
      strength = PasswordStrength.veryStrong;
    }

    return PasswordValidationResult(
      isValid: errors.isEmpty,
      strength: strength,
      errorsAr: errors,
    );
  }
}
