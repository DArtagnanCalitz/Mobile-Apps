import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  final String username;
  final String content;
  final int upvotes;
  final int downvotes;
  final int comments;
  final String weather; // Weather info (temperature)

  const PostCard({
    super.key,
    required this.username,
    required this.content,
    required this.upvotes,
    required this.downvotes,
    required this.comments,
    required this.weather, // Include weather in the constructor
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  child: Icon(Icons.person, color: Colors.white),
                ),
                SizedBox(width: 12),
                Text(
                  username,
                  style: TextStyle(
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Text(
              content,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                height: 1.5, // Line height for readability
              ),
            ),
            SizedBox(height: 12),
            Divider(color: Colors.grey[700]),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(Icons.thumb_up, color: Colors.blue, size: 20),
                    SizedBox(width: 4),
                    Text(
                      upvotes.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: 16),
                    Icon(Icons.thumb_down, color: Colors.red, size: 20),
                    SizedBox(width: 4),
                    Text(
                      downvotes.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (weather.isNotEmpty) ...[
                      Icon(Icons.wb_sunny, color: Colors.yellow, size: 20),
                      SizedBox(width: 4),
                      Text(
                        weather,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.comment, color: Colors.green, size: 20),
                    SizedBox(width: 4),
                    Text(
                      comments.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
