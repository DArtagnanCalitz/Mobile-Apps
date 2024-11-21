import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('posts')
            .where('uid',
                isEqualTo: username) // Assuming the posts are filtered by user
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Error loading posts'));
          }

          final posts = snapshot.data!.docs;

          return ListView(
            children: [
              ProfileHeader(username: username),
              ...posts.map((post) {
                final postData = post.data() as Map<String, dynamic>;
                final postId =
                    post.id; // Get the postId from Firestore document
                final content = postData['content'] ?? '';
                final upvotes = postData['upvotes'] ?? 0;
                final downvotes = postData['downvotes'] ?? 0;
                final comments = postData['comments'] ?? 0;
                final weather = postData['weather'] ?? '';

                return PostCard(
                  username: username,
                  photo: Image.memory(kTransparentImage),
                  content: content,
                  upvotes: upvotes,
                  downvotes: downvotes,
                  comments: comments,
                  weather: weather,
                  postId: postId, // Pass the postId to the PostCard
                );
              }).toList(),
            ],
          );
        },
      ),
    );
  }
}
