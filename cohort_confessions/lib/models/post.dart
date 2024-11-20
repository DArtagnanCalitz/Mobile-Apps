import 'package:flutter/material.dart';

class Post {
  const Post({
    required this.username,
    required this.uid,
    required this.content,
    required this.upvotes,
    required this.downvotes,
    required this.revisions,
    required this.photo,
  });

  final String username;
  final String uid;
  final String content;
  final String upvotes;
  final String downvotes;
  final String revisions;
  final Image photo;
}
