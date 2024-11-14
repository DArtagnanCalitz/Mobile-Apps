import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/login_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class UserNotFoundScreen extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // Add user to Firestore
  Future<void> addUserToFirestore(
      String name, String middleName, String lastName) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    await users.add({
      'name': name,
      'middleName': middleName,
      'lastName': lastName,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "We were unable to locate you",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            CustomTextField(label: "Name", controller: nameController),
            CustomTextField(
                label: "Middle Name", controller: middleNameController),
            CustomTextField(label: "Last Name", controller: lastNameController),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String name = nameController.text;
                String middleName = middleNameController.text;
                String lastName = lastNameController.text;
                if (name.isNotEmpty &&
                    middleName.isNotEmpty &&
                    lastName.isNotEmpty) {
                  await addUserToFirestore(name, middleName, lastName);
                  Navigator.pushNamed(context, '/home');
                }
              },
              child: Text("Add Manually"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
