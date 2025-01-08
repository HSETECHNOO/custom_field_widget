import 'package:flutter/material.dart';
import 'package:global_textfield/global_textfield_widget/example/global_textfield_example.dart';
void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
@override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Custom Input Fields')),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: MyExampleGlobalTextfield()),
      ),
    );
  }
}
