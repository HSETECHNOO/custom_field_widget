import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/enums/global_textfield_enums.dart';
import 'package:global_textfield/global_textfield_widget/model/dropdownvalue_model.dart';
import 'package:global_textfield/global_textfield_widget/widgets/global_dropdown_widget.dart';
import 'package:global_textfield/global_textfield_widget/widgets/global_textfield_widget.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GlobalField<T> {
  static Widget dropdown<T>(
      {FormControl<dynamic>? formController,
      required List<GrobalDropdownItemModel<T>> items,
      void Function(GrobalDropdownItemModel<T>?)? onChange,
      required Widget Function(GrobalDropdownItemModel<T>) selectedItemBuilder,
      required GlobalInputFieldDesign design,
      String? helperText,
      String? hintText,
      bool showValidationMessages = true,
      int? maxLines,
      InputDecoration? decorationOverride,
      Widget? suffixIcon,
      Map<String, String Function(Object)>? customValidationMessages,
      Widget? prefixIcon,
      String? labelText}) {
    return GlobalDropdownField(
        design: design,
        showValidationMessages: showValidationMessages,
        labelText: labelText,
        suffixIcon: suffixIcon,
        hintText: hintText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        decorationOverride: decorationOverride,
        maxLines: maxLines,
        customValidationMessages: customValidationMessages,
        formController: formController,
        hint: hintText ?? 'Select Item',
        items: items,
        onChange: onChange,
        selectedItemBuilder: selectedItemBuilder);
  }

  static Widget input(
      {dynamic Function(FormControl<dynamic>)? onChanged,
      required FormControl<dynamic> formController,
      required GlobalInputFieldType fieldType,
      required GlobalInputFieldDesign design,
      String? helperText,
      String? hintText,
      bool showValidationMessages = true,
      int? maxLines,
      InputDecoration? decorationOverride,
      Widget? suffixIcon,
      Map<String, String Function(Object)>? customValidationMessages,
      Widget? prefixIcon,
      String? labelText}) {
    return GlobalTextField(
      maxLines: maxLines,
      helperText: helperText,
      customValidationMessages: customValidationMessages,
      showValidationMessages: showValidationMessages,
      suffixIcon: suffixIcon,
      prefixIcon: prefixIcon,
      hintText: hintText,
      decorationOverride: decorationOverride,
      onChanged: onChanged,
      formController: formController,
      fieldType: fieldType,
      design: design,
      labelText: labelText,
    );
  }
}
