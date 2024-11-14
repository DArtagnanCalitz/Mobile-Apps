import 'package:cohort_confessions/provider/user_provider.dart';
import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isLogin = true;
  String _message = '';

  Future<void> _signUp() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _message = 'Sign-up successful: ${userCredential.user?.email}';
      });
    } catch (e) {
      setState(() {
        _message = 'Sign-up failed: $e';
      });
    }
  }

  Future<void> _signIn() async {
    try {
      print(_emailController.text);
      print(_passwordController.text);
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      );
      setState(() {
        _message = 'Login successful: ${userCredential.user?.email}';
      });
      final collection = FirebaseFirestore.instance.collection('users');
      var docSnapshot = await collection.doc(userCredential.user?.uid).get();
      if (docSnapshot.exists) {
        Map<String, dynamic>? data = docSnapshot.data();
        var value = data?['name'];
        print(value);
        ref.read(userProvider.notifier).setUsername(value);
        final favoriteMeals = ref.watch(userProvider);
        print(favoriteMeals.name);
      }
      print(userCredential.user?.uid);

      // Navigate to home page after successful login
      Navigator.pushNamed(context, '/home');
    } catch (e) {
      setState(() {
        _message = 'Login failed: $e';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Padding(
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
              const SizedBox(height: 40),
              CustomTextField(
                controller: _emailController,
                label: "Email",
              ),
              const SizedBox(height: 16),
              CustomTextField(
                controller: _passwordController,
                label: "Password",
                obscureText: true,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _signIn();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("LOGIN"),
              ),
              const SizedBox(height: 10),
              Text(_message),
              TextButton(
                onPressed: () {
                  // Handle forgot password
                },
                child: const Text(
                  "Forgot Password?",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
              TextButton(
                onPressed: () {
                  // Navigate to SearchScreen for sign-up
                  Navigator.pushNamed(context, '/signup');
                },
                child: const Text(
                  "Sign Up!",
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
