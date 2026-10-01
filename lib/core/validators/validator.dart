extension BaseUrlValidation on String {
  String? baseUrlValidation() {
    final raw = trim();
    if (raw.isEmpty) return _AppValidatorError.emptyField;

    final uri = Uri.tryParse(raw);
    if (uri == null || !uri.isAbsolute || uri.host.isEmpty) {
      return _AppValidatorError.invalidUrl;
    }

    if (!_AppUrlScheme.allowed.contains(uri.scheme)) {
      return _AppValidatorError.unsupportedScheme;
    }

    return null;
  }
}

abstract class _AppUrlScheme {
  static const allowed = {'http', 'https'};
}

abstract class _AppValidatorError {
  static const emptyField = 'This field is required';
  static const invalidUrl = 'Enter a valid URL, e.g. https://example.com';
  static const unsupportedScheme = 'URL must start with http:// or https://';
}
