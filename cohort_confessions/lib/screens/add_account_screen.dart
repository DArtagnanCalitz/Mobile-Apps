import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/login_screen.dart';
import 'package:flutter/material.dart';

class AddAccountScreen extends StatefulWidget {
  @override
  _AddAccountScreenState createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends State<AddAccountScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  // Function to handle user data addition to Firestore
  Future<void> addUserToFirestore() async {
    try {
      // Get the user details from the controllers
      String name = nameController.text;
      String middleName = middleNameController.text;
      String lastName = lastNameController.text;

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'name': name,
        'middleName': middleName,
        'lastName': lastName,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to main home page after successful addition
      Navigator.pushReplacementNamed(context, '/home');
    } catch (e) {
      print("Error adding user: $e");
    }
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
              "Add your Account!",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            CustomTextField(
              controller: nameController,
              label: "Name",
            ),
            CustomTextField(
              controller: middleNameController,
              label: "Middle Name",
            ),
            CustomTextField(
              controller: lastNameController,
              label: "Last Name",
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                addUserToFirestore();
              },
              child: Text("Add Me!"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
