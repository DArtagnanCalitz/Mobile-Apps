import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class _FeedScreenState extends State<FeedScreen> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('createdAt', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(
              child: Text(
                "No messages in your feed",
                style: TextStyle(color: Colors.white),
              ),
            );
          }
          var posts = snapshot.data!.docs;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              var post = posts[index];
              return PostCard(
                username: '@${post['name']}',
                content: post['content'],
                upvotes: 0, // Add functionality for upvotes later
                downvotes: 0, // Add functionality for downvotes later
                comments: 0,
                weather: '', // Add functionality for comments later
              );
            },
          );
        },
      ),
    );
  }
}
