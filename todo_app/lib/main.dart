import 'package:flutter/material.dart';
import 'package:todo_app/keys/keys.dart';
import 'package:todo_app/add_todo_dialog.dart'; // Add this import
import 'package:todo_app/keys/priority.dart'; // Update this import

var kColorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 100, 124, 202),
);

var kDarkColorScheme = ColorScheme.fromSeed(
  brightness: Brightness.dark,
  seedColor: const Color.fromARGB(255, 5, 99, 125),
);

void main() {
  var numbers = [1, 2, 3];
  // numbers = [4, 5, 6];
  numbers.add(4);

  runApp(const App());
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  var isLightTheme = true;

  void _switchTheme() {
    setState(() {
      isLightTheme = !isLightTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: isLightTheme ? ThemeMode.light : ThemeMode.dark,
      darkTheme: ThemeData.dark().copyWith(
        colorScheme: kDarkColorScheme,
        cardTheme: const CardTheme().copyWith(
          color: kDarkColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kDarkColorScheme.primaryContainer,
            foregroundColor: kDarkColorScheme.onPrimaryContainer,
          ),
        ),
      ),
      theme: ThemeData().copyWith(
        colorScheme: kColorScheme,
        appBarTheme: const AppBarTheme().copyWith(
          backgroundColor: kColorScheme.onPrimaryContainer,
          foregroundColor: kColorScheme.primaryContainer,
        ),
        cardTheme: const CardTheme().copyWith(
          color: kColorScheme.secondaryContainer,
          margin: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: kColorScheme.primaryContainer,
          ),
        ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: const Text('TODO App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.sunny),
              tooltip: 'Switch Mode',
              onPressed: _switchTheme,
            ),
          ],
        ),
        body: const Keys(),
      ),
    );
  }
}
