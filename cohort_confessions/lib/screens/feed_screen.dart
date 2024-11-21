import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/models/post.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';

class FeedScreen extends StatefulWidget {
  const FeedScreen({super.key});

  @override
  State<FeedScreen> createState() => _FeedScreenState();
}

class PostUser {
  const PostUser({
    this.username,
    this.photo,
  });

  final String? username;
  final Image? photo;
}

class _FeedScreenState extends State<FeedScreen> {
  Map<String, PostUser> users = {}; // key: uid

  // Fetches user data from Firestore, if not already cached
  Future<PostUser> _getPostUser(String uid) async {
    if (uid == "undefined") {
      return PostUser(
        username: "ROCKBOTTOM",
        photo: Image.asset("assets/images/undefined.webp"),
      );
    }

    if (users[uid] == null) {
      final collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var name = data?['name'] ?? 'Unknown'; // Fallback if name is missing
        var photo = data?['photo'] ?? ''; // Fallback if photo is missing
        var user = PostUser(
          username: name,
          photo: photo.isNotEmpty
              ? Image.network(photo)
              : Image.asset('assets/images/placeholder.webp'),
        );
        users[uid] = user; // Cache the user data for later use
      } else {
        // Handle user not found gracefully
        return PostUser(
          username: 'Unknown User',
          photo: Image.asset('assets/images/placeholder.webp'),
        );
      }
    }
    return users[uid]!;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      // Use Column instead of Expanded directly
      children: [
        Expanded(
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('posts')
                .orderBy('createdAt', descending: true)
                .snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(
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
                  String content = post['content'];
                  String weather = post['weather'];
                  var uid = post['uid'];

                  return FutureBuilder<PostUser>(
                    future: _getPostUser(uid),
                    builder: (context, projectSnap) {
                      if (projectSnap.connectionState ==
                          ConnectionState.waiting) {
                        return const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: CircularProgressIndicator(),
                        );
                      }

                      if (projectSnap.connectionState == ConnectionState.done) {
                        if (projectSnap.hasData) {
                          var user = projectSnap.data!;
                          return PostCard(
                            username: '@${user.username}',
                            photo: user.photo!,
                            content: content,
                            upvotes: 0, // Add functionality for upvotes later
                            downvotes:
                                0, // Add functionality for downvotes later
                            comments: 0, // Add functionality for comments later
                            weather: weather,
                            postId: post.id, // Pass the real postId here
                          );
                        } else {
                          return const Center(
                              child: Text("User data not found"));
                        }
                      }

                      return const Center(child: CircularProgressIndicator());
                    },
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
