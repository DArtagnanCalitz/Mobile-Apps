import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/screens/signup/signup_username_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController degreeController = TextEditingController();
  var degreeController = "Software Engineering";
  // final TextEditingController yearController = TextEditingController();
  var yearController = "2022";

  String? emailErrorText;
  String? passwordErrorText;

  // Function to handle user data addition to Firestore
  Future<void> addUserToFirestore() async {
    try {
      // Get the user details from the controllers
      String email = emailController.text;
      String password = passwordController.text;
      String degree = degreeController;
      String year = yearController;

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

  bool _isValidEmail(String email) {
    // Simple regex for email validation
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    return emailRegex.hasMatch(email);
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
              errorText: emailErrorText,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              controller: passwordController,
              label: "Password",
              obscureText: true,
              errorText: passwordErrorText,
            ),
            const SizedBox(height: 16),
            // Degree
            DropdownButton<String>(
              value: degreeController,
              items: const [
                DropdownMenuItem(
                    value: 'Software Engineering',
                    child: Text('Software Engineering')),
                DropdownMenuItem(value: 'Finance', child: Text('Finance')),
                DropdownMenuItem(value: 'Business', child: Text('Business')),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  degreeController = newValue!;
                });
              },
            ),
            const SizedBox(height: 16),
            // Year
            DropdownButton<String>(
              value: yearController,
              items: const [
                DropdownMenuItem(value: '2022', child: Text('2022')),
                DropdownMenuItem(value: '2023', child: Text('2023')),
                DropdownMenuItem(value: '2024', child: Text('2024')),
              ],
              onChanged: (String? newValue) {
                setState(() {
                  yearController = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Call the method to add user to Firestore
                // addUserToFirestore();
                // Email validation
                setState(() {
                if (!_isValidEmail(emailController.text)) {
                  emailErrorText = 'Enter a valid email address';
                } else {
                  emailErrorText = null;
                }

                // Password validation
                if (passwordController.text.length <= 5) {
                  passwordErrorText =
                      'Password must be greater than 5 characters';
                } else {
                  passwordErrorText = null;
                }
                });

                if (emailErrorText != null || passwordErrorText != null) {
                  return;
                }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => SignupUsernameScreen(
                      email: emailController.text,
                      password:
                          passwordController.text, //maybe create account here?
                      degree: degreeController,
                      year: yearController,
                    ),
                  ),
                );
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
