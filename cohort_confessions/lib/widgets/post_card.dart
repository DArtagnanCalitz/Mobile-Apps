import 'package:flutter/material.dart';

class PostCard extends StatefulWidget {
  final String username;
  final String content;
  final Image photo;
  final int upvotes;
  final int downvotes;
  final int comments;
  final String weather; // Weather info (temperature)

  const PostCard({
    super.key,
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

  // Method to handle upvote (FACTS) click
  void _incrementUpvotes() {
    setState(() {
      upvotes++;
    });
  }

  // Method to handle downvote (CAP) click
  void _incrementDownvotes() {
    setState(() {
      downvotes++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var revisions_content;
    if (widget.comments != 0) {
      revisions_content = Row(
        children: [
          Icon(Icons.edit_calendar, color: Colors.green, size: 20),
          SizedBox(width: 4),
          Text(
            widget.comments.toString(),
            style: TextStyle(color: Colors.white, fontSize: 14),
          ),
        ],
      );
    } else {
      revisions_content = Container();
    }

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
                  // child: Icon(Icons.person, color: Colors.white),
                  backgroundImage: widget.photo.image,
                ),
                SizedBox(width: 12),
                Text(
                  widget.username,
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
              widget.content,
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
                    // Make "FACTS" clickable
                    GestureDetector(
                      onTap: _incrementUpvotes,
                      child: Text(
                        "FACTS",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      upvotes.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                    SizedBox(width: 16),
                    // Make "CAP" clickable
                    GestureDetector(
                      onTap: _incrementDownvotes,
                      child: Text(
                        "CAP",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(width: 4),
                    Text(
                      downvotes.toString(),
                      style: TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ],
                ),
                Row(
                  children: [
                    if (widget.weather.isNotEmpty) ...[
                      Icon(Icons.wb_sunny, color: Colors.yellow, size: 20),
                      SizedBox(width: 4),
                      Text(
                        widget.weather,
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                    ],
                  ],
                ),
                revisions_content,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
