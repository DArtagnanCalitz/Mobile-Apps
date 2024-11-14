import 'package:flutter/material.dart';

class SignupCongratScreen extends StatelessWidget {
  const SignupCongratScreen({super.key});

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
              "Welcome to your cohort!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const Text(
              "2025 Senior",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                // addUserToFirestore();
                Navigator.pushNamed(context, '/home');
              },
              child: Text("Continue"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
