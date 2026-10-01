import 'package:reactive_forms/reactive_forms.dart';
import 'package:webspark/core/validators/validator.dart';

abstract final class AppReactiveValidatorsKeys {
  static const baseUrlKey = 'baseUrl';
}

abstract final class AppReactiveValidators {
  static Map<String, Object>? baseUrl(AbstractControl<dynamic> control) {
    final error = ((control.value as String?) ?? '').baseUrlValidation();

    return error == null ? null : {AppReactiveValidatorsKeys.baseUrlKey: error};
  }
}

abstract final class AppValidationMessages {
  static String _asString(Object e) => e.toString();

  static Map<String, ValidationMessageFunction> get defaults => {
    AppReactiveValidatorsKeys.baseUrlKey: _asString,
  };
}
