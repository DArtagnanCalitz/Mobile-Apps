import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'screens/login_screen.dart';
import 'screens/search_screen.dart';
import 'screens/user_found_screen.dart';
import 'screens/user_not_found_screen.dart';
import 'screens/add_account_screen.dart';
import 'screens/main_home_page.dart';
import 'screens/profile_page.dart';
//import 'screens/settings_page.dart'; // Add this import

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      initialRoute: '/',
      routes: {
        '/': (context) => LoginScreen(),
        '/search': (context) => SearchScreen(),
        '/userFound': (context) => UserFoundScreen(),
        '/userNotFound': (context) => UserNotFoundScreen(),
        '/addAccount': (context) => AddAccountScreen(),
        '/home': (context) => MainHomePage(),
        '/profile': (context) => ProfilePage(),
        //'/settings': (context) => SettingsPage(), // Add the settings page route
        //'/createPost': (context) => CreatePostPage(),
      },
    );
  }
}
