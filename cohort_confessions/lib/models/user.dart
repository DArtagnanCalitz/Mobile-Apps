import 'package:flutter/material.dart';

class UserAccount {
  UserAccount({
    required this.uid,
    required this.name,
    required this.major,
    required this.year,
    required this.photo,
  });

  final String uid;
  String name;
  String major;
  int year;
  Image photo;
}
