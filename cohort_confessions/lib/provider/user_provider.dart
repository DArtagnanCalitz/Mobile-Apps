import 'package:cohort_confessions/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserNotifier extends StateNotifier<User> {
  UserNotifier()
      : super(const User(
          name: "undefined",
        ));

  void setUsername(String username) {
    state = User(name: username);
  }
}

final userProvider = StateNotifierProvider<UserNotifier, User>((ref) {
  return UserNotifier();
});
