import 'package:cohort_confessions/models/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<UserAccount> {
  UserNotifier()
      : super(UserAccount(
          name: "undefined",
          uid: "undefined",
          major: "undefined",
          year: -1,
          photo: Image.asset('assets/images/undefined.webp'),
        ));

  void setUser(UserAccount newUser) {
    state = newUser;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserAccount>((ref) {
  return UserNotifier();
});
