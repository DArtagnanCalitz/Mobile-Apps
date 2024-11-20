import 'package:cohort_confessions/screens/profile_page.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:transparent_image/transparent_image.dart';

class UserProfilePage extends StatelessWidget {
  const UserProfilePage({super.key, required this.username});

  final String username;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text("Cohort Confessions"),
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
                    photo: Image.memory(kTransparentImage),
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
