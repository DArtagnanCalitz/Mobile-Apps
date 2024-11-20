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

// todo: put this info in provider
  Future<PostUser> _getPostUser(String uid) async {
    print("test");
    print(users[uid]);
    if (users[uid] == null) {
      print("try get user");
      final collection = FirebaseFirestore.instance.collection('users');

      var docSnapshot = await collection.doc(uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var name = data?['name'];
        var year = data?['year'];
        var major = data?['major'];
        var photo = data?['photo'];
        if (int.tryParse(year) == null) {
          throw const FormatException();
        }
        year = int.parse(year);
        var user = PostUser(username: name, photo: Image.network(photo));
        users.addAll({uid: user});
        // if (uid == null) {
        //   throw const FormatException();
        // }
        // var user = UserAccount(
        //   name: name,
        //   uid: userCredential.user!.uid,
        //   year: year,
        //   major: major,
        //   photo: Image.network(photo),
        // );
      }
    } else {
      print("Saved a query!");
    }
    return users[uid]!;
  }

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
                // TODO: add button to invite people
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
              var uid = post['uid'];
              return FutureBuilder(
                future: _getPostUser(uid),
                builder: (context, projectSnap) {
                  if (projectSnap.connectionState == ConnectionState.none) {
                    return Container();
                    // TODO: fix connection state
                  }
                  if (projectSnap.connectionState == ConnectionState.done) {
                    return PostCard(
                      username: '@${users[uid]!.username}',
                      photo: users[uid]!.photo!,
                      content: content,
                      upvotes: 0, // Add functionality for upvotes later
                      downvotes: 0, // Add functionality for downvotes later
                      comments: 0,
                      weather: '', // Add functionality for comments later
                    );
                  }

                  // TODO: make this with skeleton indicator
                  return Center(child: CircularProgressIndicator());
                },
              );
            },
          );
        },
      ),
    );
  }
}
