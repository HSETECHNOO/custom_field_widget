import 'package:flutter/material.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GlobalValidationMessages {
  static Map<String, String Function(Object)> getDefaultMessages({
    required String fieldName,
    required FormControl control,
  }) {
    return {
      ValidationMessage.required: (_) =>
          'The ${fieldName.toLowerCase()} is required.',
      ValidationMessage.email: (_) => 'Please enter a valid email address.',
      ValidationMessage.min: (error) {
        final minValue = _getErrorValue(control, 'min', 'min');
        return 'The minimum value allowed is $minValue.';
      },
      ValidationMessage.max: (error) {
        final maxValue = _getErrorValue(control, 'max', 'max');
        return 'The maximum value allowed is $maxValue.';
      },
      ValidationMessage.minLength: (error) {
        final minLength =
            _getErrorValue(control, 'minLength', 'requiredLength');
        return 'Please enter at least $minLength characters.';
      },
      ValidationMessage.maxLength: (error) {
        final maxLength =
            _getErrorValue(control, 'maxLength', 'requiredLength');
        return 'Please enter no more than $maxLength characters.';
      },
    };
  }

  static dynamic _getErrorValue(
      FormControl control, String errorKey, String valueKey) {
    try {
      return Map.from(control.errors)[errorKey][valueKey];
    } catch (e) {
      debugPrint('Error getting validation value: $e');
      return null;
    }
  }
}
