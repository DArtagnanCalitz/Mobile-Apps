import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:transparent_image/transparent_image.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);

    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid) // Assuming you store user data by UID
          .get(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading profile'));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;

        // Fetch user's posts from Firestore
        return FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection('posts')
              .where('uid',
                  isEqualTo: user.uid) // Fetch posts for the logged-in user
              .get(),
          builder: (context, postSnapshot) {
            if (postSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (postSnapshot.hasError) {
              return const Center(child: Text('Error loading posts'));
            }

            final posts = postSnapshot.data!.docs;

            return ListView(
              children: [
                ProfileHeader(
                  username: user.name,
                  photo: user.photo,
                ),
                Divider(color: Colors.grey[800]),
                // Generate the list of PostCards from the posts fetched
                ...posts.map((post) {
                  final postData = post.data() as Map<String, dynamic>;
                  final postId = post.id;
                  final content = postData['content'] ?? '';
                  final upvotes = postData['upvotes'] ?? 0;
                  final downvotes = postData['downvotes'] ?? 0;
                  final comments = postData['comments'] ?? 0;
                  final weather = postData['weather'] ?? '';

                  return PostCard(
                    username: user.name,
                    photo: user.photo!, // Ensure this is the correct photo URL
                    content: content,
                    upvotes: upvotes,
                    downvotes: downvotes,
                    comments: comments,
                    weather: weather,
                    postId: postId, // Pass the postId to identify the post
                  );
                }).toList(),
              ],
            );
          },
        );
      },
    );
  }
}

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.username,
    this.photo,
  });

  final String username;
  final Image? photo;

  @override
  Widget build(BuildContext context) {
    var icon;

    if (photo == null) {
      icon = const Icon(Icons.person, size: 40, color: Colors.white);
    } else {
      icon = photo;
    }

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: Colors.grey[700],
            backgroundImage: icon.image,
          ),
          const SizedBox(height: 12),
          Text(
            username,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    '8 posts',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '8 replies',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                  SizedBox(height: 4),
                  Text(
                    '2 upvotes',
                    style: TextStyle(color: Colors.white, fontSize: 14),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
