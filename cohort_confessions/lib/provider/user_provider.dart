import 'package:cohort_confessions/models/user.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
    Image image;
    switch (id) {
      case 'dog':
        image = Image.asset('assets/images/dog.jpg');
        break;
      case 'cat':
        image = Image.asset('assets/images/cat.jpg');
        break;
      default:
        if (id.startsWith("gfs://")) {
          var path = id.substring(6);
          image = Image.network(path, errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
            return Image.asset('assets/images/undefined.webp');
          },);
        } else {
          image = Image.asset('assets/images/undefined.webp');
        }
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
