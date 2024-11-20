import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/signup/signup_confirm_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SignupUsernameScreen extends StatefulWidget {
  const SignupUsernameScreen({
    super.key,
    required this.email,
    required this.password,
    required this.degree,
    required this.year,
  });

  final String email;
  final String password;
  final String degree;
  final String year;

  @override
  _SignupUsernameScreenState createState() => _SignupUsernameScreenState();
}

class _SignupUsernameScreenState extends State<SignupUsernameScreen> {
  final TextEditingController usernameController = TextEditingController();

  // Function to handle user data addition to Firestore
  Future<void> addUserToFirestore() async {
    try {
      // Get the user details from the controllers
      String username = usernameController.text;

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'name': username,
        'degree': widget.degree,
        'year': widget.year,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Navigate to confirmation (profile) page after successful addition
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SignupConfirmScreen(),
        ),
      );
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
            const Text(
              "Cohort Confessions",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              "Please enter a username:",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: usernameController,
              label: "Username",
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                addUserToFirestore();
              },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: const Text(
                "Done!",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {
                // Navigate to SearchScreen for sign-up
                Navigator.pop(context);
              },
              child: const Text(
                "Back",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
