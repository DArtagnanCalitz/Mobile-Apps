import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cohort_confessions/models/user.dart';
import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/screens/signup/signup_confirm_screen.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:cohort_confessions/widgets/userinfo/username.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignupUsernameScreen extends ConsumerStatefulWidget {
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

class _SignupUsernameScreenState extends ConsumerState<SignupUsernameScreen> {
  final UsernameController usernameController = UsernameController();

  // Function to handle user data addition to Firestore
  Future<void> addUserToFirestore(String name) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: widget.email,
        password: widget.password,
      );

      // Get the user details from the controllers
      String username = name.trim();
      var uid = userCredential.user?.uid;
      int year;

      try {
        year = int.parse(widget.year.trim());
        print("The number is: $year");
      } catch (e) {
        year = -1;
        usernameController.setError(e.toString());
        print("Error: $e"); // Output: Error: FormatException
      }

      // Add data to Firestore
      await FirebaseFirestore.instance.collection('users').doc(uid).set({
        'name': username.trim(),
        'degree': widget.degree.trim(),
        'year': year,
        'createdAt': FieldValue.serverTimestamp(),
      });

      var user = UserAccount(
          name: username.trim(),
          uid: uid!,
          major: widget.degree.trim(),
          year: year,
          photo: Image.asset('assets/images/undefined.webp'));

      ref.read(userProvider.notifier).setUser(user);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account created successfully!')),
      );

      // Navigate to confirmation (profile) page after successful addition
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (ctx) => SignupConfirmScreen(ref: ref),
        ),
      );
    } catch (e) {
      setState(() {
        usernameController.setError(e.toString());
      });
      print(e.runtimeType.toString());
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
            UserInfoUsername(controller: usernameController),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                String? res = await usernameController.validate();
                if (res != null) {
                  // Call the method to add user to Firestore
                  addUserToFirestore(res);
                }
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
