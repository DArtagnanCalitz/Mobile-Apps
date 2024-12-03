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

  void setImage(Image image) {
    state.photo = image;
  }

  Image parsePhotoId(String id) {
    var image;
switch (id) {
          case 'dog':
            image = Image.asset('assets/images/dog.jpg');
            break;
          case 'cat':
            image = Image.asset('assets/images/cat.jpg');
            break;
          default:
            image = Image.asset('assets/images/undefined.webp');
        }
        
  return image;
}

  UserAccount parseUser(Map<String, dynamic> data, String uid) {
        var name = data['name'];
        var year = data['year'];
        var major = data['major'];
        var photo = data['photo'];
        if (int.tryParse(year) == null) {
          throw const FormatException();
        }
        year = int.parse(year);
        if (uid == null) {
          throw const FormatException();
        }
        Image image = parsePhotoId(photo);
        var user = UserAccount(
          name: name,
          uid: uid,
          year: year,
          major: major,
          photo: image,
        );
        return user;
  }
}

final userProvider = StateNotifierProvider<UserNotifier, UserAccount>((ref) {
  return UserNotifier();
});
