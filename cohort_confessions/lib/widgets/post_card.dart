import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String postId; // Unique post ID for Firestore
  final String username;
  final String content;
  final Image? photo;
  final int upvotes;
  final int downvotes;
  final int comments;
  final String weather; // Weather info (temperature)

  const PostCard({
    super.key,
    required this.postId,
    required this.username,
    required this.photo,
    required this.content,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
    required this.weather, // Include weather in the constructor
  });

  @override
  _PostCardState createState() => _PostCardState();
}

class _PostCardState extends State<PostCard> {
  late int upvotes;
  late int downvotes;

  @override
  void initState() {
    super.initState();
    upvotes = widget.upvotes; // Initialize with the initial upvotes
    downvotes = widget.downvotes; // Initialize with the initial downvotes
  }

  // Method to handle rating as "Fact"
  void _rateFact() {
    setState(() {
      upvotes++;
    });
    _updateRatingInFirestore("fact");
  }

  // Method to handle rating as "Cap"
  void _rateCap() {
    setState(() {
      downvotes++;
    });
    _updateRatingInFirestore("cap");
  }

  // Update Firestore with the rating
  Future<void> _updateRatingInFirestore(String rating) async {
    try {
      // Ensure postId is valid
      if (widget.postId.isEmpty) {
        print('Error: Post ID is empty.');
        return;
      }

      // Reference to the specific post document in Firestore
      final postRef =
          FirebaseFirestore.instance.collection('posts').doc(widget.postId);

      // Update the rating in Firestore (fact or cap)
      await postRef.update({
        if (rating == "fact") 'facts': FieldValue.increment(1),
        if (rating == "cap") 'caps': FieldValue.increment(1),
      });

      print('Firestore updated successfully');
    } catch (e) {
      print('Error updating Firestore: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(widget.postId),
      direction: DismissDirection.horizontal,
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          _rateFact();
        } else if (direction == DismissDirection.endToStart) {
          _rateCap();
        }
        return false; // Prevent `Dismissible` from removing the widget
      },
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.blue,
        child: const Text(
          'FACTS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        color: Colors.red,
        child: const Text(
          'CAP',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
      child: Card(
        color: Colors.grey[850], // Darker card background
        margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0), // Rounded corners
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[700],
                    radius: 20,
                    backgroundImage: widget.photo?.image ?? Image.asset('assets/images/undefined.webp').image,
                  ),
                  const SizedBox(width: 12),
                  Text(
                    widget.username,
                    style: const TextStyle(
                      color: Colors.blue,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Text(
                widget.content,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  height: 1.5, // Line height for readability
                ),
              ),
              const SizedBox(height: 12),
              Divider(color: Colors.grey[700]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(
                        "FACTS: $upvotes",
                        style:
                            const TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "CAP: $downvotes",
                        style: const TextStyle(color: Colors.red, fontSize: 14),
                      ),
                    ],
                  ),
                  // Check if the weather is not null and not empty
                  // const SizedBox(width: 120),
                  if (widget.weather != null && widget.weather.isNotEmpty) ...[
                    Row(
                      children: [
                        const Icon(Icons.wb_sunny,
                            color: Colors.yellow, size: 20),
                        const SizedBox(width: 15),
                        Text(
                          widget.weather,
                          style: const TextStyle(
                              color: Colors.white, fontSize: 14),
                        ),
                      ],
                    )
                  ],
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
