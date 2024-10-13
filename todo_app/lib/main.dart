import 'package:flutter/material.dart';
import 'package:todo_app/keys/keys.dart';
import 'package:todo_app/add_todo_dialog.dart'; // Add this import
import 'package:todo_app/keys/priority.dart'; // Update this import

void main() {
  var numbers = [1, 2, 3];
  // numbers = [4, 5, 6];
  numbers.add(4);

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter Internals'),
        ),
        body: const Keys(),
      ),
    );
  }
}
