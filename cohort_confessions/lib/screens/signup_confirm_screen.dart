import 'package:cohort_confessions/screens/signup_username_screen.dart';
import 'package:flutter/material.dart';

class SignupConfirmScreen extends StatefulWidget {
  @override
  _SignupConfirmScreenState createState() => _SignupConfirmScreenState();
}

class _SignupConfirmScreenState extends State<SignupConfirmScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: double.infinity),
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
              "Please confirm your email!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              "WIP: Placeholder screen",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                // addUserToFirestore();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SignupUsernameScreen(),
                  ),
                );
              },
              child: Text("Done!"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
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
