import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/main_home_page.dart';
import 'screens/profile_page.dart';
//import 'screens/settings_page.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/signup': (context) => SignupScreen(),
        '/home': (context) => MainHomePage(),
        '/profile': (context) => ProfilePage(),
        //'/settings': (context) => SettingsPage(), // Add the settings page route
        //'/createPost': (context) => CreatePostPage(),
      },
    );
  }
}
