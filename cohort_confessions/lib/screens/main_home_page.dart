import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/create_post_screen.dart';
import 'package:cohort_confessions/screens/feed_screen.dart';
import 'package:cohort_confessions/screens/profile_page.dart';
import 'package:cohort_confessions/screens/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:cohort_confessions/widgets/post_card.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({super.key});

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    if (index == 2) {
      index = _selectedPageIndex;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => CreatePostPage()),
      );
    } else if (index == 3) {
      index = _selectedPageIndex;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => SettingsPage()),
      );
    }
    setState(() {
      _selectedPageIndex = index;
      print(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget content = const FeedScreen();

    if (_selectedPageIndex == 0) {
      // content = Navigator.pushNamed(context, '/home');
    } else if (_selectedPageIndex == 1) {
      content = ProfilePage();
    }

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Cohort Confessions",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.black,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Removes the back button
      ),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.white,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline),
            label: 'New Post',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
