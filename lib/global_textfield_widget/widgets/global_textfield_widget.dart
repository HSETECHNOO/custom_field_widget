// import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/enums/global_textfield_enums.dart';
import 'package:global_textfield/global_textfield_widget/factory/global_textfield_input_factory.dart';
import 'package:global_textfield/global_textfield_widget/model/validation_messages.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GlobalTextField<T> extends StatelessWidget {
  final GlobalInputFieldType fieldType;
  final Function(FormControl<dynamic> control)? onChanged;
  final GlobalInputFieldDesign design;
  final FormControl<dynamic>? formController;
  final String? labelText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? helperText;
  final Map<String, String Function(Object)>? customValidationMessages;
  final bool showValidationMessages;
  final int? maxLines;
  final InputDecoration? decorationOverride;

  const GlobalTextField({
    super.key,
    required this.fieldType,
    this.onChanged,
    required this.formController,
    this.design = GlobalInputFieldDesign.standardOutlinedDesign,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.helperText,
    this.customValidationMessages,
    this.showValidationMessages = true,
    this.maxLines,
    this.decorationOverride,
  });

  @override
  Widget build(BuildContext context) {
    try {
      return _buildInputField(context);
    } catch (e, stackTrace) {
      debugPrint('Error building GlobalInputField: $e\n$stackTrace');
      return _buildErrorWidget(context, e);
    }
  }

  Widget _buildInputField(BuildContext context) {
    return _InputFieldBuilder(
      fieldType: fieldType,
      design: design,
      formController: formController,
      onChanged: onChanged,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      hintText: hintText,
      helperText: helperText,
      customValidationMessages: customValidationMessages,
      showValidationMessages: showValidationMessages,
      maxLines: maxLines,
      decorationOverride: decorationOverride,
    ).build(context);
  }

  Widget _buildErrorWidget(BuildContext context, Object error) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'Error: ${error.toString()}',
        style: const TextStyle(color: Colors.red),
      ),
    );
  }
}

class _InputFieldBuilder<T> {
  final GlobalInputFieldType fieldType;
  final GlobalInputFieldDesign design;
  final FormControl<dynamic>? formController;
  final String? labelText;

  final Function(FormControl<dynamic> control)? onChanged;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final String? helperText;
  final Map<String, String Function(Object)>? customValidationMessages;
  final bool showValidationMessages;
  final int? maxLines;
  final InputDecoration? decorationOverride;

  const _InputFieldBuilder({
    this.onChanged,
    required this.fieldType,
    required this.design,
    required this.formController,
    this.labelText,
    this.prefixIcon,
    this.suffixIcon,
    this.hintText,
    this.helperText,
    this.customValidationMessages,
    required this.showValidationMessages,
    this.maxLines,
    this.decorationOverride,
  });

  Widget build(BuildContext context) {
    final decoration = decorationOverride ?? _getInputDecoration();
    switch (fieldType) {
      case GlobalInputFieldType.text:
        return _buildTextField(decoration);
      case GlobalInputFieldType.number:
        return _buildNumberField(decoration);
      case GlobalInputFieldType.textarea:
        return _buildTextArea(decoration);
    }
  }

  InputDecoration _getInputDecoration() {
    return GlobalInputDecorationFactory.create(
      design: design,
      labelText: labelText,
      hintText: hintText,
      helperText: helperText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
    );
  }

  Map<String, String Function(Object)> _getValidationMessages() {
    if (!showValidationMessages) return {};
    return {
      ...GlobalValidationMessages.getDefaultMessages(
        fieldName: labelText ?? 'field',
        control: formController!,
      ),
      ...?customValidationMessages,
    };
  }

  Widget _buildTextField(InputDecoration decoration) {
    return ReactiveTextField(
      onChanged: onChanged,
      formControl: formController,
      decoration: decoration,
      validationMessages: _getValidationMessages(),
    );
  }

  Widget _buildNumberField(InputDecoration decoration) {
    return ReactiveTextField(
      onChanged: onChanged,
      formControl: formController,
      keyboardType: TextInputType.number,
      decoration: decoration,
      validationMessages: _getValidationMessages(),
    );
  }

  Widget _buildTextArea(InputDecoration decoration) {
    return ReactiveTextField(
      onChanged: onChanged,
      formControl: formController,
      maxLines: maxLines ?? 5,
      decoration: decoration,
      validationMessages: _getValidationMessages(),
    );
  }
}
