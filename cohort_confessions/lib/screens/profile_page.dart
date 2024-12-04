import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfilePage extends ConsumerStatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends ConsumerState<ProfilePage> {
  int num_facts = 0;
  int num_caps = 0;
  int num_posts = 0;
  bool hasRun = false;
  bool hasRun2 = false;

  @override
  Widget build(BuildContext context) {
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

        // TODO: cache data
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

            var content;

            if (posts.isEmpty) {
              content = const [
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(height: 120),
                      Text("You have no posts, try creating one!"),
                    ],
                  ),
                )
              ];
            } else {
              content = // Generate the list of PostCards from the posts fetched

                  posts.map((post) {
                final postData = post.data() as Map<String, dynamic>;
                final postId = post.id;
                final content = postData['content'] ?? '';
                final upvotes = postData['facts'] ?? 0;
                final downvotes = postData['caps'] ?? 0;
                final comments = postData['comments'] ?? 0;
                final weather = postData['weather'] ?? '';

                return PostCard(
                  username: user.name,
                  photo: user.photo, // Ensure this is the correct photo URL
                  content: content,
                  upvotes: upvotes,
                  downvotes: downvotes,
                  comments: comments,
                  weather: weather,
                  postId: postId, // Pass the postId to identify the post
                );
              });
            }

            return ListView(
              children: [
                ProfileHeader(
                  username: user.name,
                  photo: user.photo,
                  facts: num_facts,
                  caps: num_caps,
                  posts: num_posts,
                ),
                Divider(color: Colors.grey[800]),
                ...content,
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
    required this.facts,
    required this.caps,
    required this.posts,
    this.photo,
  });

  final String username;
  final Image? photo;
  final int facts;
  final int caps;
  final int posts;

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
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.center,
          //   children: [
          //     Column(
          //       children: [
          //         Text(
          //           '$posts posts',
          //           style: const TextStyle(color: Colors.white, fontSize: 14),
          //         ),
          //         const SizedBox(height: 4),
          //         Text(
          //           '$facts FACTS',
          //           style: const TextStyle(color: Colors.white, fontSize: 14),
          //         ),
          //         const SizedBox(height: 4),
          //         Text(
          //           '$caps CAP',
          //           style: const TextStyle(color: Colors.white, fontSize: 14),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
        ],
      ),
    );
  }
}
