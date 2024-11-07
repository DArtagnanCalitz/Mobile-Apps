import 'package:cohort_confessions/screens/login_screen.dart';
import 'package:flutter/material.dart';

class UserFoundScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Hi, \"Name\"",
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
            SizedBox(height: 10),
            Text(
              "Please complete the following:",
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            SizedBox(height: 20),
            CustomTextField(
                label: "Email", controller: TextEditingController()),
            CustomTextField(
                label: "Password",
                obscureText: true,
                controller: TextEditingController()),
            CustomTextField(
                label: "Degree", controller: TextEditingController()),
            CustomTextField(label: "Year", controller: TextEditingController()),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to the main app or confirmation screen
              },
              child: Text("Done!"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
            ),
          ],
        ),
      ),
    );
  }
}
