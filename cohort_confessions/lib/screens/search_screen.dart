import 'package:cohort_confessions/widgets/text_input.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

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
                  label: "Name", controller: TextEditingController()),
              const SizedBox(height: 16),
              CustomTextField(
                  label: "Middle Name", controller: TextEditingController()),
              const SizedBox(height: 16),
              CustomTextField(
                  label: "Last Name", controller: TextEditingController()),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement search logic here
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: const Text("Search"),
              ),
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  // Navigate to UserNotFoundScreen to create a new account
                  Navigator.pushNamed(context, '/userNotFound');
                },
                child: const Text(
                  "Skip Search",
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
