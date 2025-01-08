// custom_dropdown_field.dart
import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/enums/global_textfield_enums.dart';
import 'package:global_textfield/global_textfield_widget/factory/global_textfield_input_factory.dart';
import 'package:global_textfield/global_textfield_widget/model/dropdownvalue_model.dart';
import 'package:global_textfield/global_textfield_widget/model/validation_messages.dart';
import 'package:global_textfield/global_textfield_widget/widgets/global_selection_dialog.dart';
import 'package:reactive_forms/reactive_forms.dart';

class GlobalDropdownField<T> extends StatelessWidget {
  final String hint;
  final FormControl<dynamic>? formController;
  final List<GrobalDropdownItemModel<T>> items;
  final OnChangeCallback<T>? onChange;
  final Widget Function(GrobalDropdownItemModel<T> item) selectedItemBuilder;
  final String? labelText;
  final Widget? prefixIcon;
  final GlobalInputFieldDesign design;
  final Widget? suffixIcon;
  final String? hintText;
  final String? helperText;
  final Map<String, String Function(Object)>? customValidationMessages;
  final bool showValidationMessages;
  final int? maxLines;
  final InputDecoration? decorationOverride;

  const GlobalDropdownField({
    super.key,
    required this.hint,
    required this.items,
    this.onChange,
    required this.selectedItemBuilder,
    this.formController,
    required this.design,
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

  @override
  Widget build(BuildContext context) {
    final displayTextNotifier = ValueNotifier<String>('');

    GrobalDropdownItemModel<T>? getSelectedItem() {
      if (formController?.value != null) {
        return items.firstWhere(
          (item) => item.value == formController!.value,
          orElse: () => GrobalDropdownItemModel(
            name: '',
            value: '',
            data: null as T,
          ),
        );
      }
      return null;
    }

    GrobalDropdownItemModel<T>? selectedItem = getSelectedItem();
    if (selectedItem != null && selectedItem.name.isNotEmpty) {
      displayTextNotifier.value = selectedItem.name;
    }

    void updateSelectedItem(GrobalDropdownItemModel<T> selectedItem) {
      displayTextNotifier.value = selectedItem.name;
      formController?.value = selectedItem.value;
      onChange?.call(selectedItem);
    }

    void showSelectionDialog(BuildContext context) async {
      final result = await showDialog<GrobalDropdownItemModel<T>>(
        context: context,
        builder: (BuildContext context) {
          return GlobalSelectionDialog<T>(
            items: items,
            selectedItemBuilder: selectedItemBuilder,
          );
        },
      );

      if (result != null) {
        updateSelectedItem(result);
      }
    }

    InputDecoration getInputDecoration() {
      return GlobalInputDecorationFactory.create(
        design: design,
        labelText: labelText,
        hintText: hintText,
        helperText: helperText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
      );
    }

    Map<String, String Function(Object)> getValidationMessages() {
      if (!showValidationMessages) return {};
      return {
        ...GlobalValidationMessages.getDefaultMessages(
          fieldName: labelText ?? 'field',
          control: formController!,
        ),
        ...?customValidationMessages,
      };
    }

    final decoration = decorationOverride ?? getInputDecoration();

    return GestureDetector(
      onTap: () => showSelectionDialog(context),
      child: AbsorbPointer(
        child: ValueListenableBuilder<String>(
          valueListenable: displayTextNotifier,
          builder: (context, displayText, _) {
            return ReactiveDropdownField(
              items: [],
              icon: Container(),
              validationMessages: getValidationMessages(),
              formControl: formController,
              readOnly: false,
              onChanged: (value) {
                formController?.value = value;
              },
              decoration: decoration.copyWith(
                hintText: displayText.isEmpty ? hintText : displayText,
              ),
            );
          },
        ),
      ),
    );
  }
}
