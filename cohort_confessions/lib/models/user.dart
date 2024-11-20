import 'package:flutter/material.dart';

class UserAccount {
  const UserAccount({
    required this.name,
    required this.uid,
    required this.major,
    required this.year,
    required this.photo,
  });

  final String name;
  final String uid;
  final String major;
  final int year;
  final Image photo;
}
