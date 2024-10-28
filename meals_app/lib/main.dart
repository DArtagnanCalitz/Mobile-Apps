import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/screens/login.dart';

import 'package:meals/screens/tabs.dart';

import 'package:firebase_core/firebase_core.dart';

final theme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    brightness: Brightness.dark,
    seedColor: const Color.fromARGB(255, 131, 57, 0),
  ),
  textTheme: GoogleFonts.latoTextTheme(),
);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    const ProviderScope(
      //to use river pods we need to wrap opur app in the ProviderScope
      child: App(),
    ),
  );
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  var isLoggedIn = false;

  void _login() {
    setState(() {
      isLoggedIn = true;
    });
    print("logged in");
  }

  void _logout() {
    setState(() {
      isLoggedIn = false;
    });
    print("logged out");
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      home: isLoggedIn
          ? TabsScreen(
              onLogout: _logout,
            )
          : AuthScreen(
              onLogin: _login,
            ),
    );
  }
}
