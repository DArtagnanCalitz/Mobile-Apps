import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FeedScreen extends ConsumerStatefulWidget {
  const FeedScreen({super.key});

  @override
  _FeedScreenState createState() => _FeedScreenState();
}

class PostUser {
  const PostUser({
    this.username,
    this.photo,
  });

  final String? username;
  final Image? photo;
}

class _FeedScreenState extends ConsumerState<FeedScreen> {
  Map<String, PostUser> users = {}; // key: uid

  // Fetches user data from Firestore, if not already cached
  Future<PostUser> _getPostUser(String uid, WidgetRef ref) async {
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
        Image img = ref.read(userProvider.notifier).parsePhotoId(photo);

        var user = PostUser(
          username: name,
          photo: img,
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
                  var postData = post.data();
                  String content = post['content'];
                  String weather = post['weather'];
                  int upvotes = postData['facts'] ?? 0;
                  int downvotes = postData['caps'] ?? 0;
                  var uid = post['uid'];

                  return FutureBuilder<PostUser>(
                    future: _getPostUser(uid, ref),
                    builder: (context, projectSnap) {
                      if (projectSnap.connectionState ==
                          ConnectionState.waiting) {
                        // TODO: Should be animated based on number of connections
                        return SizedBox(height: 15);
                      }

                      if (projectSnap.connectionState == ConnectionState.done) {
                        if (projectSnap.hasData) {
                          var user = projectSnap.data!;
                          return PostCard(
                            username: '@${user.username}',
                            photo: user.photo!,
                            content: content,
                            upvotes: upvotes,
                            downvotes: downvotes,
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
