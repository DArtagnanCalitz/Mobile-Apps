import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class UsernameController {
  late Future<String?> Function() validate;
  late void Function() validateLowercase;
  late void Function() validateUsernameNotExist;
  late void Function(String) setError;
}

class UserInfoUsername extends StatefulWidget {
  const UserInfoUsername({
    super.key,
    required this.controller,
  });

  final UsernameController controller;

  @override
  State<UserInfoUsername> createState() => _UserInfoUsernameState(controller);
}

class _UserInfoUsernameState extends State<UserInfoUsername> {
  _UserInfoUsernameState(UsernameController controller) {
    controller.validate = _validate;
    controller.validateLowercase = _validateLowercase;
    controller.validateUsernameNotExist = _validateUsernameNotExist;
    controller.setError = _setError;
  }

  // String usernameController = "";
  final TextEditingController usernameController = TextEditingController();

  String? usernameErrorText;

  void _setError(String msg) {
    setState(() {
      usernameErrorText = msg;
    });
  }

  Future<String?> _validate() async {
    if (usernameController == "") {
      setState(() {
        usernameErrorText = "Username cannot be empty";
      });
      return null;
    }

    _validateLowercase();
    if (usernameErrorText != null) return null;

    await _validateUsernameNotExist();
    if (usernameErrorText != null) return null;

    return usernameController.text;
  }

  void _validateLowercase() {
    setState(() {
      if (usernameController.text.isNotEmpty &&
          usernameController.text != usernameController.text.toLowerCase()) {
        usernameErrorText = 'Text must be all lowercase';
      } else {
        usernameErrorText = null;
      }
    });
  }

  Future<void> _validateUsernameNotExist() async {
    var col = await FirebaseFirestore.instance.collection('users');
    var res = await col
        .where("name", isEqualTo: usernameController.text.trim())
        .limit(1)
        .get();
    var sent = false;
    res.docs.forEach((el) {
      if (el.exists) {
        sent = true;
      }
    });
    setState(() {
      if (sent) {
        usernameErrorText = 'Username already exists!';
      } else {
        usernameErrorText = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      controller: usernameController,
      label: "Username",
      errorText: usernameErrorText,
    );
  }
}
