import 'package:cohort_confessions/screens/main_home_page.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Cohort Confessions"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: ListView(
        children: [
          ProfileHeader(username: "_username"),
          ...List.generate(
              5,
              (index) => PostCard(
                  username: "_username",
                  content: "Sample post $index",
                  upvotes: 15,
                  downvotes: 2,
                  comments: 1)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home, color: Colors.white),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.blue),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, color: Colors.white),
            label: '',
          ),
        ],
        onTap: (index) {
          if (index == 0) Navigator.pushNamed(context, '/home');
          if (index == 2) Navigator.pushNamed(context, '/createPost');
        },
      ),
    );
  }
}

class ProfileHeader extends StatelessWidget {
  final String username;

  ProfileHeader({required this.username});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(radius: 40, backgroundColor: Colors.grey),
          SizedBox(height: 8),
          Text(username, style: TextStyle(color: Colors.white, fontSize: 18)),
        ],
      ),
    );
  }
}
