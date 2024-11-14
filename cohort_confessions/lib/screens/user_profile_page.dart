import 'package:cohort_confessions/screens/profile_page.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';

class UserProfilePage extends StatelessWidget {
  final String username;

  UserProfilePage({required this.username});

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
          ProfileHeader(username: username),
          ...List.generate(
              5,
              (index) => PostCard(
                    username: username,
                    content: "User's post $index",
                    upvotes: 20,
                    downvotes: 4,
                    comments: 3,
                    weather: '',
                  )),
        ],
      ),
    );
  }
}
