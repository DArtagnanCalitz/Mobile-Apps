import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:cohort_confessions/widgets/post_card.dart';

class MainHomePage extends StatelessWidget {
  final TextEditingController postController = TextEditingController();

  // Add post to Firestore
  Future<void> addPostToFeed(String content) async {
    CollectionReference posts = FirebaseFirestore.instance.collection('posts');
    await posts.add({
      'content': content,
      'createdAt': FieldValue.serverTimestamp(),
      'name': 'Sample User', // Replace with logged-in user name or profile data
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Cohort Confessions"),
        backgroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: postController,
              decoration: InputDecoration(
                hintText: "Write your post...",
                hintStyle: TextStyle(color: Colors.grey),
                filled: true,
                fillColor: Colors.grey[900],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0)),
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              String content = postController.text;
              if (content.isNotEmpty) {
                await addPostToFeed(content);
                postController.clear(); // Clear the text field after posting
              }
            },
            child: Text("Post"),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
          ),
          Expanded(
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
                      child: Text("No posts yet",
                          style: TextStyle(color: Colors.white)));
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
                      comments: 0, // Add functionality for comments later
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
