import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

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
                  label: "Email", controller: TextEditingController()),
              const SizedBox(height: 16),
              CustomTextField(
                  label: "Password",
                  obscureText: true,
                  controller: TextEditingController()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to home page after successful login
                  Navigator.pushNamed(context, '/home');
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("LOGIN"),
              ),
              const SizedBox(height: 10),
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
                  Navigator.pushNamed(context, '/search');
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

class CustomTextField extends StatelessWidget {
  final String label;
  final bool obscureText;

  final dynamic controller;

  const CustomTextField(
      {super.key,
      required this.label,
      this.obscureText = false,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        filled: true,
        fillColor: Colors.grey[800],
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
      ),
    );
  }
}
