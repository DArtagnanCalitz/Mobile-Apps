import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/signup/signup_congrat_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

import 'signup_congrat_screen.dart';

class SignupUsernameScreen extends StatefulWidget {
  @override
  _SignupUsernameScreenState createState() => _SignupUsernameScreenState();
}

class _SignupUsernameScreenState extends State<SignupUsernameScreen> {
  final TextEditingController usernameController = TextEditingController();

  // Function to handle user data addition to Firestore
  // Future<void> addUserToFirestore() async {
  //   try {
  //     // Get the user details from the controllers
  //     String email = usernameController.text;
  //     String password = passwordController.text;
  //     String degree = degreeController.text;
  //     String year = degreeController.text;

  //     // Add data to Firestore
  //     await FirebaseFirestore.instance.collection('users').add({
  //       'name': email,
  //       'middleName': password,
  //       'lastName': degree,
  //       'year': year,
  //       'createdAt': FieldValue.serverTimestamp(),
  //     });

  //     // Navigate to main home page after successful addition
  //     Navigator.pushReplacementNamed(context, '/home');
  //   } catch (e) {
  //     print("Error adding user: $e");
  //   }
  // }

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
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                // addUserToFirestore();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SignupCongratScreen(),
                  ),
                );
              },
              child: Text("Done!"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
            TextButton(
              onPressed: () {
                // Navigate to SearchScreen for sign-up
                Navigator.pushNamed(context, '/');
              },
              child: const Text(
                "Sign In Instead",
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
