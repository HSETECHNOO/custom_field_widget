// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/example/demo_lists.dart';
import 'package:global_textfield/global_textfield_widget/model/dropdownvalue_model.dart';
import 'package:global_textfield/global_textfield_widget/view/config_view.dart';
import 'package:reactive_forms/reactive_forms.dart';

import 'package:global_textfield/global_textfield_widget/enums/global_textfield_enums.dart';

class MyExampleGlobalTextfield extends StatelessWidget {
  final form = FormGroup({
    // 'textField': FormControl<String>(validators: [Validators.required]),
    // // 'numberField': FormControl<String>(
    // //     validators: [Validators.required, Validators.number()]),
    'textareaField': FormControl<String>(
      validators: [Validators.required, Validators.minLength(10)],
    ),
    'dropdownField': FormControl<String>(validators: [Validators.required]),
    'employeesField': FormControl<String>(validators: [Validators.required]),
  });

  // FormControl<String> get generalGroupTitleControl {
  //   return form.control('textField') as FormControl<String>;
  // }

  // FormControl<String> get numberGroupTitleControl {
  //   return form.control('numberField') as FormControl<String>;
  // }

  FormControl<String> get textareaGroupTitleControl {
    return form.control('textareaField') as FormControl<String>;
  }

  FormControl<String> get dropdownGroupTitleControl {
    return form.control('dropdownField') as FormControl<String>;
  }

  FormControl<String> get employeesFieldControl {
    return form.control('employeesField') as FormControl<String>;
  }

  FormControl<String> get popupMenuGroupTitleControl {
    return form.control('popupMenuField') as FormControl<String>;
  }

  TextEditingController dropdownController = TextEditingController();

  MyExampleGlobalTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    return ReactiveForm(
      formGroup: form,
      child: SingleChildScrollView(
        child: Column(
          children: [
            GlobalField.dropdown(
                design: GlobalInputFieldDesign.blueOutlinedFocusedDesign,
                labelText: '',
                prefixIcon: Icon(Icons.import_contacts),
                formController: dropdownGroupTitleControl,
                hintText: 'Select a student',
                suffixIcon: Icon(Icons.abc),
                items: schoolList
                    .map((e) => GrobalDropdownItemModel<SchoolData>(
                        name: e.name, value: e.id, data: e))
                    .toList(),
                onChange: (selectedItem) {
                  if (selectedItem != null) {
                    print('Selected student: ${selectedItem.data.name}');
                    print('Selected student: ${selectedItem.data.id}');
                    print('Selected student: ${selectedItem.data.address}');
                    print(
                        'Selected student: ${selectedItem.data.contactNumber}');
                  }
                },
                selectedItemBuilder: (item) =>
                    Row(children: [Text(item.data.name), Icon(Icons.abc)])),
            SizedBox(height: 16),
            GlobalField.dropdown(
                design: GlobalInputFieldDesign.standardOutlinedDesign,
                labelText: '',
                prefixIcon: Icon(Icons.import_contacts),
                formController: employeesFieldControl,
                hintText: 'Select a employe',
                suffixIcon: Icon(Icons.abc),
                items: employees
                    .map((e) => GrobalDropdownItemModel<EmployeeModel>(
                        name: e.name, value: e.id.toString(), data: e))
                    .toList(),
                onChange: (selectedItem) {
                  if (selectedItem != null) {
                    print('Selected employe: ${selectedItem.data.name}');
                    print('Selected employe: ${selectedItem.data.id}');
                    print('Selected employe: ${selectedItem.data.salary}');
                    print('Selected employe: ${selectedItem.data.position}');
                  }
                },
                selectedItemBuilder: (item) =>
                    Row(children: [Icon(Icons.abc), Text(item.data.name)])),
            SizedBox(height: 16),
            GlobalField.input(
              onChanged: (control) {},
              formController: textareaGroupTitleControl,
              fieldType: GlobalInputFieldType.text,
              design: GlobalInputFieldDesign.floatingLabelOutlinedDesign,
              labelText: 'Textarea Field',
            ),
            ElevatedButton(
              onPressed: () {
                if (form.valid) {
                  print('Form valid: ${form.value}');
                  print('Popup ${employeesFieldControl.value}');
                } else {
                  form.markAllAsTouched();
                }
              },
              child: const Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}
