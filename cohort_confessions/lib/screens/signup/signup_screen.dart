import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/signup/signup_username_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController degreeController = TextEditingController();
  final TextEditingController yearController = TextEditingController();

  // Function to handle user data addition to Firestore
  Future<void> addUserToFirestore() async {
    try {
      // Get the user details from the controllers
      String email = emailController.text;
      String password = passwordController.text;
      String degree = degreeController.text;
      String year = degreeController.text;

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('users').add({
        'name': email,
        'middleName': password,
        'lastName': degree,
        'year': year,
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
              "Hello!",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            const SizedBox(height: 16),
            const Text(
              "Please complete the following:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            const SizedBox(height: 20),
            CustomTextField(
              controller: emailController,
              label: "Email",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: "Password",
              obscureText: true,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: degreeController,
              label: "Degree",
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: "Year",
            ),
            SizedBox(height: 20),
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
              child: Text(
                "Done!",
                style: TextStyle(color: Colors.white),
              ),
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
